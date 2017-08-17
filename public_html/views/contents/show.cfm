<cfoutput>

<div class="row-fluid well contentStart contentBg">

	<div class="span3">
		#includePartial("/about/whoweare")#
	</div>


	<div class="span9">

		<cfif !len(content.rightsRequired) OR gotRights(content.rightsRequired)>

			<cfif content.displayName NEQ "no">

					<h1>#content.name#</h1>

			</cfif>

					#content.content#

			<cfif gotrights("superadmin,office,pageEditor")>

									#content.author#


								<p>Updated: #dateformat(content.updatedAt)#</p>

								<p>Created: #dateformat(content.createdAt)#</p>
				<cfif gotrights("superadmin,pageEditor")>
					#listTag(controller="admin.contents")# | #editTag(controller="admin.contents", id=content.id)#
				</cfif>
			</cfif>


			<cfif isDefined("content.shortlink") && len(content.shortlink)>
				<p>Link to this page: #linkTo(controller="contents", action="show", key=content.shortlink, onlyPath=false)#</p>
			<cfelse>
				<p>Link to this page: #linkTo(controller="contents", action="show", key=content.id, onlyPath=false)#</p>
			</cfif>

		<cfelse>
			<p>You do not have permission to view this page.</p>
		</cfif>		

	</div>

</div>
</cfoutput>

