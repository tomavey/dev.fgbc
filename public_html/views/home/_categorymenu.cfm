<cfset menucount = 0>
<cfset officemenucount = 0>

<cfoutput>
<div class="container card card-charis card-charis-square">


    <div>
		<cfif gotRights("handbook,ministrystaff,natminstaff")>
			<h2>
				FGBC Ministry Staff Menu:
			</h2>
		<cfelse>
			<h2>
				Members Menu: 
			</h2>
		</cfif>

		<cfloop query ="menu">
			<cfif gotrights(rightsrequired) and category is "office">
				<cfset officemenucount = officemenucount + 1>
			</cfif>
			<cfif gotrights(rightsrequired) and category NEQ "office">
				<cfset menucount = menucount + 1>
			</cfif>
		</cfloop>

		<cfoutput query="menu" group="category">
		<cfset rowcount = 0>
			<ul class="categorymenulist">
			<cfoutput>
				<cfif gotrights(rightsrequired)>
					<cfset rowcount = rowcount + 1>
					<li>
						#createLink(text=name, link=link, controller=controllerr, action=actionn, key=keyy, route=route)#
					</li>
				</cfif> 
				<!---Create a column break--->
				<cfif rowcount is int((officemenucount)/2)>
					</ul>
					<ul class="categorymenulist">
				</cfif>
							
			</cfoutput>
			</ul>
		</cfoutput>

	</div>

	<p class="text-right">#session.auth.email# - #session.auth.username#</p>	

</div>
</cfoutput>
