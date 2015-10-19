$(document).ready(function(){

	$(".load").hide();

	// $(document).on('page:fetch', function(event) {
	// 	$(".load").show();
	// });

	// $(document).on('page:restore', function(event) {
	// 	$(".load").hide();
	// });

	$('.sub_form').click(function(){
		$(".load").show();
	})

	$('.fav_search').click(function(){
		$(".load").show();
	})

	$(".added").hide();

	$(".delete-fav").on("ajax:complete", function(event){   
		$(event.currentTarget).parent().slideUp(1000) 
	});

	$(".new_fav").on("ajax:complete", function(event){   
		$(event.currentTarget).hide();
		$(".added").show(); 
	});

});

$(document).on('page:load', function(event) {

	$(".load").hide();

	$('.sub_form').click(function(){
		$(".load").show();
	})

	$('.fav_search').click(function(){
		$(".load").show();
	})

	// $(document).on('page:fetch', function(event) {
	// 	$(".load").show();
	// });

	// $(document).on('page:restore', function(event) {
	// 	$(".load").hide();
	// });

	$(".delete-fav").on("ajax:complete", function(event){   
		$(event.currentTarget).parent().slideUp(1000) 
	});

});