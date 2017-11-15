<cfoutput>
	<cfif params.category is "Church Planting Ministries">
		#includePartial("/charis/promo_churchplanting")#
	</cfif>

	<cfif params.category is "Leadership Training Ministries">
		#includePartial("/charis/promo_leaders")#
	</cfif>

	<cfif params.category is "Doing Good">
		#includePartial("/charis/promo_doinggood")#
	</div>
	</cfif>
	<div class="container card card-charis card-charis-square text-center">
		<cfoutput query="ministry" group="category">
		<cfif not category is "none">
			<div class="postbox categories"><h1>#category#</h1></div>

			<cfoutput>
				<div class="card card-charis-sub">
							<h2 class="card-title">#ministry.name#</h2>

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
</cfoutput>