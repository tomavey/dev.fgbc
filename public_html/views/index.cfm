<cfoutput>
<div id="banner">
	#includePartial(partial="banner")#
</div>
<div id="imageLinks" class="row-fluid">
	#includePartial(partial="blockLinks")#
</div>
<div id="feeds" class="row-fluid">
	<div class="span3">
		<h3 class="addBottomBorder">News Feed</h3>
		#includePartial(partial="twitterFeed")#
	</div>
	<div class="span6">
		<h3 class="addBottomBorder">Announcements</h3>
		#includePartial(partial="announcements")#
	</div>
	<div class="span3">
		<h3 class="addBottomBorder">Spotlight</h3>
		#includePartial(partial="spotlight")#
	</div>	
</div>
</cfoutput>