<div class="container">
<h2>Duplicate users with the same email address</h2>
<table>
<tr>
<th>Username</th>
<th>Email</th>
<th>Created</th>
<th>Last login</th>
</tr>
<cfoutput query="users">
<tr>
<td>#username#</td>
<td>#email#</td>
<td>#dateformat(createdat)#</td>
<td>#dateformat(lastloginat)#</td>
<td>#showtag()#</td>
</tr>
</cfoutput>
</table>
</div>