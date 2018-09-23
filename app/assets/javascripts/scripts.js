$( document ).ready(function() {

	$( "span.hide-button" ).click(function() {
	  $( ".flash-messages" ).hide();
	});

	$(function() {
		$('.article-card').matchHeight();
		$('.article-photo').matchHeight();
		$('.card-title').matchHeight();
		$('.card-text').matchHeight();
	});

});