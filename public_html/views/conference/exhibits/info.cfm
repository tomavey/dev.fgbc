<cfparam name="natmin" default="true">
<cfif isdefined("params.natmin") && !params.natmin>
	<cfset natmin = "false">
</cfif>


<div id="exhibitorguidelines" class="container">
  <cfoutput>
    <h1>EXHIBIT INFORMATION for organizations <cfif !natmin>NOT </cfif>affiliated with the Charis Fellowship</h1>
    <cfif natmin>
      <p style="font-size:.8em;color:gray">
      #linkto(text="Ministries that are NOT official Charis Fellowship Ministries should use this link", action="info", params="natmin=0")#
    </cfif>
    
    <p>#getEventAsText()# is at <a href="https://gracecommunity-church.com/">Grace Community Church in Goshen, Indiana</a>.</p>
    </p>
    
    <p>WE ARE EXPECTING 400+ conference attenders. Most (80%+) attenders are pastors, staff and leaders from more than 250 churches in the USA and Canada. Exhibits must be set up by Monday evening by 6pm, July 26 and will be accessible from Tuesday, July 27 through lunch on Thursday, July 29.  All exhibits must be removed by 4:00 PM Thursday. </p>
    
    <p>You may select either "table only", "space only" or both if space is available.</p>

    <p>SPACE ONLY can be requested for standalone displays (8' X 3').  Exhibitors may not provide their own tables but stand up displays and racks are permitted.</p>

    <p>Electric hook-up is available for an additional $25 per exhibitor if requested prior to conference.</p>
    <br/>

    <ul>
        <li>
          6-8' Table with floor length table cover: <cfif natmin>$350 <cfelse>$700 </cfif>per table
        </li>
        <li>
          Exhibit space (8' X 3'): <cfif natmin>$300 <cfelse>$600 </cfif>
        </li>
        <li>
          Electrical hook-up: $25
        </li>  
    </ul>

    <p>Exhibitors are responsible for shipping their materials and exhibits to conference locations, exhibit set-up, security, and removal. Please ship to the following address between the dates of July 19-23, 2021.</p>
    <p>Grace Community Church - Access2021<br/>
      20076 County Rd 36<br/>
      Goshen, IN 46526<br/>
    </p>

    <p>As a courtesy to our conference planners, all exhibitors must leave their exhibit and join the main celebrations before each celebration's scheduled time.</p>
    <p>Your fee for exhibit space and/or tables does not include registration for your staff. Each staff member should register for the conference.</p>
    <p style="color: red">
      Deadline for exhibit request is June 30, 2021.
    </p>
    <p>Please complete your request form with the link below. Please contact Sharmion Bowell at: sharmion@charisfellowship.us or 574-269-1269 with additional questions.</p>
    <p class="well">#linkTo(route="conferencenewexhibitform", text="Go to the Exhibitor Request Form", class="btn btn-block btn-primary btn-lg")#</p>
    <p style="font-size:.8em;text-align:center">
      After your exhibit has been approved, use this link to pay for your space and or table: #linkto(text="Payment page", href="https://charisfellowship.regfox.com/access2021-exhibitor-registration")#
    </p>
    </cfoutput>
</div>
