Session.auth
<cftry>
<cfdump var="#session.auth#">
<cfcatch></cfcatch>
</cftry>

Session.return
<cftry>
<cfdump var="#session.return#">
<cfcatch></cfcatch>
</cftry>

<cftry>
Cookies:
<cfdump var="#cookie#">
<cfcatch></cfcatch>
</cftry>
<cftry>
Set Return To:
<cfdump var="#session.originalUrl#">
<cfcatch></cfcatch>
</cftry>
Params:
<cfdump var="#params#">
