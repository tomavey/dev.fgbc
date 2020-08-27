<cfoutput>
#message.message#
<br/>
<br/>
<br/>
Subject: #message.subject#
<br/>
<cfif useTestList()>
    <cfdump var="#sendemails#" label="using test list">
</cfif>
</cfoutput>