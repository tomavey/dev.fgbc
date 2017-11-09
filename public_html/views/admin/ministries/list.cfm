<cfoutput>
<div class="container">
		<cfoutput query="ministry" group="category">
		<cfif not category is "none">
			<div class="postbox categories"><h1>#category#</h1></div>

			<cfoutput>
				<div class="well ministries">
							<h2>#ministry.name#</h2>

							<cftry>
								#linkTo(href=webaddress, text=imageTag("/ministries/#ministry.image#"))#
							<cfcatch></cfcatch></cftry>
							<p>#ministry.summary#</p>
						
							<p>
								#linkTo(href=webaddress, text=replace(webaddress,"http://",""))#
							</p>
						
					<cfif gotRights("superadmin,office")>						
						#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this fgbc ministry", action="edit", key=ministry.id)#
					</cfif>	
				</div>
			</cfoutput>
		</cfif>
		</cfoutput>
</div>
</cfoutput>