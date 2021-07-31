<cfset previousemail = "">

<cfif isDefined("params.csv")>
  <cfoutput>#people#</cfoutput>
<cfelse>

  <cfif isdefined("params.download") and params.download is "excel">
  <cfelse>	
    <cfoutput>
      #linkTo(text="Download as excel", controller="handbook.people", action="focus", key=params.key, params="download=excel&includeWomen=#params.includeWomen#&yearsAgo=#params.yearsago#&params.key", class="btn")#
      #linkTo(text="View CSV", controller="handbook.people", action="focus", key=params.key, params="includeWomen=#params.includeWomen#&yearsAgo=#params.yearsago#&csv", class="btn")#
      <p>
        Using past #params.yearsago# years of focus registrations 
        <cfif isDefined("params.includeWomen") && params.includeWomen > including women </cfif>  
      </p>
    </cfoutput>
  </cfif>

  <cfset count = 0>

  <table>
    <tr>
      <td>
      First Name or Church Name
      </td>
      <td>
      Last Name
      </td>
      <td>
      Email
      </td>
      <td>
        Cell
      </td>
      <td>
        Source
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
        #phone#
      </td>
      <td>
        #source#
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

</cfif>