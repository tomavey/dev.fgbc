<h2>Error Messages</h2>

<cftry>
<cfoutput>
Error Message:
<p>#cfcatch.message#</p>
Stack trace:
<p>#cfcatch.stacktrace#</p>
</cfoutput>
<cfcatch>
</cfcatch>
</cftry>

<cftry>
<cfdump var="#params#" format="html" label="Params:">
<cfcatch>
</cfcatch>
</cftry>

<cftry>
<cfdump var="#session.auth#" format="html" label="Session.auth:">
<cfcatch>
</cfcatch>
</cftry>