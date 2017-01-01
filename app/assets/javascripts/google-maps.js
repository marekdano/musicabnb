

var map;
function initMap(lat, long) {
  console.log(lat, long);
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: lat, lng: long},
    zoom: 16,
    scrollwheel: false
  });

  if(lat !== 0) {
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
}
