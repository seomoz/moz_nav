$(function(){
		   
	$('#header .dropdown').click(function(){
		
		$this = $(this);
		$this.siblings().removeClass('show-menu');
		if($this.hasClass('show-menu')){
			$this.removeClass('show-menu');
		}else{
			$this.addClass('show-menu');
		}
	});
	
/*	$(window).click(function(){
		
		$helpMenu = $('#header .dropdown');
		if($helpMenu.hasClass('show-menu')){
			$helpMenu.removeClass('show-menu');	
		}
		
	});
*/		   
});