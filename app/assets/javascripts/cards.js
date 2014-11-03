$(function() {
	$('.card').click(function() {
		$(this).closest('.flip-container').toggleClass('flipped');
	});
});
