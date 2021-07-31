// Eventify, Responsive HTML5 Event Template - Version 1.1 //
/*functions for tool tips on links*/
function $tooltiplink(){
		$target = $('a.tooltiplink');
		$tooltip($target);
};

function $tooltip($target){
	/* CONFIG */
		xOffset = 25;
		yOffset = 30;
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

function $hidealloptions(){
	$meals.hide();
	$childcare.hide();
	$kidskonference.hide();
	$otheroptions.hide();
	}

// Javascripts //
$(document).ready(function () {

	$registrationOption = $("fieldset#registrationOption");
	$meals = $("fieldset#meals");
	$childcare = $("fieldset#childcare");
	$kidskonference = $("fieldset#kidskonference");
	$otheroptions = $("fieldset#otheroptions");

	$nurseryinput  = $("input.GraceKids-Nursery");

	console.log($nurseryinput);

	$("input.GraceKids-Preschool:radio,input.GraceKids-Nursery:radio").click(function(){
		$hidealloptions();
		$childcare.show();
		$.scrollTo($childcare,{duration:2000},{offset:150});
	});

	$("input.GraceKids-Elementary:radio").click(function(){
		$hidealloptions();
		$childcare.show();
		$kidskonference.show();
		$.scrollTo($childcare,{duration:2000},{offset:150});
	});

	$("input.Registration-Single:radio, input.Registration-Couple:radio").click(function(){
		$hidealloptions();
		$meals.show();
		$otheroptions.show();
		$.scrollTo($meals,{duration:2000},{offset:150});
	})

	$tooltiplink();

	$("select#375").focus(function(){
		$("label[for='375']").css({"color":"blue","font-weight":"bold"}).text("Only one ticket is needed for each couple!");
	})


})