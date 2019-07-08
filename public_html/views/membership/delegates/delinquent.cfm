<cfparam name="params.repeat" default="yes">
<cfparam name="params.showall" default="no">
<cfparam name="allEmails" default="">

<cfset count = 0>
<h3>Member Churches that have not yet submitted their delegate form.</h3>
  <cfoutput>
<cfif NOT isDefined("params.download")>
  <cfif isDefined('params.showall') && params.showAll>
    #linkTo(text="Download as excel", action="delinquent", params="download=1&showall=1", class="btn")#
  <cfelse>
    #linkTo(text="Download as excel", action="delinquent", params="download=1", class="btn")#
  </cfif>
</cfif>

<cfif !params.repeat>
  #linkTo(text="Include copy to the pastors email", controller="membership.delegates", action="delinquent", params="repeat=false", class="btn")#
<cfelse>  
  #linkTo(text="Don't Include copy to the pastors email",  controller="membership.delegates", action="delinquent", params="repeat=true", class="btn")#
</cfif> 
<cfif !params.showall>
  #linkTo(text="Show All Churches", controller="membership.delegates", action="delinquent", params="showall=true", class="btn")#
<cfelse>  
  #linkTo(text="Show Only Deliqnuent Churches", controller="membership.delegates", action="delinquent", params="", class="btn")#
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
  <cfif !churchHasSubmittedDelegates(id) || params.showall>
  <tr>
    <td>#linkto(text=selectname, controller="handbook-statistics", action="show", key=id)#</td>
    <td>#getDelegatesAllowed(id)#</td>
      <cfset allEmails = allEmails & "; " & email>
	   <td>#mailto(email)#</td>
      <td>#linkTo(route="sendmydelegates", key=id, onlyPath=false, protocol="https")#<td>
	  <cfset count = count +1>
  </tr>  

  <!---Repeats the row if the church email NEQ leaders email--->
  	<cfset leaderEmail = getleaderEmail(id)>
    <cfif leaderEmail NEQ email and leaderEmail NEQ false and params.repeat>
      <cfset allEmails = allEmails & "; " & leaderEmail>
    <tr>
      <td>#linkto(text=selectname, controller="handbook-statistics", action="show", key=id)#</td>
      <td>#getDelegatesAllowed(id)#</td>
	    <td>#mailto(LeaderEmail)#</td>
      <td>#linkTo(route="sendmydelegates", key=id, onlyPath=false, protocol="https")#<td>
    </tr>  
    </cfif>
	
  <!---Repeats the row if there is a GTD emailfor the church (in the Organization field Email2--->
    <cfif len(email2) and params.repeat>
    <tr>
      <td>#linkto(text=selectname, controller="handbook-statistics", action="show", key=id)#</td>
      <td>#getDelegatesAllowed(id)#</td>
	    <td>#mailto(email2)#</td>
      <td>#linkTo(route="sendmydelegates", key=id, onlyPath=false, protocol="https")#<td>
    </tr>  
    </cfif>

  <!---Repeats the row if there is a GTD indicator for church staff (in the Person field GTD - yes or no--->
  	<cfset gtdEmail = getGtdEmail(id)>
    <cfif gtdEmail NEQ email and gtdEmail NEQ false and params.repeat>
    <tr>
      <td>#linkto(text=selectname, controller="handbook-statistics", action="show", key=id)#</td>
      <td>#getDelegatesAllowed(id)#</td>
	    <td>#mailto(gtdEmail)#</td>
      <td>#linkTo(route="sendmydelegates", key=id, onlyPath=false, protocol="https")#<td>
    </tr>  
    </cfif>
  </cfif>

</cfoutput>
<tbody>
</table>
<cfoutput>
<p>Church count = #count#</p>
<p>Out of: #churches.recordcount#</p>

<p>Email All: #fixEmailList(allEmails)#</p>
</cfoutput>