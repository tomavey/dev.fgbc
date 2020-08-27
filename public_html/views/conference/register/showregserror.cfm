<p>There was an error during the final showres step of a registration.</p>

<cfif isDefined("cfcatch.message")>
    <cfoutput>
        Error message: #cfcatch.message#<br/>
    </cfoutput>
</cfif>

<cfif isDefined("cgi.HTTP_REFERER")>
    <cfoutput>
        Referrer: #cgi.HTTP_REFERER#<br/>
    </cfoutput>
</cfif>

<cfif isDefined("cgi.path_info")>
    <cfoutput>
        Path: #cgi.path_info#<br/>
    </cfoutput>
</cfif>

