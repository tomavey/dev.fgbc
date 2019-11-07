<cfset userCount = 0>
<cfset emailCount = 0>
<cfset previousEmail = "">
<div class="container">
<h2>Duplicate users with the same email address</h2>
<table>
  <cfoutput>
    <tr>
      <th>#linkto(text="Username", route="AuthUsersfindDuplicatesByEmail", params="orderBy=username&direction=ASC")#</th>
      <th>#linkto(text="Email", controller="auth/users", action="find-duplicates-by-email", params="orderBy=email&direction=ASC")#</th>
      <th>#linkto(text="Created", controller="auth.users", action="find-duplicates-by-email", params="orderBy=createdat&direction=DESC")#</th>
      <th>#linkto(text="Last Logged in", controller="auth.users", action="find-duplicates-by-email", params="orderBy=lastloginat&direction=DESC")#</th>
    </tr>
  </cfoutput>
<cfoutput query="users">
  <cfset userCount = userCount + 1>
  <cfif previousEmail NEQ email>
    <cfset emailCount = emailCount + 1>
  </cfif>
<tr>
<td>#username#</td>
<td>#email#</td>
<td>#dateformat(createdat)#</td>
<td>#dateformat(lastloginat)#</td>
<td>#showtag()#</td>
</tr>
<cfset previousEmail = email>
</cfoutput>
</table>
<cfoutput>
  User Count: #userCount#<br/>
  Email Count: #emailCount#
</cfoutput>
</div>