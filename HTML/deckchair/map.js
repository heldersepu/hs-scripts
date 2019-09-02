$.ajax({
    type: "GET",
    url: "https://api.deckchair.com/v1/cameras/",
    cache: false,
    success: successFunc,
    error: errorFunc
});

function successFunc(resp) {
    var map = new google.maps.Map(
        document.getElementById('map'),
        {zoom: 5, center: {lat: 26.98, lng: -80.78}});
    resp.data.forEach(x => {
        coord = x.location.loc.coordinates
        loc = {lat: coord[0], lng: coord[1]};
        var marker = new google.maps.Marker({position: loc, map: map});
        var infowindow = new google.maps.InfoWindow({
            content: x.description + "<br>" + 
            "<a href='https://camera.deckchair.com/webcam/" + x.tag + "'>https://camera.deckchair.com/webcam/" + x.tag + "</a>"
        });
        marker.addListener('click', function() {
            infowindow.open(map, marker);
        });
    });
    
}

function errorFunc(err) {
    if (err.responseText === "")
        alert("Sorry the communication failed.");
    else
        alert(err.responseText);
}