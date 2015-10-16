$(document).ready(function(){

	$(".delete-fav").on("ajax:complete", function(event){   
		$(event.currentTarget).parent().slideUp(2000) 
	});

});

$(document).on('page:load', function(event) {

	$(".delete-favs").on("ajax:complete", function(event){   
		$(event.currentTarget).parent().slideUp(2000) 
	});

});