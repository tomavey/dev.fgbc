<!DOCTYPE html>
<html lang="en">
<cfoutput>

    #includePartial("/charis/head")#

    #includePartial(partial="/charis/modal_login", dataFunction="setUserObjectForHeader")#

    #includePartial("/charis/modal_rebrand")#

        <body>

            <main>

                #includePartial(partial="/charis/header", dataFunction="setUserObjectForHeader")#

                #contentForLayout()#

                <cfif !isDefined("params.noFooter")>
                    #includePartial(partial="/charis/footer", dataFunction="footer")#
                </cfif>

            </main>

        <div class="u-outer-spaces-helper"></div>

        #includePartial("/charis/jsIncludeTags")#

<cfif application.wheels.environment NEQ "production">
    <cftry>
    <cfdump var="#session.auth#" label="session auth">
    #session.auth.rightslist#
    #gotrights("handbook")#
    <cfdump var="#cgi#" label="Cgi">
    <cfcatch>
    </cfcatch>
    </cftry>
</cfif>

<!--- <cfif isDefined("params.showRightsList")>
    <p>#session.auth.rightslist#</p>
    <p>#gotrights("office,conferenceEditor")#</p>
</cfif> --->


    </body>

</cfoutput>

</html>