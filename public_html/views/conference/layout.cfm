<!DOCTYPE html>
<html lang="en">

<cfinclude template="includes2016/_head.cfm" />

<body id="registrationCenter">

<div id="fb-root"></div>

<cfinclude template="includes2016/_header.cfm" />
<cfinclude template="includes2016/_introregister.cfm" />

<cfoutput>#includeContent()#</cfoutput>

<cfinclude template="includes2016/_footer.cfm" />

<!-- end Document -->

<cfinclude template="includes2016/_javascripts.cfm" />

<cfif isDefined("params.debug")>
<cftry>
<cfdump var="#debug#">
<cfcatch></cfcatch></cftry>
</cfif>

<!-- Google analytics here -->
</body>
</html>
