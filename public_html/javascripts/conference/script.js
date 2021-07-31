// JavaScript Document

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

function $uncheckAllChildrenOptions(){
	$("#childcare input").attr("checked",false);
	}

function $uncheckAllKidsKonferenceOptions(){
	$("#kidskonference input").attr("checked",false);
	}

<!---I check all the boxs during selection options--->
function $checkall(){
	$('.checkall').click(function () {
		$(this).parents('fieldset:eq(0)').find(':checkbox').prop('checked', this.checked);
	});
};

function $mealspackage(){
	$('div.allmeals select').change(function () {
		var $val = $(this).val();
		$(this).parents('fieldset:eq(0)').find('option[value="' + $val + '"]').attr("selected","selected");
	});
};

function $ajaxdelete(){
	$('a.ajaxdelete').click(function(){
	var $bordercolor = $(this).css("border-color");
	$(this).parents(".ajaxdelete").css("border-color", "red").css("opacity","0.4");
	var $hreflink = $(this).attr("href");
	if (confirm('Are you sure you want to delete this? NO TURNING BACK!' + " " +$hreflink))
		{	$.get($hreflink);
			$(this).parents(".ajaxdelete").fadeOut(2000).empty().append('<span style="color:red;font-weight:bold">BYE...BYE!</span>')
		}
		else
		{	$(this).parents(".ajaxdelete").css("border-color", $bordercolor).css("opacity","1.0")
		}
	return false;
	});
}

function $ajaxdeleterow(){
	$('a.ajaxdeleterow').click(function(){
	var $bordercolor = $(this).css("border-color");
	$(this).parent().parent().css("border-color", "red").css("opacity","0.4");
	var $hreflink = $(this).attr("href");
	if (confirm('Are you sure you want to delete this? NO TURNING BACK!' + " " +$hreflink))
		{	$.get($hreflink);
			$(this).parent().parent().fadeOut(2000).empty().append('<span style="color:red;font-weight:bold">BYE...BYE!</span>')
		}
		else
		{	$(this).parent().parent().css("border-color", $bordercolor).css("opacity","1.0")
		}
	return false;
	});
}

function $hidealloptions(){
	$meals.hide();
	$childcare.hide();
	$kidskonference.hide();
	$preconference.hide();
	$otheroptions.hide();
	$wickham.hide();
	}

function $alert(){
	alert("loaded");
	console:log("loaded");
}

function $clearAllSelections(){
	$(".clearAllSelections").click(function(){
		console.log('clearAllSelections')
		$('input[type=checkbox]').removeAttr('checked').removeAttr('disabled').next().removeAttr('class').text("");
	    $("div.cohortmessage").html("Choices have been cleared");
	})	
};

