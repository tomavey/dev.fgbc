function $ajaxdelete(){
	$('a.ajaxdelete').click(function(){
	var $bordercolor = $(this).css("border-color");
	$(this).parents(".ajaxdelete").css("border-color", "red").css("opacity","0.4");
	var $hreflink = $(this).attr("href");
	if (confirm('Are you sure you want to delete this? NO TURNING BACK!' + " " +$hreflink))
		{	$.get($hreflink);
			$(this).parents(".ajaxdelete").fadeOut(500).empty().append('<span style="color:red;font-weight:bold">BYE...BYE!</span>')
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
			$(this).parent().parent().fadeOut(500).empty().append('<span style="color:red;font-weight:bold">BYE...BYE!</span>')
		}
		else
		{	$(this).parent().parent().css("border-color", $bordercolor).css("opacity","1.0")
		}
	return false;
	});
}

$(document).ready(function () {

	$ajaxdelete();
	$ajaxdeleterow();

});