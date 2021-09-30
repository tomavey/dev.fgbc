<cfoutput>
  <p>
    <cfif !isDefined("params.request") && !isDefined("params.key")>
      #linkTo(text="Show only reports with special requests", params="request=1", class="btn")#
    <cfelse>
      #linkTo(text="Show all reports", params="", class="btn")#
    </cfif>
    <cfif !isDefined("params.showAsTable") && isDefined("params.key")>
      #linkTo(text="Show report as a table", params="showAsTable&keyy=#params.key#", class="btn")#
    </cfif>
 
  </p>
  <cfscript>
    if ( !isDefined("params.showAsTable") ) {
      for (statistic in statistics) {
          writeOutput(includePartial("show"))
      }} 
      else {
        writeOutput('<table class="table">')
        writeOutput('
          <th>Year</th>
          <th>ChurchID</th>
          <th>Attendance</th>
          <th>Conversions</th>
          <th>Baptisms</th>
          <th>Members</th>
          <th>Memfee</th>
          <th>Donate</th>
          <th>Relief</th>
          <th>NetMemFee</th>
        ')
      for (statistic in statistics) {
          writeOutput(includePartial("showTable"))
      }
      writeOutput('</table>')
    }
  </cfscript>
</cfoutput>