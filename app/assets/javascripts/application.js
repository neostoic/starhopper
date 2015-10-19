//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var map;
var heatmap;


function initMap() {
  
    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 14,
      center: gon.center_point,
      mapTypeId: google.maps.MapTypeId.MAP
    });

    heatmap = new google.maps.visualization.HeatmapLayer({
      data: getPoints(),
      map: map
    });

    changeRadius();

};

function changeRadius() {
  heatmap.set('radius', heatmap.get('radius') ? null : 30);
};



function getPoints() {
  var pointsArr = []
  for (var i = 0; i < gon.coordinates.length; i++) {
    var point = new google.maps.LatLng(gon.coordinates[i].lat, gon.coordinates[i].lng);
    pointsArr.push(point)
    console.log(gon.coordinates[i].lat, gon.coordinates[i].lng)
  };
  return pointsArr
};


