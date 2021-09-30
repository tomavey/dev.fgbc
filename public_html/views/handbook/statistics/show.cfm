<cfoutput>
  <p>
    <cfif !isDefined("params.request") && !isDefined("params.key")>
      #linkTo(text="Show only reports with special requests", params="request=1", class="btn")#
    <cfelse>
      #linkTo(text="Show all reports", params="", class="btn")#
    </cfif>
 
  </p>
  <cfscript>
      for (statistic in statistics) {
          writeOutput(includePartial("show"))
      }
  </cfscript>
</cfoutput>