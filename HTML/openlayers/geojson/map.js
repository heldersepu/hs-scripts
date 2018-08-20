
var dataLayer = new ol.layer.Vector({
    source: new ol.source.Vector({ 
        features: new ol.format.GeoJSON().readFeatures(
            geojsonObject, {featureProjection: 'EPSG:3857'}
        )
    }),
});

var map = new ol.Map({
    target: 'map',
    layers: [
        new ol.layer.Tile({
            source: new ol.source.BingMaps({layer: 'sat'})
        }),
        dataLayer
    ],
    view: new ol.View({
        center: ol.proj.fromLonLat([21, 38]), zoom: 7
    })
});
