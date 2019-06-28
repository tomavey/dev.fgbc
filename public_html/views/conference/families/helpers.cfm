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

  function ticketsToPipeList(tickets) {
    var ticketsArr = listToArray(tickets,";")
    var ticketsPipeList = ""
    var ticket = "| "
    for (ticket in ticketsArr) {
      ticketsPipeList = ticketsPipeList & " | " & shortCodeForTicket(removeCountFromTicket(ticket))
    }
    ticketsPipeList = replace(ticketsPipeList, "| ", "")
    return ticketsPipeList
  }

  function ticketsToSpanList(tickets) {
    var ticketsArr = listToArray(tickets,";")
    var ticketsList = ""
    var ticket = "| "
    for (ticket in ticketsArr) {
      var ticketClass = removeCountFromTicket(ticket)
      ticketsList = ticketsList & "<span class='spanList #ticketClass#'>" & shortCodeForTicket(removeCountFromTicket(ticket)) & "</span>"
    }
    ticketsList = replace(ticketsList, "| ", "")
    return ticketsList

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
    codes.BFastGCSTue = "GCS-TueBfast"
    codes.LunchEWPTue = "ENC-TueLunch"
    codes.DinnerInspTueCouple = "IN2-TueDinnr"
    codes.DinnerInspTueSingle = "IN1-TueDinnr"
    codes.BFastBMHWed = "BMH-WedBfast"
    codes.LunchCPWed = "ChP-WedLunch"
    codes.DinnerEagleWed = "EGL-WedDinnr"
    codes.BFastCENThu = "CEN-ThuBFast"
    codes.LunchFGBCThu = "ChF-ThuLunch"
    try {
      code = codes[ticket]
    } catch (any e) {
      code = "NA"
    }
    return code
  }

</cfscript>