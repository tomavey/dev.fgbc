<cfoutput>
<div class="row-fluid well contentStart contentBg">

<div class="span12">

	
<h1>FGBC Events...</h1>

<cfoutput query="event">
<div class="postbox">
					<h1>#linkTo(text=event, href=eventlink)#</h1>
					
					<p>#getDateDesc(begin="#begin#", end="#end#")#</p>
				
					<cfif description is not "">
					<p>#description#</p>
					</cfif>
				
					<p><label>Sponsor: </label><a href="#sponsorLink#">#sponsor#</a></p>

<cfif gotrights("superadmin,office")>				
	#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this Event", action="edit", key=event.id)#
</cfif>
</div>
</cfoutput>
</div>
</cfoutput>