
// var map;
// function initMap() {
//   map = new google.maps.Map(document.getElementById('map'), {
//     center: {lat: -34.397, lng: 150.644},
//     zoom: 8
//   });
// }

// function initMap(lat,lon) {
//   var center = new google.maps.LatLng(lat, lon)
//   var mapOptions = {
//     center: center,
//     zoom: 8
//   };
//   var map = new google.maps.Map(document.getElementById('map'));
// }

var map;
function initMap(lat, long) {
  console.log(lat, long);
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: lat, lng: long},
    zoom: 16
  });

  var locationCircle = new google.maps.Circle({
    strokeColor: '#f0ad4e',
    strokeOpacity: 0.5,
    strokeWeight: 1,
    fillColor: '#f0ad4e',
    fillOpacity: 0.36,
    map: map,
    center: {lat: lat, lng: long},
    radius: 100
  });
}
