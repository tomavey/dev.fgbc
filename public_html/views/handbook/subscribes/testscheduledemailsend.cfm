Test of email send<br/>
<cfoutput>

<cfif isDefined("params.key")>
Key = #params.key#<br/>
</cfif>
Time = #now()#<br/>
</cfoutput>
<cfdump var="#cgi#">