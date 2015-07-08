$(document).ready(function() {

	var closer = setTimeout(close,3000);

	$('.sticky-btn a').mouseover(open);

	function open(){
		clearInterval(closer);
		$('.sticky-btn a').each(function(i){
			$(this).css('bottom',(i)*60+20)
		})
		closer = setTimeout(close,3000);
	}
	function close(){
		$('.sticky-btn a').each(function(i){
			$(this).css('bottom',15)
		})
	}
});