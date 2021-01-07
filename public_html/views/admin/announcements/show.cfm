<cfoutput>
<div class="container">
	<div class="card card-charis">
		<h1>#announcement.title#</h1>

		<cftry>
			<div>#imageTag("/announcements/#announcement.image#")#</div>
			<cfcatch></cfcatch>
		</cftry>

			<div>#announcement.content#</div>
		
		<p>
			<cfif len(announcement.link)>
				#linkto(text="This Story", href="http://#fixWebSite(announcement.link)#")#
			<cfelse>	
				#linkto(text="This Story", controller="announcements", action="show", key=announcement.id)#
			</cfif>
		</p>
		<p>
			<cfif len(announcement.image)>
				<a href="#announcement.image#" target="_new"><img src="#announcement.image#" /></a>
			<cfelseif gotrights("superadmin,office")>
				No Image	
			</cfif>	
		</p>

		<cfif gotrights("superadmin,office")>
						
		<p>Begins: #dateformat(announcement.startAt)#</p>

		<p>Ends: #dateformat(announcement.endAt)#</p>

		<p>Onhold? #announcement.onhold#</p>

		<p>Created: #dateformat(announcement.createdAt)#</p>
					

		#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this announcement", action="edit", key=announcement.id)#
		</cfif>

	</div>

</div>
</cfoutput>
