<!--- <cfdump var="#badges#"><cfabort> --->
<cfparam name="params.showTicketsAs" default="tableList">
<style>
  @media all {
    .pageBreak {
      page-break-after: always;
      height: 100%;
      margin-top:200px
      border-bottom: 1px dotted lightgray
    }

    body {
      text-align: center;
      height: 100%
    }  

    .badgeName {
      margin-bottom: 90px
    }

    .badgeFName,
    .badgeLName {
      font-size:4em;
      font-weight: bold;
      margin: 20px
    }

    .eachBadge {
      margin: 100px 0 100px 0;
      height: 50%
    }

    .logo {
      width: 300px;
      height: auto
    }

    p.mealTicket {
      display: inline-block;
      border-radius: 30px;
      text-align: center;
      padding:15px;
      font-weight: bold;
      font-size: 1.2em;
      line-height: 1;
      margin-right:2px;
    }

    p.BFastGCSTue {
      background-color: lightblue
    }

    p.LunchEWPTue {
      background-color: lightcoral
    }

    p.DinnerInspTueCouple {
      background-color:lightcyan
    }

    p.DinnerInspTueSingle {
      background-color:  lightgreen
    }

    p.DinnerInspTueSingle {
      background-color: lightgreen
    }

    p.BFastCENThu {
      background-color: lightpink
    }

    p.LunchFGBCThu {
      background-color: lightsalmon
    }

    p.LunchCPWed {
      background-color: lightseagreen
    }

    p.BFastBMHWed {
      background-color: lightsteelblue
    }

    p.DinnerEagleWed {
      background-color: lightskyblue
    }

  }

</style>

<cfscript>  
  var forWorkshops = false
  if (isDefined("params.forWorkshops") || isDefined("params.download")) {
    forWorkshops = true
  }
</cfscript>

<cfset count = 0>
<cfset page = 1>
<cfset previousName = "">
<cfset previousPage = 1>
<cfset newPage = 1>

<table class="table">

  <cfoutput query="badges">
    <cfif previousname NEQ fullname>
    <cfset count = count + 1>
    <cfif count MOD 2 is 0>
      <cfset page = page + 1>
    </cfif>   
      <cfif newPage>
        <div class="pageBreak">
      </cfif>
        <div class="eachBadge">
          <img src="https://charisfellowship.us/images/conference/Access_Final_2-d.jpg" class="logo" />
          <div class="badgeName">
            <p class="badgeFName">
              #capname(fname)#
            </p>
            <p class="badgeLName">
              #capname(lname)#
            </p>
          </div>
          <p class="badgeTickets">
            #ticketsToPipeList(thisPersonsMealTickets(id,equip_familiesID,type))#
          </p>
        </div>
        <cfset previousname = fullname>

      <cfif previousPage NEQ page>
        <cfset newPage = 1>
        </div>
      <cfelse>
        <cfset newPage = 0>  
      </cfif>
      <cfset previousPage = page>

    </cfif>
    </cfoutput>
</table>

<cfoutput>Count: #count#</cfoutput>
