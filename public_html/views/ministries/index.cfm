<cfoutput>
	<cfif params.category is "Church Planting Ministries">
		<div class="card card-charis">
		 <h2 class="text-center">#linkTo(text="Watch Mark Artrip talk about church planting in the Charis Fellowship", href="https://vimeo.com/242131178")#</h2>
		 <div class="text-center embed-responsive embed-responsive-16by9">
		 <iframe src="https://player.vimeo.com/video/242131178" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
<p><a href="https://vimeo.com/242131178">Pastor Mark Artrip</a> from <a href="https://vimeo.com/charisfellowship">Charis Fellowship</a> on <a href="https://vimeo.com">Vimeo</a>.</p>
		</div>
		</div>
	</cfif>

	<cfif params.category is "Leadership Training Ministries">
		#includePartial("/charis/promo_leaders")#
	</cfif>

	<cfif params.category is "Doing Good">
		<div class="card card-charis">
		 <h2 class="text-center">#linkTo(text="Watch Barb Wooler talk about training leaders in the Charis Fellowship", href="https://vimeo.com/242130542")#</h2>
		 <div class="text-center embed-responsive embed-responsive-16by9">
			<iframe src="https://player.vimeo.com/video/242130542" width="640" height="363" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
			<p><a href="https://vimeo.com/242130542">Barn Wooler and the Charis Fellowship</a> from <a href="https://vimeo.com/charisfellowship">Charis Fellowship</a> on <a href="https://vimeo.com">Vimeo</a>.</p>
		</div>
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