<cfinclude template="../helpers.cfm">

<cfscript>
  function ticketsToTable(tickets) {
    var ticketsArr = listToArray(tickets,";")   
    var ticketsTable = "<div class='ticketsTable'>"
    var ticket = ""
    for ( ticket in ticketsArr) {
      ticketsTable = ticketsTable & "<p class='mealTicket #removeCountFromTicket(ticket)#'>" & shortCodeForTicket(removeCountFromTicket(ticket)) & "</p>"
    }
    ticketsTable = ticketsTable & "</div>"
    return ticketsTable
  }

  function removeCountFromTicket(ticket) {
    var count = val(ticket)
    var countAsString = toString(count)
    var ticket = replace(ticket,countAsString,"")
    return trim(ticket)
  }

  function shortCodeForTicket(ticket) {
    var codes = structNew()
    var code = ""
    codes.BFastGCSTue = "GCS-TB"
    codes.LunchEWPTue = "ENC-TL"
    codes.DinnerInspTueCouple = "ICp-TD"
    codes.DinnerInspTueSingle = "ISg-TD"
    codes.BFastBMHWed = "BMH-WB"
    codes.LunchCPWed = "ChP-LW"
    codes.DinnerEagleWed = "EGL-WD"
    codes.BFastCENThu = "CEN-RB"
    codes.LunchFGBCThu = "ChF-RL"
    try {
      code = codes[ticket]
    } catch (any e) {
      code = "NA"
    }
    return code
  }

</cfscript>