<!--- Place code here that should be executed on the "onRequestStart" event. --->

<cfloop collection="#form#" item="key">
<cftry>
<cfset form[key] = Trim(form[key])>
<cfcatch></cfcatch>
</cftry>
</cfloop>