function $selectcohortchecked(){
	var $totalCohortsAllowed = 3;
	var $numberOfCohortsSelected = $('form.cohortcheckbox input[type=checkbox]:checked').length;
	var $numberOfCohortsRemaining = $totalCohortsAllowed - $numberOfCohortsSelected; 
	var initialMessage = 'Currently ' + $numberOfCohortsSelected + ' cohorts are selected. Please select ' + $numberOfCohortsRemaining + ' more. ';
	if ($numberOfCohortsRemaining == 0) {
		initialMessage = $numberOfCohortsSelected + ' cohorts are selected.';
	}
    $("div.cohortmessage").html(initialMessage);
	$('form.cohortcheckbox input[type=checkbox]').change(function(){
		var $this = (this);
		var $cohortsSelected = $('form.cohortcheckbox input[type=checkbox]:checked');
		var $numberOfCohortsSelected = $cohortsSelected.length;
		var $cohortSubmitButton = $('.cohortsubmit');
		// var $aCohorts = $('form.cohortcheckbox .subtype-A');
		// var $aCohortsCheckbox = $('form.cohortcheckbox .subtype-A:checkbox');
		// var $bCohorts = $('form.cohortcheckbox .subtype-B');
		// var $bCohortsCheckbox = $('form.cohortcheckbox .subtype-B:checkbox');
		// var $cCohorts = $('form.cohortcheckbox .subtype-C');
		// var $cCohortsCheckbox = $('form.cohortcheckbox .subtype-C:checkbox');
		// var $dCohorts = $('form.cohortcheckbox .subtype-D');
		// var $dCohortsCheckbox = $('form.cohortcheckbox .subtype-D:checkbox');
		var $aCohortsCheckboxUnchecked = $('form.cohortcheckbox .subtype-A:checkbox:not(:checked)');
		var $bCohortsCheckboxUnchecked = $('form.cohortcheckbox .subtype-B:checkbox:not(:checked)');
		var $cCohortsCheckboxUnchecked = $('form.cohortcheckbox .subtype-C:checkbox:not(:checked)');
		var $dCohortsCheckboxUnchecked = $('form.cohortcheckbox .subtype-D:checkbox:not(:checked)');

		var $numberOfACohortsSelected = $('form.cohortcheckbox .subtype-A:checkbox:checked').length;
		// console.log("A Cohorts: " + $numberOfACohortsSelected);
		var $numberOfBCohortsSelected = $('form.cohortcheckbox .subtype-B:checkbox:checked').length;
		// console.log("B Cohorts: " + $numberOfBCohortsSelected);
		var $numberOfCCohortsSelected = $('form.cohortcheckbox .subtype-C:checkbox:checked').length;
		// console.log("C Cohorts: " + $numberOfCCohortsSelected);
		var $numberOfDCohortsSelected = $('form.cohortcheckbox .subtype-D:checkbox:checked').length;
		// console.log("D Cohorts: " + $numberOfDCohortsSelected);

		var $numberOfCohortsRemaining = $totalCohortsAllowed - $numberOfCohortsSelected; 
		// console.log("$numberOfCohortsRemaining: " + $numberOfCohortsRemaining)

		var newMessage = 'Currently ' + $numberOfCohortsSelected + ' are selected. Please select ' + $numberOfCohortsRemaining + ' more. ';

		// if too many cohorts are selected, disables submit and changes message
		if ($numberOfCohortsRemaining < 0){
			newMessage = "Oops, too many are selected. Please check three cohorts.";
			alert(newMessage);
			$cohortSubmitButton.attr({disabled:'disabled',value:'Oops, select only 3 cohorts'}); 
		}
		else {
			$('.cohortsubmit').removeAttr('disabled').attr('value',"Submit"); 
		};

		// If 1 Tuesday Cohort is selected, disables checkboxes for other Tuesday Cohorts	
		if ($numberOfACohortsSelected === 1){
			$aCohortsCheckboxUnchecked.attr({disabled: 'disabled'});
			$aCohortsCheckboxUnchecked.next().attr({class:'alert alert-error'}).text("You have already selected one Tuesday Cohort or Workshop");
		}
		else {
			$aCohortsCheckboxUnchecked.removeAttr('disabled')
			.not($this).next().removeAttr('class').text("");
		};

		// If 1 Wednesday Cohort is selected, disables checkboxes for all Wednesday Cohorts	
		if ($numberOfBCohortsSelected === 1){
			$bCohortsCheckboxUnchecked.attr({disabled: 'disabled'});
			$bCohortsCheckboxUnchecked.next().attr({class:'alert alert-error'}).text("You have already selected one Wednesday Cohort or Workshop");
	 }
	 else {
		$bCohortsCheckboxUnchecked.removeAttr('disabled')
		.not($this).next().removeAttr('class').text("");
	 };

	 // If 1 Thursday Cohort is selected, disables checkboxes for all Thursday Cohorts	
		if ($numberOfCCohortsSelected === 1){
			$cCohortsCheckboxUnchecked.attr({disabled: 'disabled'});
			$cCohortsCheckboxUnchecked.next().attr({class:'alert alert-error'}).text("You have already selected one Thursday Cohort or Workshop");
		}
		else {
			$cCohortsCheckboxUnchecked.removeAttr('disabled')
			.not($this).next().removeAttr('class').text("");
		};

	// If 2 Tuesday Cohort are selected, disables submit button (failsafe)	
		if ($numberOfACohortsSelected > 1){
			newMessage = "Oops, more than Tuesday cohorts has been selected. Please check one Tuesday cohort, one Wednesday cohort and one Thursday cohort.";
			alert(newMessage);
			$('.cohortsubmit').attr({disabled:'disabled',value:'Pick only 1 Tuesday'}); 
		}
		else {
			$('.cohortsubmit').removeAttr('disabled').attr('value',"Save My Selections"); 
		};

	 // If 2 Wednesday Cohort are selected, disables submit button (failsafe)	
		if ($numberOfBCohortsSelected > 1){
			newMessage = "Oops, more than one Wednesday cohorts has been selected. Please check one Tuesday cohort, one Wednesday cohort and one Thursday cohort.";
			alert(newMessage);
			$('.cohortsubmit').attr({disabled:'disabled',value:'Pick only 1 Wednesday'}); 
		}
		else {
			$('.cohortsubmit').removeAttr('disabled').attr('value',"Save My Selections"); 
		};

		// If 2 Thursday Cohort are selected, disables submit button (failsafe)	
		if ($numberOfCCohortsSelected > 1){
			newMessage = "Oops, more than one Thursday Cohorts has been selected. Please check one Thursday cohort, one Wednesday cohort and one Thursday cohort.";
			alert(newMessage);
			$('.cohortsubmit').attr({disabled:'disabled',value:'Pick only 1 Thursday'}); 
		}
		else {
			$('.cohortsubmit').removeAttr('disabled').attr('value',"Save My Selections"); 
		};

		// Updates cohort message
	    $("div.cohortmessage").html(newMessage);
	});
}

