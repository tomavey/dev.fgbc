<!DOCTYPE html>
<html lang="en">
<cfoutput>

    #includePartial("/charis/head")#

    #includePartial("/charis/modal_login")#

    #includePartial("/charis/modal_rebrand")#

        <body>

            <main>

                #includePartial("/charis/header")#

                #contentForLayout()#

                #includePartial("/charis/footer")#

            </main>

        <div class="u-outer-spaces-helper"></div>

        #includePartial("/charis/jsIncludeTags")#

<cfif application.wheels.environment NEQ "production">
    <cftry>
    <cfdump var="#session.auth#">
    #session.auth.rightslist#
    #gotrights("handbook")#
    <cfcatch>
    </cfcatch>
    </cftry>
</cfif>

<cfif isDefined("params.showRightsList")>
    <p>#session.auth.rightslist#</p>
</cfif>


    </body>

</cfoutput>

</html>