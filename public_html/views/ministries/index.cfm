<cfoutput>
<div class="row-fluid well contentStart contentBg">
	<div class="span3">
		#includePartial(partial="sidebar", selected="all")#
	</div>

	<div class="span9">
		<cfoutput query="ministry" group="category">
		<cfif not category is "none">
			<div class="postbox categories"><h1>#category#</h1></div>

			<cfoutput>
				<div class="well ministries">
							<h2>#ministry.name#</h2>

							<cftry>
								<cfif len(webaddress)>
									#linkToUrl(href=webaddress, text=imageTag("/ministries/#ministry.image#"))#
								<cfelse>
									#imageTag("/ministries/#ministry.image#")#
								</cfif>
							<cfcatch></cfcatch></cftry>
							<p>#ministry.summary#</p>

							<p>
								<cfif len(webaddress)>
									#linkToUrl(webaddress)#
								</cfif>
							</p>

							<cfif gotRights("office") && ministry.status is "inactive">
								<h3>INACTIVE</h3>
							</cfif>

					<cfif gotRights("superadmin,office")>
						#edittag(controller="admin.ministries")#
					</cfif>
				</div>
			</cfoutput>
		</cfif>
		</cfoutput>
	</div>
</div>
</cfoutput>