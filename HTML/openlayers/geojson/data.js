var geojsonObject = {
    'type': 'FeatureCollection',
    'crs': {
        'type': 'name',
        'properties': {
            'name': 'EPSG:4326'
        }
    },
    'features': [
        {
            'type': 'Feature',
            'properties': {
            	'any-property': 'feature1'
            },
            'geometry': {
                'type': 'Point',
                'coordinates': [21.54967, 38.70250]
            }
        },
        {
            'type': 'Feature',
            'properties': {
            	'any-property': 'feature2'
            },
            'geometry': {
                'type': 'LineString',
                'coordinates': [
                    [21.54967, 38.70250], [22.54967, 39.70250]
                ]
            }
        }
    ]
};

var styles = {
    'Point': [new ol.style.Style({
        image: new ol.style.Circle({
            fill: new ol.style.Fill({ color: [255,255,255,1] }),
            stroke: new ol.style.Stroke({ color: [0,0,0,1] }),
            radius: 5
        })
    })],
    'LineString': [new ol.style.Style({
        stroke: new ol.style.Stroke({
            color: 'green',
            width: 5
        })
    })]
};
