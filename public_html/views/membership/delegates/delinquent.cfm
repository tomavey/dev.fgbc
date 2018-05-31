<cfparam name="params.repeat" default="yes">
<cfset count = 0>
<h3>Member Churches that have not yet submitted their delegate form.</h3>
  <cfoutput>
<cfif NOT isDefined("params.download")>
  #linkTo(text="Download as excel", action="delinquent", params="download=1", class="btn")#
</cfif>

<cfif not params.repeat>
  #linkTo(text="Include copy to the pastors email", action="delinquent", params="repeat=false", class="btn")#
<cfelse>  
  #linkTo(text="Don't Include copy to the pastors email", action="delinquent", params="repeat=true", class="btn")#
</cfif> 
  </cfoutput>

<table class="table table-striped">
<thead>
<tr>
<th>
Church
</th>
<th>
Allowed
</th>
<th>
Email
</th>
<th>
  Link
 </th> 
</tr>
</thead>
<tbody>
<cfoutput query="churches">
  <cfif NOT churchHasSubmittedDelegates(id)>
  <tr>
    <td>#linkto(text=selectname, controller="handbook-statistics", action="show", key=id)#</td>
	  <td>#getDelegatesAllowed(id)#</td>
	   <td>#mailto(email)#</td>
      <td>#linkTo(route="sendmydelegates", key=id, onlyPath=false)#<td>
	  <cfset count = count +1>
  </tr>  
  <!---Repeats the row if the church email NEQ leaders email--->
  	<cfset leaderEmail = getleaderEmail(id)>
    <cfif leaderEmail NEQ email and leaderEmail NEQ false and params.repeat>
    <tr>
      <td>#linkto(text=selectname, controller="handbook-statistics", action="show", key=id)#</td>
      <td>#getDelegatesAllowed(id)#</td>
	    <td>#mailto(LeaderEmail)#</td>
      <td>#linkTo(route="sendmydelegates", key=id, onlyPath=false)#<td>
    </tr>  
    </cfif>
	

  </cfif>

</cfoutput>
<tbody>
</table>
<cfoutput>
<p>Church count = #count#</p>
<p>Out of: #churches.recordcount#</p>
</cfoutput>