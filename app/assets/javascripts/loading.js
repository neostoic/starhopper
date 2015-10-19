$(document).ready(function(){

	$(".load").hide();

	$('.sub_form').click(function(){
		$(".load").show();
	})

	$('.fav_search').click(function(){
		$(".load").show();
	})

});

$(document).on('page:load', function() {

	$(".load").hide();

	$('.sub_form').click(function(){
		$(".load").show();
	})

	$('.fav_search').click(function(){
		$(".load").show();
	})

});