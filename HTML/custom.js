// Condition to determine if site has many restaurants
var isMultiRestaurant = true;

// The location of the google KML file
var kmlFile = "../template/PUK_MAP.KML.XML";

// Change this # to your minimum order amount.
var MinimumOrderAmount = 10.0

// StoreState: 0=Normal, 1=Always Open, 2=Closed, 3=Closed for Maint
var StoreState = 0;

// Redirect: Web page to redirect when the store is closed
// Is triggered when StoreState = 2
var Redirect="http://";

// MaintRedirect: Web page to redirect when store is closed for maint
// Is triggered when StoreState = 3
var MaintRedirect="http://";

// Store Hours: 0=Sunday, 6=Saturday, 24-hour clock
// Format: [OpenHour, OpenMinute, CloseHour, CloseMinute]
// Example of store that opens at 10:30am and closes at 10:00pm:
//  [10,30,20,0]
// Example of store that opens 24 hours: [0,0,0,0]
// Example of store that opens at 10:00am and closes at 2:30am
//  [10,0,2,30]
var StoreHours = [
        [12,0,21,30], //Sun
        [11,0,21,30], //Mon
        [11,0,21,30], //Tue
        [11,0,21,30], //Wed
        [11,0,21,30], //Thu
        [11,0,21,30], //Fri
        [12,0,20,00], //Sat
];

// ------------  END OF THE CONFIGURATION VARIABLES  ------------ //
// -- You should not have to change anything beyond this point -- //
// ------------  -- --- --- --- -------- --- --- --  ------------ //

xmlhttp = new XMLHttpRequest();
xmlhttp.open("GET", kmlFile, false);
xmlhttp.send();
xmlDoc = xmlhttp.responseXML;
xmlPoly = xmlDoc.getElementsByTagName("Polygon")[0];
xmlPoly = xmlPoly.getElementsByTagName("coordinates");

xmlPolyCoord = xmlPoly[0].childNodes[0].nodeValue;
arrPolyCoord = xmlPolyCoord.split(" ");

var polyCoords = [];
for ( i = 0; i < arrPolyCoord.length; i++) {
    arrItems = arrPolyCoord[i].trim().split(",");
    if (arrItems.length==3) {
        polyCoords.push(new google.maps.LatLng(arrItems[1],arrItems[0]));
    }
}

var polygon = new google.maps.Polygon({
  paths: polyCoords,  strokeColor: "#FF0000",
  strokeOpacity: 0.8,  strokeWeight: 2,
  fillColor: "#FF0000",  fillOpacity: 0.2
});

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
  if(bounds != null && !bounds.contains(latLng)) {
    return false;
  }
  var inPoly = false;
  var numPaths = this.getPaths().getLength();
  for(var p = 0; p < numPaths; p++) {
    var path = this.getPaths().getAt(p);
    var numPoints = path.getLength();
    var j = numPoints-1;
    for(var i=0; i < numPoints; i++) {
      var vertex1 = path.getAt(i);
      var vertex2 = path.getAt(j);

      if (vertex1.lng() < latLng.lng() && vertex2.lng() >= latLng.lng() || vertex2.lng() < latLng.lng() &&vertex1.lng() >= latLng.lng())  {
        if (vertex1.lat() + (latLng.lng() - vertex1.lng()) / (vertex2.lng() - vertex1.lng()) * (vertex2.lat() -vertex1.lat()) < latLng.lat()) {
          inPoly = !inPoly;
        }
      }
      j = i;
    }
  }
  return inPoly;
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
        if (polygon.containsLatLng(results[0].geometry.location)) {
            alert("You are in our delivery zone, you can now place your order for delivery")
        } else {
            alert("You are outside our delivery area, please place your order directly with the restaurant")
        }
    }
}

function PMCheckStoreHours( json ) {
	var now = new Date( json.dateString );
	var rightnow = new Date();
	var hour, min, weekday;
	var msm, msmo, msmc

	// Check the store state
	switch ( StoreState ) {
		case 1:
			return;
		case 2:
			window.location = Redirect;
			return;
		case 3:
			window.location = MaintRedirect;
			return;
		case 0:
			break;
		default:
			alert( "Unknown store state: " + StoreState );
	}

	hour = now.getHours();
	min  = now.getMinutes();
	weekday = now.getDay();
	// Is EDT?
	if ( rightnow.getTimezoneOffset() == 240 ) {
			hour++;
	}
	msm = (hour * 60) + min;
	msmo = (StoreHours[weekday][0] * 60) + StoreHours[weekday][1];
	msmc = (StoreHours[weekday][2] * 60) + StoreHours[weekday][3];
	if ( msmo == msmc ) {
		// Open 24-hours
		return;
	}
	if ( msmo < msmc ) { // Store opens and closes same day
		if ( msm >= msmo && msm < msmc ) { // Store is open
				return;
		} else {
			hideCart()
		}
	} else { // Store opens today and closes tomorrow
		if ( msm >= msmo || msm < msmc ) { // Store is open
				return;
		} else { // Store is closed. Redirect...
			hideCart()
		}
	}
}

function showCart()
{
	$('#CartHeader').show();
	$('.ProceedToCheckout').show();
}
function hideCart()
{
	$('#CartHeader').hide();
	$('.ProceedToCheckout').hide();
}

function processCartTotal(grandTotal)
{
    grandTotal= grandTotal.replace('$', '');
    grandTotal= grandTotal.replace(',', '');
    if(grandTotal >= MinimumOrderAmount) {
        showCart();
    } else {
		hideCart();
    }
}

jQuery(document).ready(function(){
	if (isMultiRestaurant) {
        setInterval('doCheckCart()', 500);
    }
});

function doCheckCart()
{
	if ($('.CartLink').text().indexOf("item") > 0) {
		displayRestaurant(getCookie("LastCateg"), "none");
	} else {
		displayRestaurant("All OK", "block");
		$('#CategoryBreadcrumb').each(function( index, domEle ) {
			aTags = domEle.getElementsByTagName("a");
			if (aTags.length > 1) {
				setCookie("LastCateg", aTags[1].textContent, 1);
			}
		});
	}
}

function displayRestaurant(r_name, dType)
{
	if (r_name != "") {
		$('.sf-with-ul').each(function( index, domEle ) {
			if ( $(domEle).text().indexOf(r_name) == 0 ) {
				$(domEle).css( "display", "block");
			} else {
				$(domEle).css( "display", dType);
			}
		});
	}
}

function getCookie(c_name)
{
	var i,x,ARRcookies=document.cookie.split(";");
	for (i=0;i<ARRcookies.length;i++)
	{
		x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		x=x.replace(/^\s+|\s+$/g,"");
		if (x==c_name)
		{
			return unescape(ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1));
		}
	}
	return ""
}

function setCookie(c_name,value,exdays)
{
	var exdate=new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var c_value=escape(value) + "; expires=" + exdate.toUTCString() + "; path=/";
	document.cookie = c_name + "=" + c_value + ";" + document.cookie;
}

function delCookie(name) {
	setCookie(name,"",-1);
}

