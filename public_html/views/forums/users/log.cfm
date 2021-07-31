<ul>
<cfoutput query="users" group="email">
<li><h3>#mailto(email)# first visited...</h3>
	<ul>
		<li>
	<cfoutput>
		#linkto(text="#controller#/#action#<cfif len(paramskey)>/#paramskey#</cfif>", controller=controller, action=action, key=paramskey)# on #dateformat(createdAt)#; 
		<cfset viewcount = viewcount +1>
	</cfoutput>
		</li>
		<cfif len(browser)>
		<li>#browser#</li>
		</cfif>
	</ul>	
</li>
<cfset usercount = usercount +1>
</cfoutput>
</ul>
<cfoutput>
Users: #usercount#<br/>
Views: #viewcount#
</cfoutput>
<!--- <cfdump var="#cgi#"> --->