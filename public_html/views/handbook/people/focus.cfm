<cfset previousemail = "">
<cfif isdefined("params.download") and params.download is "excel">
<cfelse>	
	<cfoutput>#linkTo(text="Download as excel", key=params.key, params="download=excel", class="btn")#</cfoutput>
</cfif>

<cfset count = 0>

<table>
  <tr>
    <td>
    First Name
    </td>
    <td>
    Last Name
    </td>
    <td>
    Email
    </td>
    <td>
    Region
    </td>
  </tr>
  <cfoutput query="people">
  <cfif len(email) and email NEQ previousemail>
  <tr>
    <td>
    #fname#
    </td>
    <td>
    #lname#
    </td>
    <td>
    #email#
    </td>
    <td>
    #region#
    </td>
  </tr>
  <cfset count = count +1>
  <cfset previousemail = email>
  </cfif>
  </cfoutput>
</table>

<p>
  <cfoutput>
    Count: #count#
  </cfoutput>
</p>