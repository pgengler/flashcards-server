$(function() {
	$('.card').click(function() {
		var $this = $(this);
		$this.addClass('hidden').siblings('.card').removeClass('hidden');
	});
});
