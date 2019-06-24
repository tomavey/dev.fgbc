<cfinclude template="../helpers.cfm">

<cfscript>
  function ticketsToTable(tickets) {
    var ticketsArr = listToArray(tickets,";")   
    var ticketsTable = "<table><tr>"
    var ticket = ""
    for ( ticket in ticketsArr) {
      ticketsTable = ticketsTable & "<td class='mealTicket #removeCountFromTicket(ticket)#'>" & removeCountFromTicket(ticket) & "</td>"
    }
    ticketsTable = ticketsTable & "</tr></table>"
    return ticketsTable
  }

  function removeCountFromTicket(ticket) {
    var count = val(ticket)
    var countAsString = toString(count)
    var ticket = replace(ticket,countAsString,"")
    return trim(ticket)
  }
</cfscript>