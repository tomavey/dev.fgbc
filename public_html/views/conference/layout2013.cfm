<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<cfoutput>
		<title>Vision 2020 Conference - July 26-31, 2012</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" /> 
	
		#javaScriptIncludeTag("jquery.min.js, jquery.scrollTo-min, script")#
    	<script type="text/javascript" src="/js/jquery.nivo.slider.pack.js"></script>
    	<script type="text/javascript" src="/js/jquery.lwtCountdown-1.0.js"></script>
		
		<link rel="stylesheet" type="text/css" href="/css/style.css" media="all" />
		<link rel="stylesheet" type="text/css" href="/css/nivo-slider.css" media="all" />
		<link rel="stylesheet" type="text/css" href="http://www.fgbc.org/vision2020/stylesheets/fgbcstyle.css" media="all" />	    <script type="text/javascript">
		#styleSheetLinkTag("regreset,regstyle")#
	    	$(document).ready(function() {
			    
				$('##countdown').countDown({
					targetDate: {
						'day': 		26,
						'month': 	07,
						'year': 	2013,
						'hour': 	17,
						'min': 		00,
						'sec': 		0					}
				});

				$(".level-one").hover(
					function(){
						$("ul",this).show();
						$("a",this).addClass('hover');
					},
					function(){
						$("ul",this).hide();
						$("a",this).removeClass('hover');
					}
				);
		    });
		</script>
	</head>
	<body>

		<div id="right-bg"></div>
		<div id="container">
			<div id="header">
				<div id="logo"><a href="#application.wheels.nextwaveURL#" title="Vision 2020 Conference"><img src="#application.wheels.nextwaveURL#/site-images/vision-logo.png" alt="Vision 2020 Conference" /></a></div>
				<div id="header-right">
					<div id="header-nav">
						<ul>
							<li><a title="Register" href="#application.wheels.nextwaveURL#/conference/registration"><img src="#application.wheels.nextwaveURL#/site-images/vision-register-btn.jpg" alt="Register" /></a></li><li><a title="Location" href="#application.wheels.nextwaveURL#/conference/location"><img src="#application.wheels.nextwaveURL#/site-images/vision-location-btn.jpg" alt="Location" /></a></li><li><a title="Connect" href="#application.wheels.nextwaveURL#/conference/connect"><img src="#application.wheels.nextwaveURL#/site-images/vision-connect-btn.jpg" alt="Connect" /></a></li>
						</ul>
					</div>
					<div id="countdown">
						<div class="numbers">
							<div class="days_dash">
								<div class="spacer-0"></div>
								<div class="digit">2</div>
								<div class="spacer-1"></div>
								<div class="digit">4</div>
								<div class="spacer-2"></div>
								<div class="digit">8</div>
								<div id="clear"></div>
							</div>
							<div class="hours_dash">
								<div class="spacer-3"></div>
								<div class="digit">0</div>
								<div class="spacer-4"></div>
								<div class="digit">6</div>
								<div id="clear"></div>
							</div>
							<div class="minutes_dash">
								<div class="spacer-5"></div>
								<div class="digit">4</div>
								<div class="spacer-6"></div>
								<div class="digit">1</div>
								<div id="clear"></div>
							</div>
							<div id="clear"></div>
						</div>
					</div>
				</div>
			</div>
			<div id="nav">
				<ul class="main">
<li class='level-one'><div><a class='' href='/' title='Home'>Home</a></div>
</li>
<li class='level-one'><div><a class='' href='/conference/location' title='Location'>Location</a></div>
<ul class='sub'><li  class='level-two'><a href='/conference/location-2' title='Lodging'>Lodging</a></li>
<li  class='level-two'><a href='/conference/directions' title='Directions'>Directions</a></li>
</ul>
</li>
<li class='level-one'><div><a class='' href='/conference/schedule' title='Schedule'>Schedule</a></div>
</li>
<li class='level-one'><div><a class='' href='/conference/meals' title='Meals'>Meals</a></div>
</li>
<li class='level-one'><div><a class='' href='/conference/options' title='Extras'>Extras</a></div>
<ul class='sub'><li  class='level-two'><a href='/conference/seminars' title='Mobile Learning Labs'>Mobile Learning Labs</a></li>
<li  class='level-two'><a href='/conference/exhibitors' title='Exhibitors'>Exhibitors</a></li>
</ul>
</li>
<li class='level-one'><div><a class='' href='/conference/childcare' title='Childcare'>Childcare</a></div>
</li>
<li class='level-one'><div><a class='' href='/conference/registration' title='Registration'>Registration</a></div>
</li>
<li class='level-one'><div><a class='active' href='/conference/media' title='Media'>Media</a></div>
<ul class='sub'><li  class='level-two'><a href='/conference/exhibitors-2' title='Exhibits'>Exhibits</a></li>
</ul>
</li>
<li class='level-one'><div><a class='' href='http://fgbc.org' title='FGBC.org'>FGBC.org</a></div>
</li>
				</ul>
			</div>	
			<style>
				body {  background:url('#application.wheels.nextwaveURL#/site-images/vision-sec-bg-left.jpg') repeat-x 0 0; }
				##right-bg {background: url(#application.wheels.nextwaveURL#/site-images/vision-sec-bg-right.jpg) repeat-x 0 0; }			
			</style>
				<div id="left-col">
					<div id="left-col-content">
					<div id="left-col-content">
		layout2013
						#contentForLayout()#
					</div>
				</div>				
				<div id="clear"></div>
			</div>
			<div id="footer">
				<div id="footer-left"><span><a href='/' title='Home'>Home</a>&nbsp;&nbsp;&nbsp;<a href='/conference/location' title='Location'>Location</a>&nbsp;&nbsp;&nbsp;<a href='/conference/schedule' title='Schedule'>Schedule</a>&nbsp;&nbsp;&nbsp;<a href='/conference/meals' title='Meals'>Meals</a>&nbsp;&nbsp;&nbsp;<a href='/conference/options' title='Extras'>Extras</a>&nbsp;&nbsp;&nbsp;<a href='/conference/childcare' title='Childcare'>Childcare</a>&nbsp;&nbsp;&nbsp;<a href='/conference/registration' title='Registration'>Registration</a>&nbsp;&nbsp;&nbsp;<a href='/conference/media' title='Media'>Media</a>&nbsp;&nbsp;&nbsp;<a href='http://fgbc.org' title='FGBC.org'>FGBC.org</a>&nbsp;&nbsp;&nbsp;				</span></div>
				<div id="footer-right"><span>Copyright &##169; 2012 fgbc.org</span><br><span><a href="http://nextwaveservices.com" title="Next Wave Services">Wooster Website Design</a> by Next Wave Services</span></div>
				<div id="clear"></div>
			</div>
		</div>
		<div id="footer-left-bg"><div id="footer-right-bg"></div></div>
		</cfoutput>
<cfif isdefined("url.session")>
		<cfdump var="#session#">
		<cfdump var="#getLname()#">
</cfif>
<cfif isAdmin()>
	<cfdump var="#params#">

</cfif>

	</body>
</html>
