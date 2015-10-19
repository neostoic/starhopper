$(document).ready(function(){

	$(".load").hide();

	$("#map-form").submit(function(event){
		$(".load").show();
	});

	$('.fav_search').click(function(){
		$(".load").show();
	});

});

$(document).on('page:load', function() {

	$(".load").hide();

	$("#map-form").submit(function(event){
		$(".load").show();
	});

	$('.fav_search').click(function(){
		$(".load").show();
	});

});