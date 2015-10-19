$(document).ready(function(){

	$(".added").hide();

	$(".delete-fav").on("ajax:complete", function(event){   
		$(event.currentTarget).parent().slideUp(1000) 
	});

	$(".new_fav").on("ajax:complete", function(event){   
		$(event.currentTarget).hide();
		$(".added").show() 
	});

});

$(document).on('page:load', function(event) {

	$(".delete-fav").on("ajax:complete", function(event){   
		$(event.currentTarget).parent().slideUp(1000) 
	});

});