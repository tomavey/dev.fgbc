<cfparam name="natmin" default="false">
<cfif isdefined("params.key") and params.key is "natmin">
	<cfset natmin = "true">
</cfif>


<div id="exhibitorguidelines" class="container">
    <h1>EXHIBIT INFORMATION for organizations <cfif not natmin>NOT </cfif>affiliated with the FGBC</h1>
    <cfif not isDefined("params.key") OR params.key NEQ "natmin">
    <p style="font-size:.8em;color:gray">
    <cfoutput>
    #linkto(text="Charis Fellowship Ministries should use this link", key="natmin")#
    </cfif>
    <p>#getEventAsText()# is at <a href="http://ohiograce.com/">the Grace Community Church in Fremont, Ohio</a>.</p>
    </p>
    </cfoutput>
    <p>TABLES with floor length cover will be provided as requested.</p>
    <p>SPACE ONLY can be requested for stand alone displays.  Exhibitors may not provide their own tables.</p>
    <p>WE ARE EXPECTING 600+ conference attenders. Most (80%+) attenders are pastors, staff and leaders from more than 250 churches in the USA and Canada. Exhibits will be accessible from Tuesday morning (7/25) through Thurday evening (7/27). All exhibits must be removed by 11:00 Thursday evening. Prime times will be before and after meals and celebrations. </p>
    <ul>
        <li>Table with floor length cover: <cfif natmin>$300 <cfelse>$600 </cfif>per table.</li>
        <li>Space only (8ft X 3ft): <cfif natmin>$250 <cfelse>$500 </cfif>per space. Stand up displays and racks are permitted.</li>
    </ul>
    <p>As a courtesy to our conference planners, all exhibitors must leave their exhibit and join the main celebrations before each celebration's scheduled time.</p>
    <p>Electric Hook-up: <cfif natmin>$25 <cfelse>$50 </cfif> per exhibitor if requested prior to conference.</p>
    <p>Shipping information will be sent about June 1st to each exhibitor upon receipt of an official request with payment. Please send your request on the form below as soon as possible.</p>
    <p>Please address questions to Sandy Barrett at: <a href="mailto:sandy@charisfellowship.us">sandy@charisfellowship.us</a> or (574) 269-1269</p>
    <p>Use the following form to submit your request for exhibit space. <cfif natmin>You <cfelse>If approved, you </cfif>will be given instructions for how to pay for your exhibit space by email. Exhibit space must be paid for in advance of July 1, 2016.</p>
    <cfoutput>#linkTo(controller="conference/exhibits", action="new", text="Go to the Exhibitors Request Form", class="btn")#</cfoutput>
</div>
