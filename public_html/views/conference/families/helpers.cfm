<cfinclude template="../helpers.cfm">

<cfscript>
  function ticketsToTable(tickets) {
    var ticketsArr = listToArray(tickets,";")   
    var ticketsTable = "<div class='ticketsTable'>"
    var ticket = ""
    for ( ticket in ticketsArr) {
      ticketsTable = ticketsTable & "<p class='mealTicket #removeCountFromTicket(ticket)#'>" & shortCodeForTicket(ticket) & "</p>"
    }
    ticketsTable = ticketsTable & "</div>"
    return ticketsTable
  }

  function ticketsToPipeList(tickets) {
    var ticketsArr = listToArray(tickets,";")
    var ticketsPipeList = ""
    var ticket = "| "
    for (ticket in ticketsArr) {
      ticketsPipeList = ticketsPipeList & " | " & shortCodeForTicket(ticket)
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
      ticketsList = ticketsList & "<span class='spanList #ticketClass#'>" & shortCodeForTicket(ticket) & "</span>"
    }
    ticketsList = replace(ticketsList, "| ", "")
    return ticketsList

  }

  function removeCountFromTicket(ticket) {
    var count = val(ticket)
    if ( count LTE 2 ) {
      var countAsString = toString(count)
      var ticket = replace(ticket,countAsString,"")
    }
    return trim(ticket)
  }

  function separateCountFromTicket(required string ticket) {
    var ticketStruct = structNew()
    var count = val(ticket)
    var countAsString = toString(count)
    var ticket = replace(ticket,countAsString,"")
    ticketStruct.ticket = ticket
    ticketStruct.count = count
    return ticketStruct
  }

  function shortCodeForTicket(ticket) {
    var codes = structNew()
    var code = ""
    var count = 0
    var ticketStruct = {}
    ticketStruct = separateCountFromTicket(ticket)
    ticket = trim(ticketStruct.ticket)
    count = ticketStruct.count
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
      code = "**" & ticket & "**"
    }
    if ( count GT 2 ) {
      code = count & "-" & code
    }
    if ( count EQ 2 ) {
      code = code & "+"
    }
    return code
  }

  function printThisBadgeStr(thisname, previousname, nextname, thisTickets, previoustickets){
    var printThisBadge = false
    var str = " this name:" & thisname & " previousname:" & previousname & " nextname:" & nextname & " thisTickets:" & thisTickets & " previoustickets:" & previoustickets
    if ( thistickets NEQ previoustickets ) { printThisBadge = true }
    if ( thisname EQ nextname ) { printThisBadge = false }
    if ( thisname NEQ previousname ) { printThisBadge = true }
    return str
  }

  function printThisBadge(thisname, previousname, nextname, thisTickets, previoustickets){
    var printThisBadge = true
    if (thisname EQ nextname && !len(thisTickets) ) { printThisBadge = false }
    if (thisname EQ previousname && !len(thisTickets) ) { printThisBadge = false }

    // if ( thistickets NEQ previoustickets ) { printThisBadge = true }
    // if ( thisname EQ nextname ) { printThisBadge = false }
    // if ( thisname NEQ previousname ) { printThisBadge = true }
    return printThisBadge
  }

</cfscript>