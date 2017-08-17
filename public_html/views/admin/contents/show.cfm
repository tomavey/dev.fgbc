<cfoutput>

<div class="row-fluid well contentStart contentBg">

<div class="span12"><h1>#content.name#</h1>

							#content.content#

	<cfif gotrights("superadmin,office,pageEditor")>

							#content.author#


						<p>Updated: #dateformat(content.updatedAt)#</p>

						<p>Created: #dateformat(content.createdAt)#</p>

						#listTag()# | #editTag(content.id)#
	</cfif>

	<cfif isDefined("content.shortlink")>
		<p>Link to this page: #linkTo(controller="contents", action="show", key=content.shortlink, onlyPath=false)#</p>
	<cfelse>
		<p>Link to this page: #linkTo(controller="contents", action="show", key=params.key, onlyPath=false)#</p>
	</cfif>

	</div>
	</div>

</cfoutput>

