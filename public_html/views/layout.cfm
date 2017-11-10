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

    </body>

</cfoutput>

</html>