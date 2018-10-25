// JavaScript Document

/*instruction message*/
var $message = "Move your cursor over names to temporarily view information then click to switch the information to the center screen.";

/*mouseover function for church and people information*/
function $showsidebar(){
	$('#thisAjaxInfo').empty().css("top","0").append($message);
	$('#ajaxinfo p a,.ajaxclickable').bind("mouseover",function(){
		$('#ajaxinfo p a,.ajaxclickable').css("background-color","white").parent().find("img").remove();//set all backgrounds to white
		$(this).css("background-color","#DFF9FF");//set selected anchor background to blue
		var $hreflink = $(this).attr("href")+"?ajax";
// For some reason this broke.  Might be a javascript conflict.	Test again by removing '+?ajax' on previous line and removing comment marks.	
//		var $search = $hreflink.search("?");
//		if ($search)
//			{$hreflink = $hreflink + "&ajax"}
//		else
//			{$hreflink = $hreflink + "?ajax"};
		var $offset = $(this).offset();
		var $dheight = $(document).height();
		var $wheight = $(window).height();
		var $divheight = $("#maininfo").height();
		var $dropdown = $offset.top-225;
		var $maxdropdown;
		$('#thisAjaxInfo').css('max-height','none');
		if ($offset.top >= $divheight-$divheight/6)
			{$('#thisAjaxInfo').css('max-height','300px').css('overflow','auto')};
		$('#thisAjaxInfo').css("top",$dropdown).text("Loading new info...").load($hreflink,$thisAjaxInfoLinks);
		var $boxheight = $("#thisAjaxInfo").height();
		$maxdropdown = 	$divheight - $boxheight - 274	
		$('#navigation').append("<p id='cursorinfo'></p>");
		$('#cursorinfoX').empty().append
			(
				"Divheight = "+$divheight+
				"<br/>BoxHeight = "+$boxheight + 
				"<br/>Maxdrop = " + $maxdropdown+
				"<br/> Dropdown = "+$dropdown +"hi"
			);
	});
}

function $showsidebarX(){
	$('#ajaxinfo p a,.ajaxclickable').bind("mouseover",function(){
		$('#ajaxinfo p a,.ajaxclickable').css("background-color","white").parent().find("img").remove();//set all backgrounds to white
		var $hreflink = $(this).attr("href")+"&ajax=true";
		$('#thisAjaxInfo').text("Preview Loading...").load($hreflink,function(){$('#thisAjaxInfo').prepend("<h4>Preview...</h4><br/>")});
	});
};	


/*Creates a mouseover for the website, skype or email link*/
function $churchinfolink (){
	function $clearhighlight() {$('.ajaxinfo a').css("background-color","white").parent().find("img").remove()};
	$('a#websitelink').mouseover(function(){
		$clearhighlight();
		$('#thisAjaxInfo').text("Click to view this web site")
										 })
		.mouseout(function(){
		$('#thisAjaxInfo').empty();				   
						   });
	$('a#emailink').mouseover(function(){
		$clearhighlight();
		$('#thisAjaxInfo').text("Click to create an empty email to this person.")
										 })
		.mouseout(function(){
		$('#thisAjaxInfo').empty();				   
						   });
	$('span#skypelink').mouseover(function(){
		$clearhighlight();
		$('#thisAjaxInfo').text("If you have Skype, click to dial")
										 })
		.mouseout(function(){
		$('#thisAjaxInfo').empty();				   
						   });
	$('a#googlemap').mouseover(function(){
		$clearhighlight();
		$('#thisAjaxInfo').text("Click to view a google map to this church.")
										 })
		.mouseout(function(){
		$('#thisAjaxInfo').empty();				   
						   });
}

/*turn segment links like state or alpha into ajax calls*/
function $segmentlinksX(){
	$('#segmentlinks a, #prevNext a, #reportlinks a').click(function(){
		$this = $(this);
		var $hreflink = $this.attr("href")+"&ajax=true";
		$("#info").text('Loading new information...').load($hreflink,$bindeverything);
		$(".selected").removeClass("selected");
		$this.addClass("selected");
		$('#tooltip').remove();
		return false;
	  });
}

/*turn quicksearch form submit into ajaxcall*/
function $quicksearch(){
	var $quicksearchbutton = $('#quicksearch input[type="submit"]');
	var $instructions = $quicksearchbutton.attr("value");
	$quicksearchbutton.hide();
	$('#quicksearch input#searchstring').attr("value",$instructions).css("color","gray")
		.focus(function(){
				$(this).attr("value","").css("color","black");
					   })
		.blur(function(){
			$(this).attr("value",$instructions).css("color","gray");					  
								  });
	;
	$quicksearchbutton.click(function(){
	var $searchtype = $('input#searchtype').val(); 								
	var $searchstring = $('input#searchstring').val(); 
	var $formlink = "?fuseaction="+$searchtype+"&searchstring="+$searchstring+"&ajax=true";
	$('#info').load($formlink,$bindeverything);
	$('#popup').hide();
	return false;
	});
}

/*turn links in main info (center) section into ajax calls*/
function $maininfolinks(){
	$('.ajaxclickable').click(function(){
		$this = $(this);
		var $hreflink = $this.attr("href")+"&ajax=true";
		$("#info").text("Loading new information...").load($hreflink,$bindeverything);
		$('#tooltip').remove();
		return false;
	  });
}

/*turn links within the sidebar information into ajax calls*/
function $thisAjaxInfoLinks(){
	$('#thisAjaxInfo a').click(function(){
		$this = $(this);
		var $hreflink = $this.attr("href")+"&ajax=true";
		$('#info').load($hreflink,$bindeverything);
		$('#thisAjaxInfo').empty().append($message);
		return false;
	});
}

