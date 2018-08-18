var geojsonObject = {
  'type': 'FeatureCollection',
  'crs': { 'type': 'name', 'properties': {'name': 'EPSG:4326'}},
  'features': [
    {
      'type': 'Feature', 'properties': {'any-property': 'feature1'},
      'geometry': {
        'type': 'Point',
        'coordinates': [21, 38]
      }
    },
    {
      'type': 'Feature', 'properties': {'any-property': 'feature2'},
      'geometry': {
        'type': 'LineString',
        'coordinates': [
          [21, 38], [22, 39], [22, 40],
          [21, 38.5], [20.5, 39.5], [22.3, -40],
        ]
      }
    }
  ]
};


