<cfoutput>
<div class="span3" id="blogLink">
	#linkTo(text=imageTag("/newLayout/blog.png"), 
			controller="Blogs")#
</div>
<div class="span3" id="e-zineLink">
	#linkTo(text=imageTag("/newLayout/subscribe.png"), 
			href="http://graceconnect.us/subscribe/")#
</div>
<div class="span3" id="socialLink">
	<div class="row-fluid" style="height:60px;">
		<div class="span12" style="position:relative;">
			<div id="twitterBlock" style="position:absolute; left:0;">
				#linkTo(text=imageTag("/newLayout/twitter.png"), 
						href="http://www.twitter.com/fgbc")#
			</div>
			<div id="rssBlock" style="position:absolute; right:0;">
				#linkTo(text=imageTag("/newLayout/instagram.png"), 
						href="http://instagram.com/gracechurches/")#
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12" style="position:relative;">
			<div style="position:absolute; left:90px; top:-12px;">Follow</div>
			<div id="mailBlock" style="position:absolute; left:0;">
				#linkTo(text=imageTag("/newLayout/mail.png"),
						href="http://feedburner.google.com/fb/a/mailverify?uri=Twitter/Fgbc&loc=en_US")#
			</div>
			<div id="fbookBlock" style="position:absolute; right:0;">
				#linkTo(text=imageTag("/newLayout/fbook.png"),
						href="https://www.facebook.com/fgbc.org")#
			</div>
		</div>
	</div>
</div>
<div class="span3" id="exploreLink">
				#linkTo(text=imageTag("/newLayout/handbook.png"),
						route="handbookWelcomeIndex"
						)#
</div>
</cfoutput>