function $showQuestions(){
	$(".questions").hide();
	$("a.showQuestions").click(function(){
		$(".questions").hide();
		$("a.showQuestions").show().text("Show Questions!");
		$this = $(this).parent().parent().find(".questions");
		$(this).hide();
		$this.slideDown(1000);
		$.scrollTo($this,2000,{offset:-300});
	})
}

function $filterQuestions(searchfor){
	$(".eachworkshop").hide();
	var $selector = ".eachworkshop:contains(" + searchfor +")";
	$($selector).show();
}

function $moveCohortInfoBox(){
	$(".eachcohort").mouseover(function(){
		var $offset = $(this).offset();
		var $outerHeight = $(this).outerHeight();
		var $dropdown = $offset.top-350;
		$('.cohortmessage').animate({'margin-top':$dropdown});
	})
}

$(document).ready(function () {

	$tooltiplink();
	$checkall();
	$mealspackage();
	$ajaxdelete();
	$ajaxdeleterow();
	$selectcohortchecked();
	$clearAllSelections()
	$showQuestions();
	// $moveCohortInfoBox();

/*	$filterQuestions("Tech"); need to wire in a search submission */

/*  Script to hide and show options on selectoptions form */

	//set variables to keep it dry
	$registration = $("#selectoptions fieldset#registrationOptions");
	$childcare = $("#selectoptions fieldset#childcare");
	$meals = $("#selectoptions fieldset#meals");
	$kidskonference = $("#selectoptions fieldset#kidskonference");
	$otheroptions = $("#selectoptions fieldset#otheroptions");
	$gracekidsexcursionsegment = $("div.GKSunAM, div.GKSunLunch");
	$GKSunAMHTML = $("div.GKSunAM").html();
	$GKSunLunchHTML = $("div.GKSunLunch").html();
	$wickham = $(".PhilWickhamFree");
	$preconference = $("#selectoptions fieldset#preconference");
	$instructions = $(".Message");
	$gracekidsreg =
	$message = $("#popup");

	//use previously defined function to hide all the options. Must set variables first
	$hidealloptions();
	$meals.show();
	$preconference.show();
	$otheroptions.show();
	$(".selected").mouseover().css('cursor','pointer').click(
		function(){
			$(this).slideUp('fast')
		});

	//check to see if items are already checked when editing
	if ($("input.ChildCare,input.GraceKids-Elementary,input.GraceKids-Preschool,input.GraceKids-Nursery").is(':checked'))
		{
			$childcare.show();
			$preconference.hide();
			$meals.hide();
		};

	//Show childcare options upon click, hide all others
	$("input.GraceKids-Preschool:radio,input.GraceKids-Nursery:radio").click(function(){
	$hidealloptions();
	$preconference.hide();
	$meals.hide();
	$childcare.show();
	$uncheckAllKidsKonferenceOptions();
	$(".GKSunAM").html($GKSunAMHTML);
	$(".GKSunLunch").html($GKSunLunchHTML);
	$instructions.html("Select individual day-segments for childcare for this child.<br/> Help us provide just the right amount of staff for your children.");
	$childcare.css({"border-color":"#FC6919","background-color":"#FFF5EF"});
	$childcare.find("legend").css({"border-color":"#FC6919","background-color":"#FCBF19","color":"white","font-weight":"bold"});
	$.scrollTo($childcare,{duration:2000},{offset:150});

	});

	//Show meal options upon click, hide all others
	if ($("input.Registration-Single, input.Registration-Couple").is(':checked'))
		{
			$meals.show();
			$otheroptions.show();
			$preconference.show();
		};
	$("input.Registration-Single:radio, input.Registration-Couple:radio").click(function(){
	$hidealloptions();
	$meals.show();
	$preconference.show();
	$otheroptions.show();
	$instructions.html("Select meal tickets (one per person) or Mobile Learning Lab options for this person.");
	$meals.css({"border-color":"#FC6919","background-color":"#FFF5EF"});
	$meals.find("legend").css({"border-color":"#FC6919","background-color":"#FCBF19","color":"white","font-weight":"bold"});
	$preconference.css({"border-color":"#FC6919","background-color":"#FFF5EF"});
	$preconference.find("legend").css({"border-color":"#FC6919","background-color":"#FCBF19","color":"white","font-weight":"bold"});
	$.scrollTo($meals,{duration:2000},{offset:150});

	});

	//Show kids konference options upon click, hide all others
	if ($("input.GraceKids-Elementary").is(':checked'))
		{
			$kidskonference.show();
			$childcare.show();
			$preconference.hide();
			$meals.hide();
		};
	$("input.GraceKids-Elementary:radio").click(function(){
	$hidealloptions();
	$meals.hide();
	$preconference.hide();
	$childcare.show();
	$kidskonference.show();
	$gracekidsexcursionsegment.html("Grace Kids-Elementary for Sunday morning: select the excursion option below.<hr/>");
	$uncheckAllChildrenOptions();
	$uncheckAllKidsKonferenceOptions();
	$instructions.html("Select individual day-segments for which you need kids konference for this child in the next section.<br/> Help us provide just the right amount of staff for your children.");
	$kidskonference.css({"border-color":"#FC6919","background-color":"#FFF5EF"});
	$kidskonference.find("legend").css({"border-color":"#FC6919","background-color":"#FCBF19","color":"white","font-weight":"bold"});
	$childcare.css({"border-color":"#FC6919","background-color":"#FFF5EF"});
	$childcare.find("legend").css({"border-color":"#FC6919","background-color":"#FCBF19","color":"white","font-weight":"bold"});
	$.scrollTo($childcare,{duration:2000},{offset:150});
	});

	//Show Wickham Concert Free Ticket if full reg selected//
	if ($("div.V2020RegSingle input, div.V2020RegCouple input").is(':checked'))
		{
			$wickham.show();
		};
	$("div.V2020RegSingle input, div.V2020RegCouple input").click(function(){
	$wickham.show();
	});

/*  End of script to hide and show options on selectoptions form */





	$(".menuItems").hide();

	$(".menuItems").parent().hide();
	$(".menuItems:has(li)").parent().show();

	$(".category").hover(function(){
		$(".menuItems").hide();
		$(this).css({ backgroundColor:"#CCC9C9" });
		$(this).children().slideDown('fast');
		}
		,
		function(){
		$(this).css({ backgroundColor:"#ECECEC" });
		$(".menuItems").hide();
		});

	$(".postbox tr").hover(
						   function () {
		$(this).css("background-color","#FFFFCC")
									 },
							function() {
		$(this).css("background-color","white")
									 }
							);

	$("span.expand").parent().hover(
			function(){
				$(this).find("span.expand").show()
						},
			function(){
				$(this).find("span.expand").hide()
						}
						);

	$("div#reginstructions").hide();
	$("a#hidereginstructions").hide();

	$("a#showreginstructions").click(function(){
		$("div#reginstructions").show();
		$("a#hidereginstructions").show();
		$("a#showreginstructions").hide();
		return false;
	});

	$("a#hidereginstructions").click(function(){
		$("div#reginstructions").hide();
		$("a#hidereginstructions").hide();
		$("a#showreginstructions").show();
		return false;
	});

	});
