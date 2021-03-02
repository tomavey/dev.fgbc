<cfoutput>
  <p>
    <cfif !isDefined("params.request") && !isDefined("params.key")>
      #linkTo(text="Show only reports with special requests", params="request=1")#
    <cfelse>
      #linkTo(text="Show all reports", params="")#
    </cfif>
 
  </p>
  <cfscript>
    for (statistic in statistics) {
      writeOutput(includePartial("show"))
    }
  </cfscript>
</cfoutput>