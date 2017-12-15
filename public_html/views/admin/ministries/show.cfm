<cfoutput><div id="#params.controller##params.action#"></cfoutput>
	<cfoutput query="ministry" group="category">
		<cfif not category is "none">
			<div class="postbox categories"><h1>#category#</h1></div>

			<cfoutput>
				<div class="postbox ministries">
							<h1>#ministry.name#</h1>

							<cftry>
								#linkTo(href=webaddress, text=imageTag("/ministries/#ministry.image#"))#
							<cfcatch></cfcatch></cftry>
							<p>#ministry.summary#</p>
						
							<p>
								#linkTo(href=webaddress, text=replace(webaddress,"http://",""))# - #phone#
							</p>
						
			<cfif gotRights("superadmin,office")>						
				#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this fgbc ministry", action="edit", key=ministry.id)#
			</cfif>	
				</div>
			</cfoutput>
		</cfif>
	</cfoutput>
</div>