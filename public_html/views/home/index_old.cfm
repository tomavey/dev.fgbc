<cfoutput>
<cfif useDesktopLayout()>

<cfif isCategoryMenu>
<div id="categorymenu">
	#includePartial(partial="categorymenu")#
<cfelse>
<div id="banner">
	#includePartial(partial="banner")#
</cfif>	
</div>
<div id="imageLinks" class="row-fluid">
	#includePartial(partial="blockLinks")#
</div>
</cfif>	
<div id="feeds" class="row-fluid">
	<cfif showannouncements>
	<div class="#announcementsspan#">
		<h3 class="addBottomBorder">Announcements</h3>
		#includePartial(partial="announcements")#
		#linkto(text="More Announcements", controller="announcements", action="index", class="btn btn-large")#
	</div>
	</cfif>

		<div class="#feedspan#">
			<h3 class="addBottomBorder">News Feed</h3>
			#includePartial(partial="twitterFeed")#
		</div>

	<div class="#spotlightspan#">
		<h3 class="addBottomBorder">Spotlight</h3>
		#includePartial(partial="spotlight")#
	</div>	
</div>
</cfoutput>