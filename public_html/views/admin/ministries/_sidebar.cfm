<cfoutput>
<div style="margin-top:70px;">
	<ul class="nav nav-list well">
		<li class="nav-header">Ministries</li>
		<li <cfif NOT isDefined("params.category")>class="active"</cfif>>#linkTo(text="All", action="list")#</li>
		<cfoutput query="categories" group="category">
		<li <cfif isDefined("params.category") and params.category eq category>class="active"</cfif>>#linkTo(text=category, action="list", params="category=#category#")#</li>
			<cfoutput></cfoutput>
		</cfoutput>
	</ul>
</div>
</cfoutput>
