
var features = new ol.format.GeoJSON().readFeatures(geojsonObject, {
    featureProjection: 'EPSG:3857'
});
var vectorSource = new ol.source.Vector({           
  features: features
});
var vectorLayer = new ol.layer.Vector({
    source: vectorSource,
    style: function(feature, resolution){
        return styles[feature.getGeometry().getType()];
    }
});

var map = new ol.Map({
    target: 'map',
    layers: [
        new ol.layer.Tile({
            source: new ol.source.MapQuest({layer: 'sat'})
        }),
        vectorLayer
    ],
    view: new ol.View({
        center: ol.proj.fromLonLat([21.54967, 38.70250]),
        zoom: 5
    })
});
