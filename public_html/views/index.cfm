<cfoutput>
<div id="banner">
	#includePartial("banner")#
</div>
<div id="imageLinks" class="row-fluid">
	#includePartial("blockLinks")#
</div>
<div id="feeds" class="row-fluid">
	<div class="span3">
		<h3 class="addBottomBorder">News Feed</h3>
		#includePartial("twitterFeed")#
	</div>
	<div class="span6">
		<h3 class="addBottomBorder">Announcements</h3>
		#includePartial("announcements")#
	</div>
	<div class="span3">
		<h3 class="addBottomBorder">Spotlight</h3>
		#includePartial("spotlight")#
	</div>	
</div>
</cfoutput>