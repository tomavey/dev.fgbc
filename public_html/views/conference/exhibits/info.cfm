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
    <p>#getEventAsText()# is at <a href="http://auburngrace.com/">the Auburn Grace Community Church in Auburn, California</a>.</p>
    </p>
    <p>8' TABLES with floor length cover will be provided as requested.</p>
    <p>6' TABLES are availeble if requested using the special request section of the form. These table will allow space for narrow floor stand.</p>
    <p>SPACE ONLY can be requested for stand alone displays.  Exhibitors may not provide their own tables.</p>
    <p>WE ARE EXPECTING 400+ conference attenders. Most (80%+) attenders are pastors, staff and leaders from more than 250 churches in the USA and Canada. Exhibits will be accessible from Tuesday morning (7/23) through Thurday noon (7/25). All exhibits must be removed by 5:00 Thursday evening. Prime times will be before and after meals and celebrations. </p>
    <ul>
        <li>Table with floor length cover: <cfif natmin>$350 <cfelse>$600 </cfif>per table.</li>
        <li>Space only (8ft X 3ft): <cfif natmin>$300 <cfelse>$600 </cfif>per space. Stand up displays and racks are permitted.</li>
    </ul>
    <p>Exhibitors are responsible for their exhibits set-up, security and removal.</p>
    <p>Exhibit space does not include a registration for Access. Exhibitors should register their staff at the regular rate.</p>
    <p>As a courtesy to our conference planners, all exhibitors must leave their exhibit and join the main celebrations before each celebration's scheduled time.</p>
    <p>Electric Hook-up: <cfif natmin>$25 <cfelse>$50 </cfif> per exhibitor if requested prior to conference.</p>
    <p>Shipping information will be sent about June 1st to each exhibitor upon receipt of an official request with payment. Please send your request on the form below as soon as possible.</p>
    <p>Please address questions to Sharmion Bowell at: <a href="mailto:sharmion@charisfellowship.us">sharmion@charisfellowship.us</a> or (574) 269-1269</p>
    <p>Your fee for exhibit space and or tables does not include registration for your staff.  Each staff member should register for the conference.</p>
    <p>Use the following form to submit your request for exhibit space. <cfif natmin>You <cfelse>If approved, you </cfif>will be given instructions for how to pay for your exhibit space by email. Exhibit space must be paid for in advance of July 1.</p>
    <p class="well">#linkTo(controller="conference/exhibits", action="new", text="Go to the Exhibitors Request Form", class="btn btn-block btn-primary btn-lg")#</p>
    </cfoutput>
</div>
