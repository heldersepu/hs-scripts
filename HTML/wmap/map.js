OpenLayers.Util.OSM = {};

OpenLayers.Layer.OSM.Map = OpenLayers.Class(OpenLayers.Layer.OSM, {
	initialize: function(name, folder, opt) {
		var url = ["http://swagger-net-test.azurewebsites.net/MapTiles/${z}/${x}/${y}"];
		opt = OpenLayers.Util.extend({numZoomLevels:19, buffer:0, transitionEffect: "resize"}, opt);
		var newArg = [name, url, opt];
		OpenLayers.Layer.OSM.prototype.initialize.apply(this, newArg);
	}, CLASS_NAME: "OpenLayers.Layer.OSM.Map"
});

// Initialization of the map
function mapInit(divName, lat, lon, zoom) {
	b = 20037508.34
	map = new OpenLayers.Map(divName, {
		controls:[
			new OpenLayers.Control.Navigation(),
			new OpenLayers.Control.PanZoomBar(),
			new OpenLayers.Control.LayerSwitcher(),
		],
		maxExtent: new OpenLayers.Bounds(-b, -b, b, b),
		maxResolution: 156543.0399, numZoomLevels: 19, units: 'm',
		projection: new OpenLayers.Projection("EPSG:900913"),
		displayProjection: new OpenLayers.Projection("EPSG:4326")
	});
	addMap_Layers();
	osmMapCenter(lat, lon, zoom);
}

// Define the map layers
function addMap_Layers() {
	layerMap = new OpenLayers.Layer.OSM.Map("Map", "tiles");
	map.addLayer(layerMap);

	//markers = new OpenLayers.Layer.Text( "Markers", { location:"markers.txt"} );
	//map.addLayer(markers);


	var start_point = new OpenLayers.Geometry.Point(0,0);
	var end_point = new OpenLayers.Geometry.Point(80,80);
	var line = new OpenLayers.Geometry.LineString([start_point, end_point]);

	var vector = new OpenLayers.Layer.Vector( "Lines" );
	vector.addFeatures([new OpenLayers.Feature.Vector(line)]);
	map.addLayer(vector);
}

// Move the center of the map to the given coordinates
function osmMapCenter(lat, lon, zoom) {
	var lonLat = new OpenLayers.LonLat(lon, lat).transform(
		new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject()
	);
	map.setCenter(lonLat, zoom);
}

function addMarker() {

}