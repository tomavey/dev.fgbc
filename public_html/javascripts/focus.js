function $tooltipsreg(){
		$target = $('a.popup');
		$tooltip($target);
}
	
function $tooltip($target){
	/* CONFIG */
		xOffset = 40;
		yOffset = 50;		
		// these 2 variable determine popup's distance from the cursor
		// you might want to adjust to get the right result		
	/* END CONFIG */		
	$target.hover(function(e){											  
		this.t = this.title;
		this.title = "";									  
		$("body").append("<p id='tooltip'>" + this.t + "</p>");
		$("#tooltip")
			.css("top",(e.pageY - xOffset) + "px")
			.css("left",(e.pageX + yOffset) + "px")
			.fadeIn("fast");		
    },
	function(){
		this.title = this.t;
		$("#tooltip").remove();
    });	
	$target.mousemove(function(e){
		$("#tooltip")
			.css("top",(e.pageY - xOffset) + "px")
			.css("left",(e.pageX + yOffset) + "px");
	});			
};

$(document).ready(function(){

	$tooltipsreg();

    $('.tooltip2').tooltip();
	$('.tooltip2').tooltip();
	$('.tooltipside').tooltip({placement:"right"});
	$('.tooltipleft').tooltip({placement:"left"});
	$('.tooltipbelow').tooltip({placement:"bottom"});
	$('.tooltipbottom').tooltip({placement:"bottom"});
	$('input.alertwhenselected:checkbox').click(function(){
		var $alert = this.title;
		alert($alert);
	});

});