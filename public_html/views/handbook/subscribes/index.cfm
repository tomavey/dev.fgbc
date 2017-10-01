<cfset emailall = "">

<h1>Listing handbook subscriptions</h1>

<cfoutput>
	<p>#addTag()#</p>


<table class="table table-striped">
	<tr>
		<th>
		#linkto(text="Email", params="sortBy=email", class="btn")#</th>
		<th>#linkto(text="Type", params="sortBy=type", class="btn")#</th>
		<th>Last Send</th>
		<th>#linkto(text="Date", params="sortBy=createdAt", class="btn")#</th>
		<th>Handbook id</th>
		<th>&nbsp;</th>
	</tr>
</cfoutput>
	<cfoutput query="handbooksubscribes">
		<tr>
			<td>
				<cfif len(handbookemail)>
					<cfset handbooksubscribes.email = handbookemail>
				</cfif>	
			#email#
			</td>
			<td>
			#linkto(text=type, params="type=#type#")#
			</td>
			<td>
			#dateFormat(lastSendAt)#
			</td>
			<td>
			#dateFormat(createdAt)#
			</td>
			<td>
			<cfif len(handbookid)>
			#linkto(text=handbookid, controller="handbook.people", action="show", key=handbookid)#
			</cfif>
			</td>
			<td>#linkto(text="Show", route="handbookSubscribe", key=id, method="get")##editTag()##deletetag()#</td>
		</tr>
		<cfset emailall = emailall & "; " & email>
	</cfoutput>
</table>
<cfset emailall = replace(emailall,";","","one")>
<cfoutput>
	<p>#addTag()#</p>
	#mailTo(emailall)#
</cfoutput>
