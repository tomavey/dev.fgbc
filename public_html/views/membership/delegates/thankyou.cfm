<center>
<h1>Thank You!</h1>
<cfif isDefined("delegates.submitteremail")>
    <p>Your delegate list has been sent to the Charis Fellowship office and to <cfoutput>#delegates.submitteremail#</cfoutput></p>
    <p>Please save the email for your records. It contains a link that can be used to edit or add to your list of delegates.</p>
    <cfoutput>
    <cftry>
    <p>Or you can bookmark this link: <a href="https://charisfellowship.us/membership/delegates/#params.key#">charisfellowship.us/membership/delegates/#params.key#</a></p>
    <cfcatch></cfcatch></cftry>
    <h2 class="well">When ready (soon!), delegate instructions and reports will be available at<br/> <a href="#getDelegatesReportPage()#">#getDelegatesReportPage()#</a>.<br/>  Please share this link with all your delegates</a></h2>
</cfoutput>
</center>
</cfif>