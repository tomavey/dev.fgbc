<cfheader statuscode="500" statustext="Internal Server Error">
<!--- Place HTML here that should be displayed when an error is encountered while running in "production" mode. --->
<h1>Error!</h1>
<p>
	Sorry, that caused an unexpected error.<br />
	Please try again later..<br/><br/>
<!----    
    <cfoutput>
                                <cfloop from="1" to="#ArrayLen(arguments.exception.tagContext)#" index="ii">
                                    <p>
                                        Code:<br/> #arguments.exception.tagContext[ii].codePrintHtml#
                                        Line: #arguments.exception.tagContext[ii].line#<br/>
                                        Template: #arguments.exception.tagContext[ii].template#<br/>
                                    ------------------------------------------
                                    </p>
                                </cfloop>
     </cfoutput>
     <cfdump var="#arguments.exception#">                           
---->
       
<cftry>
        <cfset senderror = false>
        <cfset subject = "FGBC Website Error">

        <cfif cgi.path_info CONTAINS "conference" && isConferenceErrorEmailOn()>
            <cfset senderror = true>
            <cfset subject = "Conference Reg Error">
        </cfif>

        <cfif cgi.path_info CONTAINS "handbook" && isHandbookErrorEmailOn()>
            <cfset senderror = true>
            <cfset subject = "Handbook Error">
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
                            <cfif isDefined("arguments.exception.message")>
                                <p>Error Message:</p>
                                <p>#arguments.exception.message#</p>
                            </cfif>
                            <cftry>
                                <cfif isArray(arguments.exception.tagContext)>
                                    <cfloop from="1" to="#ArrayLen(arguments.exception.tagContext)#" index="ii">
                                        <p>
                                            Code:<br/> #arguments.exception.tagContext[ii].codePrintHtml#
                                            Line: #arguments.exception.tagContext[ii].line#<br/>
                                            Template: #arguments.exception.tagContext[ii].template#<br/>
                                        ------------------------------------------
                                        </p>
                                    </cfloop>
                                </cfif>
                            <cfcatch></cfcatch></cftry>
                            <cfif isDefined("arguments.exception.stacktrace")>
                                <p>Stack Trace</p>
                                <p>#arguments.exception.stacktrace#</p>
                            </cfif>
                            <cfif isDefined("cgi.http_user_agent")>
                                <p>User Agent</p>
                                <p>#cgi.http_user_agent#</p>
                            </cfif>

                            <cfif isDefined("session.auth.username")>
                                <p>Username</p>
                                <p>#session.auth.username#</p>
                            </cfif>
                            <cfif isDefined("session.auth.email")>
                                <p>User email</p>
                                <p>#session.auth.email#</p>
                            </cfif>
                            <cfif isDefined("session.auth.rightslist")>
                                <p>User rightslist</p>
                                <p>#session.auth.rightslist#</p>
                            </cfif>
                            <p>Reload web site: http://www.charisfellowship.us/?reload=true&password=charis</p>
                 </body>
                 </html>
            </cfmail>


        </cfif>
<cfcatch><p>Email error notice not sent!</p></cfcatch>
</cftry>

</p>