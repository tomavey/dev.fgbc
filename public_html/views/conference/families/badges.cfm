<cfsavecontent variable="badgecontent">
  <!--- <cfdump var="#badges#"><cfabort> --->
<cfparam name="params.showTicketsAs" default="pipeList">
<cfset badgesArray= []>

<style>
  .spanList {
    color:blue
  }
  .BFastBMHWed {
    background-color: red;
    display: block;
    width:150px;
    border-radius:10px;
  }
</style>

<cfscript>  
  var forWorkshops = false
  if (isDefined("params.forWorkshops") || isDefined("params.download")) {
    forWorkshops = true
  }
</cfscript>

<cfset count = 0>
<cfset previousname = "">
<cfset previoustickets = "">
  <cfif !isdefined("params.download")>
  <cfoutput>
    #startFormTag(action="badges")#
    #dateSelectTags(name="date")#
    #submitTag("Date After")#
    #endFormTag()#

    <cfif isDefined("params.previousyear")>
      #linkTo(text="Download as Excel", action="badges",  params="download=true&previousyear&showticketsas=#params.showticketsas#")#
    <cfelseif isDefined("params.date")>
      #linkTo(text="Download as Excel", action="badges",  params="download=true&date=#dateformat(params.date,'yyyy-mm-dd')#&showticketsas=#params.showticketsas#")#
    <cfelse>
      #linkTo(text="Download as Excel", action="badges",  params="download=true&showticketsas=#params.showticketsas#")#
    </cfif>
    <cfif not isDefined("params.previousyear")>
      <p>#linkTo(text="Previous Year", action="badges", params="previousyear&showticketsas=#params.showticketsas#")#</p>
    <cfelse>
      <p>#linkTo(text="Current Year", action="badges")#</p>
    </cfif>
    <p>#linkTo(text="Print", action="badges", params="print=yes")#&nbsp;|&nbsp;
    <!--- <cfif getSetting("requireRegForBadge")>
      <p>Persons registration required inorder to show badge</p>
    </cfif> --->
    <cfif !isDefined("params.asJson")>
      #linkTo(text="Json", action="badges", params="asjson")#</p>
    </cfif>

  </cfoutput>
</cfif>

<table class="table">

  <cfif isDefined("params.previousyear")>
  <tr>
    <th colspan="2"><h2>Badges for Previous Year</h2>
    <p>for comparison</p></th>
  </tr>
  </cfif>

  <tr>
  	<th>FName</th>
  	<th>LName</th>
    <cfif forWorkshops>
    <th>Email</th>
    <th style="text-align:center">Signup for Cohorts</th>
    </cfif>
    <th>Tickets Info
      <cfoutput>
        <cfif params.showticketsas NEQ "tableList">
          [#linkTo(text="As buttons", action="badges", params="showticketsas=tableList")#]&nbsp;
        </cfif>
        <cfif params.showticketsas NEQ "pipeList">
          [#linkTo(text="As | list", action="badges", params="showticketsas=pipeList")#]&nbsp;
        </cfif>  
        <cfif params.showticketsas NEQ "spanList">
          [#linkTo(text="As spaced list", action="badges", params="showticketsas=spanList")#] 
        </cfif>  
      </cfoutput>
    </th>
  </tr>
  <cfoutput query="badges">
    <cfset thisBadgeStruct = {}>
    <cfset thisPersonsMeals = thisPersonsMealTickets(id,equip_familiesID,type)>
    <cftry>
      <cfset thisRow = badges.currentRow>
      <cfset nextRow = thisRow + 1>
      <cfset nextName = queryGetRow(badges,nextRow).fullname>
      <cfcatch>
        <cfset nextName = "">
      </cfcatch>
    </cftry>
    <cfif printThisBadge(fullname, previousname, nextname, thisPersonsMeals, previoustickets)>
    <tr>
    	<td>
        #linkto(text=capname(fname), controller="conference.people", action="show", key=ID, target="_blank")#
    	</td>
    	<td>#linkTo(text=capname(lname), controller="conference.families", action="show", key=equip_familiesID, target="_blank")# <cfif lname is fname>####Need's fixin'####</cfif>
        <cfset thisBadgeStruct["fullnamelastfirst"] = lname & ", " & fname>
        
    	</td>
      <cfif forWorkshops>
      <td>
        <cfif len(email)>#trim(email)#<cfelse>#trim(getSpouseEmail(id))#</cfif>
      </td>
      <td>
        #linkTo(href="http://www.charisfellowship.us/selectcohorts?type=cohort&personid=#id#")#
      </td>
      </cfif>
      <cfscript>
        var thisPerson = {}
        thisPerson.type = badges.type[badges.currentRow]
        thisPerson.personid = badges.id[badges.id]
        thisPerson.familyid = badges.equip_familiesID[badges.currentRow]
      </cfscript>
      <cfif params.showTicketsAs is "pipeList">
        <cfset thisPeronsTickets = ticketsToPipeList(thisPersonsMeals)>
        <td>#thisPeronsTickets#</td>
        <cfset thisBadgeStruct["tickets"] = thisPeronsTickets>
      <cfelseif params.showTicketsAs is "spanList">
        <td>#ticketsToSpanList(thisPersonsMeals)#</td>
      <cfelse>
        <td>#ticketsToTable(thisPersonsMeals)#</td>
      </cfif>
    </tr>
    <cfset previousname = fullname>
    <cfset previoustickets = thisPersonsMeals>
    <cfset count = count +1>
    </cfif>
    <cfif len(thisBadgeStruct)>
      <cfset arrayAppend(badgesArray,thisBadgeStruct)>
    </cfif>
  </cfoutput>
</table>

<cfoutput>
  Count: #count#
</cfoutput>

</cfsavecontent>
<cfoutput>
  <cfif !isDefined("params.asJson")>
    #badgecontent#
  <div style="margin-top:20px;padding:20px;border:2px solid black">
    <p>
      Checksums...
      <cfset ticketList = "GCS-TueBfast, ENC-TueLunch, IN-TueDnrFor1, IN-TueDnrFor2, BMH-WedBfast, ChP-WedLunch, EGL-WedDinnr, CEN-ThuBFast, ChF-ThuLunch">
      <ul>
        <cfloop index = i list = '#ticketList#'>
          <li>
             #i#:  #countOccurrences(badgecontent,i)#
          </li>
        </cfloop>
      </ul>
    </p>
    <p>
      These numbers do not account for quantity of each ticket.  It is just a simple count of each time the ticket code appears.
    </p>
  </div>
<cfelse>
    #serializeJson(badgesArray)#
  </cfif>
</cfoutput>

