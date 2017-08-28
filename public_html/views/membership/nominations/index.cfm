<cfset emailall = "">
<cfset emailallnominators = "">
<h1>Listing nominations</h1>

<table class="table table-striped">
<thead>
<tr>
	<th>
		Nominee
	</th>
	<th>
		District
	</th>
	<th>
		Church
	</th>
	<th>
		Date
	</th>
	<th>
		&nbsp;
	</th>
</tr>
</thead>
<tbody>
<cfoutput query="nominations" group="region">
<tr>
<td colspan="7">

<h2>#region#</h2>
</td>
</tr>
<cfoutput>
<tr>
<td>
#mailto(emailaddress=nomineeEmail, name=nomineename)#
<cfset emailall = emailall & ";" & nomineeEmail>
<cfset emailallnominators = emailallnominators & ";" & Email>
</td>
<td>
#district#
</td>
<td>
#nomineechurch#
</td>
<td>
#dateformat(createdAt)#
</td>
<td>
#showtag()#
<cfif gotRights("superadmin,office")>
#editTag()#
#deleteTag()#
</cfif>
</td>
</tr>
</cfoutput>
</cfoutput>
</tbody>
</table>

<cfoutput>
	<p>#linkTo(text="New nominations", action="new")#</p>
	<cfset emailall = replace(emailall,";","","one")>
	<p>Nominees: #mailTo(emailall)#</p>	
	<cfset emailallnominators = replace(emailallnominators,";","","one")>
	<p>Nominators: #mailTo(emailallnominators)#</p>	
	<p>#linkTo(text="View List", action="list", class="btn")#</p>
	<p>#linkTo(text="View Elected List", action="list", params="elected", class="btn")#</p>
</cfoutput>