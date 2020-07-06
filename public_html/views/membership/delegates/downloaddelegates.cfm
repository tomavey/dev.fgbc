<cfset emailall = "">


<table>
  <tr>
    <th>Full Name</th>
    <th>First Name</th>
    <th>Last Name</th>
    <th>Email Address</th>
    <th>CreatedAt</th>
  </tr>
  <cfoutput query="fgbcdelegates">

  		  <cfif name does not contain "delegates">
	  		<cfset hasdelegates = 1>
		  <cfelse>
	  		<cfset hasdelegates = 0>
		  </cfif>				

      <cfset email = trim(email)>
      <cfset email = replace(email," ","","all")>

   		  <cfif isvalid("email",email) and hasdelegates>
			  <cfif not listFind(emailall,email,"; ")>
				<cfset emailall = emailall & "; " & email>
        <cfset name = trim(name)>
        <cfset name = replace(name,"  ","","all")>
              <tr>
                <td>#name#</td>
                <td>#listfirst((name)," ")#</td>
                <td>#listlast(name," ")#</td>
                <td>#email#</td>
                <td>#dateformat(createdAt)#</td>
              </tr>
			  </cfif>
			<cfelseif isvalid("email",submitteremail) and hasdelegates> 	  
			  <cfif not listFind(emailall,submitteremail,"; ")>
				<cfset emailall = emailall & "; " & submitteremail>
              <tr>
                <td>#name#</td>
                <td>#submitteremail#</td>
              </tr>
				<cfset emailall = emailall & "; " & submitteremail>
			  </cfif>
			</cfif>  



  </cfoutput>
</table>