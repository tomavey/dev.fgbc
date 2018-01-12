<cfheader statuscode="404" statustext="Not Found">
<!--- Place HTML here that should be displayed when a file is not found while running in "production" mode. --->
<h1>File Not Found!</h1>
<p>
	Sorry, the page you requested could not be found.<br />
	Please verify the address.<br/>
<cftry>
        <cfset senderror = false>
        <cfset subject = "FGBC Website Error">
        <cfif cgi.path_info CONTAINS "conference">
            <cfset senderror = true>
            <cfset subject = "Conference Reg Error - page not found">
        </cfif>
        <cfif cgi.path_info CONTAINS "handbook">
            <cfset senderror = true>
            <cfset subject = "Handbook Error - page not found">
        </cfif>

        <cfif senderror>
            <cfset emailtofrom = get('errorEmailAddress')>
             <cfmail to = "#emailtofrom#" from = "#emailtofrom#" subject = "#subject#" type="html">
             <html>
             <head>
             </head>
             <body>
                            <p>
                                Error on http://www.charisfellowship.us#cgi.path_info#<cfif len(cgi.query_string)>?#cgi.query_string#</cfif> <cfif len(cgi.http_referer)> from #cgi.http_referer#</cfif>
                            </p>
                            <cfif isDefined("session.cfcatch.message")>
                                <p>Error Message:</p>
                                <p>#session.cfcatch.message#</p>
                            </cfif>
                            <cfif isDefined("session.cfcatch.stacktrace")>
                                <p>Stack Trace</p>
                                <p>#session.cfcatch.stacktrace#</p>
                            </cfif>
                            <cfif isDefined("cgi.http_user_agent")>
                                <p>User Agent</p>
                                <p>#cgi.http_user_agent#</p>
                            </cfif>
                            <p>Reload web site: http://www.charisfellowship.us/?reload=true&password=mack</p>
                 </body>
                 </html>
            </cfmail>


        </cfif>
<cfcatch><p>Email notice not sent!</p></cfcatch>
</cftry>


</p>