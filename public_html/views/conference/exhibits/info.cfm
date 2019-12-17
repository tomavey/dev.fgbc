<cfparam name="natmin" default="false">
<cfif isdefined("params.natmin")>
	<cfset natmin = "true">
</cfif>


<div id="exhibitorguidelines" class="container">
  <cfoutput>
    <h1>EXHIBIT INFORMATION for organizations <cfif !natmin>NOT </cfif>affiliated with the Charis Fellowship</h1>
    <cfif !natmin>
      <p style="font-size:.8em;color:gray">
      #linkto(text="Official Charis Fellowship Ministries should use this link", action="info", params="natmin=1")#
    </cfif>
    
    <p>#getEventAsText()# is at <a href="http://grace.edu">the Grace College campus in Winona Lake, Indiana</a>.</p>
    </p>
    
    <p>WE ARE EXPECTING 400+ conference attenders. Most (80%+) attenders are pastors, staff and leaders from more than 250 churches in the USA and Canada. Exhibits must be set up by Monday evening and will be accessible from Tuesday, July 21 through lunch on Thursday, July 23.  All exhibits must be removed by 4:00 PM Thursday afternoon. </p>
    
    <p>You may select either "table only", "space only" or both if space is available.</p>

    <p>SPACE ONLY can be requested for standalone displays (8ft X 3ft).  Exhibitors may not provide their own tables but stand up displays and racks are permitted.</p>

    <p>Electric Hook-up is available for an additional $25 per exhibitor if requested prior to conference.</p>
    <br/>

    <ul>
        <li>
          8' Table with floor length table cover: <cfif natmin>$350 <cfelse>$700 </cfif>per table
        </li>
        <li>
          Exhibit Space (8' X 3'): <cfif natmin>$300 <cfelse>$600 </cfif>
        </li>
        <li>
          Electrical hook-up: $25
        </li>  
    </ul>

    <p>Exhibitors are responsible for shipping their materials and exhibits to conference locations, exhibits set-up, security, and removal. Please ship to the following address between the dates of July 13-18, 2020.</p>
    <p>Grace College<br/>
      Alumni Engagement-Access2020<br/>
      200 Seminary Dr.<br/>
      Winona Lake, IN 46590<br/>
    </p>

    <p>As a courtesy to our conference planners, all exhibitors must leave their exhibit and join the main celebrations before each celebration's scheduled time.</p>
    <p>Your fee for exhibit space and or tables does not include registration for your staff. Each staff member should register for the conference.</p>
    <p style="color: red">
      Deadline for exhibit request is June 30, 2020.
    </p>
    <p>Please complete your request form with the link below. Please contact Sharmion Bowell at: sharmion@charisfellowship.us or (574)&nbsp;269&##8209;1269 for additional questions.</p>
    <p class="well">#linkTo(controller="conference/exhibits", action="new", text="Go to the Exhibitors Request Form", class="btn btn-block btn-primary btn-lg")#</p>
    </cfoutput>
</div>
