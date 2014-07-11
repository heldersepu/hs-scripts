xmlhttp = new XMLHttpRequest();
xmlhttp.open("GET","PUK_MAP.KML.XML",false);
xmlhttp.send();
xmlPlacem = xmlhttp.responseXML.getElementsByTagName("Placemark");
var polygons = new Array();
for (x = 0; x < xmlPlacem.length; x++) {
	try {
		xmlDesc = xmlPlacem[x].getElementsByTagName("description")[0];
		xmlPoly = xmlPlacem[x].getElementsByTagName("Polygon")[0];
		xmlPoly = xmlPoly.getElementsByTagName("coordinates");

		xmlPolyCoord = xmlPoly[0].childNodes[0].nodeValue;
		arrPolyCoord = xmlPolyCoord.split(" ");
		var polyCoords = [];
		for (i = 0; i < arrPolyCoord.length; i++) {
			arrItems = arrPolyCoord[i].trim().split(",");
			if (arrItems.length==3) {
				polyCoords.push(new google.maps.LatLng(arrItems[1],arrItems[0]));
			}
		}
		var arrP = new Array(2)
		arrP[0] = new google.maps.Polygon({paths: polyCoords})
		arrP[1] = xmlDesc.textContent
		polygons.push(arrP);
	} catch(err) {}
}
var map
var infowindow

if (!google.maps.Polygon.prototype.getBounds) {
	google.maps.Polygon.prototype.getBounds = function(latLng) {
		var bounds = new google.maps.LatLngBounds();
		var paths = this.getPaths();
		var path;
		for (var p = 0; p < paths.getLength(); p++) {
			path = paths.getAt(p);
			for (var i = 0; i < path.getLength(); i++) {
				bounds.extend(path.getAt(i));
			}
		}
		return bounds;
	}
}

google.maps.Polygon.prototype.containsLatLng = function(latLng) {
	var bounds = this.getBounds();
	if(bounds != null && !bounds.contains(latLng)) {return false;}
	var inPoly = false;
	var numPaths = this.getPaths().getLength();
	for(var p = 0; p < numPaths; p++) {
		var path = this.getPaths().getAt(p);
		var numPoints = path.getLength();
		var j = numPoints-1;
		for(var i=0; i < numPoints; i++) {
			var vertex1 = path.getAt(i);
			var vertex2 = path.getAt(j);

			if (vertex1.lng() < latLng.lng() && vertex2.lng() >= latLng.lng() || vertex2.lng() < latLng.lng() && vertex1.lng() >= latLng.lng())  {
				if (vertex1.lat() + (latLng.lng() - vertex1.lng()) / (vertex2.lng() - vertex1.lng()) * (vertex2.lat() - vertex1.lat()) < latLng.lat()) {
					inPoly = !inPoly;
				}
			}
			j = i;
		}
	}
	return inPoly;
}

google.maps.Map.prototype.markers = new Array();
google.maps.Map.prototype.addMarker = function(marker) {
	this.markers[this.markers.length] = marker;
	google.maps.event.trigger(marker, 'click');
};

function loadGoogleMap(div_name, lat, lon, z)
{
	map = new google.maps.Map(document.getElementById(div_name),
		{center: new google.maps.LatLng(lat, lon), zoom: z,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		disableDefaultUI: true}
	);
	var ctaLayer = new google.maps.KmlLayer('http://hs-scripts.googlecode.com/svn/trunk/HTML/PolyContainsPoint/PUK_MAP.KML.XML');
	ctaLayer.setMap(map);
}

function checkAddress(address)
{
	geocoder = new google.maps.Geocoder();
	geocoder.geocode({'address': address}, codeAddress_callback);
	return false;
}

function codeAddress_callback(results, status)
{
	if (status == google.maps.GeocoderStatus.OK) {
		map.setCenter(results[0].geometry.location);
		map.panBy(50,-90);
		var notFound = true;
		var contentString = "<br><table><tr><th>" + results[0].formatted_address + "</th></tr><tr><td>"
		for (x = 0; x < polygons.length; x++) {
			if (polygons[x][0].containsLatLng(results[0].geometry.location)) {
				contentString += "You are in our delivery zone, you can place your order for pickup or delivery."
				contentString += "<br><br>" + polygons[x][1];
				notFound = false;
				break;
			}
		}
		if (notFound) {
			contentString += "<font color='red'>You are outside our delivery zone, but you can still place your order for pickup.</font>"
		}
		contentString += "</td></tr></table><br>"
		map.addMarker(createMarker(results[0], contentString));
	}
}

function createMarker(result, contentStr)
{
	if (infowindow) infowindow.close()
	var marker = new google.maps.Marker({
		map: map, title: result.formatted_address,
		position: result.geometry.location
	});
	google.maps.event.addListener(marker, 'click', function() {
		if (infowindow) infowindow.close()
		infowindow = new google.maps.InfoWindow({content: contentStr, maxWidth: 500});
		infowindow.open(map,marker);
	});
	return marker;
}
