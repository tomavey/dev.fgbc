<cfoutput>
<cfif useDesktopLayout()>

<cfif isCategoryMenu>
<div id="categorymenu">
	#includePartial("categorymenu")#
<cfelse>
<div id="banner">
	#includePartial("banner")#
</cfif>	
</div>
<div id="imageLinks" class="row-fluid">
	#includePartial("blockLinks")#
</div>
</cfif>	
<div id="feeds" class="row-fluid">
	<cfif showannouncements>
	<div class="#announcementsspan#">
		<h3 class="addBottomBorder">Announcements</h3>
		#includePartial("announcements")#
		#linkto(text="More Announcements", controller="announcements", action="index", class="btn btn-large")#
	</div>
	</cfif>

		<div class="#feedspan#">
			<h3 class="addBottomBorder">News Feed</h3>
			#includePartial("twitterFeed")#
		</div>

	<div class="#spotlightspan#">
		<h3 class="addBottomBorder">Spotlight</h3>
		#includePartial("spotlight")#
	</div>	
</div>
</cfoutput>