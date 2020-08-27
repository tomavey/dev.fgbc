<cfoutput>

<!DOCTYPE HTML>
<html>
	<head>
		<title>Fellowship of Grace Brethren Churches</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<LINK REL="SHORTCUT ICON" HREF="/images/favicon.ico">


		#styleSheetLinkTag("bootstrap,main")#

		#javaScriptIncludeTag("jquery.min,bootstrap,responsiveslides.min,iCanHaz.min,application,jquery_ujs,ajaxdelete")#

		<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-3478142-1', 'fgbc.org');
  ga('send', 'pageview');

</script>

	</head>
	<body>

		#includePartial("/login")#

		<div id="header-wrapper">
			<div id="header" class="container">
				<div class="row-fluid">
					<div class="span3">
						<div id="logo-wrapper">
							<div><p>Fellowship of Grace Brethren Churches</p></div>
						</div>
					</div>
					<div class="span4 offset5">
						#includePartial("/topLinks")#
					</div>
				</div>
				<div class="row-fluid" id="main-links-wrapper">
					<div class="span9 offset3">
						#includePartial("/mainLinks")#
					</div>
				</div>
			</div>
		</div>
		<div id="content-wrapper">
			<div id="content" class="container">
				#includeContent()#
			</div>
		</div>
		<div id="footer-wrapper">
			<div id="footer" class="container">
					<div class="linkGroup">
						<h4>About</h4>
						<div>
							<a href="http://www.fgbc.org/commoncommitment/">Common Commitment</a><br/>
							<a href="http://www.fgbc.org/cci/">our Commitment to Common Identity</a><br/>
							<a href="/about/statementoffaith">Statement of Faith</a><br/>
							<a href="/about/our-story">Our Story</a><br/>
							<a href="/about/constitution">Constitution</a><br/>
							<a href="/messages/new">Contact Us</a><br/>
						</div>
					</div>
					<div class="linkGroup">
						<h4>Churches</h4>
						<div>
							<a href="/churches/index">United States</a><br/>

						</div>
						<h4>Opportunities</h4>
						<div>
							<a href="/jobs/index">View All Postings</a><br/>
							<a href="/jobs/new">Submit a Posting</a>
						</div>
					</div>
					<div class="linkGroup">
						<h4>Ministries</h4>
						<div>
							<a href="http://www.encompassworldpartners.org/">Encompass World Partners</a><br/>
							<a href="http://www.grace.edu">Grace College and Seminary</a><br/>
							<a href="http://www.eaglecommission.org/">Eagle Commission</a><br/>
							<a href="http://www.cenational.org/">CE National</a><br/>
							<a href="http://www.gbif.com/">Grace Brethren Investment Foundation</a><br/>
							<a href="http://www.graceconnect.us/">Grace Connect</a><br/>
							<a href="http://www.wgusa.org">Women of Grace</a><br/>
							<a href="http://www.agbm.org">Association of Grace Brethren Ministers</a>
						</div>
					</div>
					<div class="linkGroup">
						<h4>FGBC Account</h4>
						<div>
							<a href="/auth/users/new">Create an Account</a><br/>
							<a href="http://fgbc.commercestreet.com/Login.aspx">FGBC Email</a><br/>
							<a href="http://www.fgbc.org/mobile">Mobile Site</a>
						</div>
					</div>
					<div class="linkGroup">
						<div><h4><a href="https://www.facebook.com/pages/Fellowship-of-Grace-Brethren-Churches/35500160499">Facebook</a></h4>
						<h4><a href="http://www.twitter.com/fgbc">Twitter</a></h4></div>
						<div style="float:right; color:##a7a7a7;">
							<a href="https://twitter.com/statuses/user_timeline/14820001.rss"><img src="/images/rss.png"></a><span class="rss"><a href="https://twitter.com/statuses/user_timeline/14820001.rss">RSS Feeds</a></span><br/><br/>
							@2013 FGBC<br/><br/>
							P.O. Box 384<br/>
							Winona Lake, IN<br/>
							574.269.1269
						</div>
					</div>
			</div>
		</div>
		<cfif gotRights("superadmin")>
			This only shows to administrator:<br/>
			Send emails on errors? #application.wheels.sendemailonerror#<br/>
			Subject for email? #application.wheels.erroremailsubject#<br/>
			<cfif isDefined("session.originalUrl")>
				Original URL:#session.originalUrl#<br/>
			</cfif>
			<cfif isDefined("session.previousUrl")>
				Previous URL#session.previousUrl#<br/>
			</cfif>
		</cfif>
#forcecfcatch()#

</body>
</html>

<!---test of git--->

</cfoutput>