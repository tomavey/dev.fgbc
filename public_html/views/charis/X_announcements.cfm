<cfoutput>

<cfloop query="announcements">
	<div class="announcementBlock row-fluid">
		<div class="span2 announcementDate"><span>#UCase(dateformat(startAt, "mmm"))#</span><span>#dateformat(startAt, "dd")#</span></div>
		<div class="span10 announcementContent">
			<h4 class="announcmentHeader">#linkTo(text=title, href=link)#</h4>
			<p>#content#</p>
		</div>
	</div>
</cfloop>

</cfoutput>