/*turns underlined text in reports in last name searches and strong text in reports into state searches for churches*/
function $searchtext() {
	$('u, .peoplesearch').mouseover(function(){
		var $searchstring = $(this).text();
		var $querystring = "?fuseaction=people&searchstring="+$searchstring;
		$(this).wrap("<a></a>").parent().attr("href",$querystring).attr("title","Click to search for data");
		
		$(this).parent().click(function(){
		$this = $(this);
		var $hreflink = $this.attr("href")+"&ajax=true";
		$('#info').load($hreflink,$bindeverything);
		return false;
		});
	});

	$('strong, .churchsearch').wrap("<u></u>").mouseover(function(){
		var $searchstring = $(this).text();
		var $querystring = "?fuseaction=churches&searchstring="+$searchstring;
		$(this).wrap("<a></a>").parent().attr("href",$querystring).attr("title","Click to search for data");
		$(this).parent().click(function(){
		$this = $(this);
		var $hreflink = $this.attr("href")+"&ajax=true";
		$('#info').load($hreflink,$bindeverything);
		return false;
		});
	});
}

/*Turns the page header into a link back to default page*/
function $loading(){
	$('#pageheader').append("<div id='loading'></div>");
	$('#loading').ajaxStart(function(){
		$(this).text('Loading new information').show();
		}).ajaxStop(function(){
		$(this).empty().hide();
		});
}

/*Turn navigation links into ajax calls*/
function $navigationX(){
	$('#navigation a:not(#navsearch)').click(function(){
		$this = $(this);
		var $hreflink = $this.attr("href")+"&ajax=true";
		$('#info').empty();
		$("#info").text('Loading new information...').load($hreflink,$bindeverything);
		$(".menuselected").removeClass("menuselected");
		$this.addClass("menuselected");
		$('#popup').hide();
		return false;
		});
	$navtooltip();
}

function $navsearch(){
	$('#navigation a#navsearch').click(function(){
		$this = $(this);
		var $hreflink = $this.attr("href")+"&ajax=true";
		$("#popup").unbind('click',$navigation).fadeIn('slow').text('Loading new information...').load($hreflink,function(){   
			$bindeverything;
			$(this).prepend("<div style='text-align:right'><a href=''>close this window</a></div>");
			$('#popup a').click(function(){
			$('#popup').hide().$bindeverything();
			$('.container').fadeTo("medium",1);
			return false
										 });
			$('.container').fadeTo("medium",0.33);
  });
																											$(".menuselected").removeClass("menuselected");
		$this.addClass("menuselected");
		$("#popup").append('close');
		return false;
		});
}

/*Turn page header into link to default page*/
function $pageheader(){
	$('#pageheader').click(function(){
		open("/handbook/people/","_top")
		});
		$('#pageheader').mouseover(function(){
		$('#loading').text('Click to return to main page').show().css("cursor","pointer");
		});
		$('#pageheader').mouseout(function(){
		$('#loading').hide()
		});
}

function $navtooltip(){	
		$target = $('#navigation a.tooltip');
		$tooltip($target);
}

function $infotooltip(){
		$target = $("#info a, span#skypelink").not(".prevNextLink");
		$tooltip($target);
}

function $atooltip (){
		$target = $("a#tooltip");
		$tooltip($target);
}
	
function $Xtooltip($target){
	/* CONFIG */
		xOffset = 40;
		yOffset = 50;		
		// these 2 variable determine popup's distance from the cursor
		// you might want to adjust to get the right result		
	/* END CONFIG */		
	$target.hover(function(e){											  
		this.t = this.title;
		this.title = "";									  
		$("body").append("<p id='tooltip'>"+ this.t +"</p>");
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

function $testalert(){
	alert("worked")
}

function $skypelink(){
	$href="skype:+1-"+$("#skypelink").attr("href")+"?call";
	$("#skypelink").css("text-decoration","underline").css("cursor","pointer")
	.click(function(){
		open($href);
		return skypeCheck()
													  });
}

/*Binds mouseover and click events after ajax callback*/
function $bindeverything(){
	$segmentlinks();
	// $showsidebar();
	$maininfolinks();
	$quicksearch();
	$thisAjaxInfoLinks();
	$searchtext();
	$infotooltip();
	$skypelink();
}

/*Shows instructions when focus is on tag field*/
function $taginstructions(){
	$(".tagfield").focus(function ()
		{$(".tagfieldinstructions").html(
		"After adding your tag or tags, click the arrow box to the right."
		);}
		)};

function $downloadconfirm(){
	$(".downloadconfirm").click(function(){
		alert('Did you read the guidelines?');
	});
}

$(document).ready(function(){

	$loading();

	$pageheader();
	
	$showsidebar();
	
	$thisAjaxInfoLinks();

	$taginstructions();

	$downloadconfirm();
	
	$('.tooltip2').tooltip();
	$('.tooltipside').tooltip({placement:"right"});
	$('.tooltipleft').tooltip({placement:"left"});
	$('.tooltipbelow').tooltip({placement:"bottom"});
	$('.tooltipbottom').tooltip({placement:"bottom"});

	$('.maxfilesize').mouseover(function(){
		$(this).prev('label').text("Suggestion: limit the file size of your image to 500kb").css({ color:"red", fontWeight:"bolder", fontSize: "1.3em" });
	});	
	
    $('.maxfilesize').bind('change', function() {
    
      //this.files[0].size gets the size of your file.
	  $filesize = this.files[0].size/1000;
	  var $filesize=Math.round($filesize);
      $(this).prev('label').text("Your file size is:" + $filesize + "kb.");
    
    });
    $( "#datepicker" ).datepicker();

});

