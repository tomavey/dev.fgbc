<!DOCTYPE html>
<html lang="en">

<cfoutput>

    #includePartial(partial="head")#

        <body>

            <main>

                #includePartial(partial="header")#

                #contentForLayout()#

                #includePartial(partial="footer")#

            </main>

        <div class="u-outer-spaces-helper"></div>

        #includePartial(partial="jsIncludeTags")#

    </body>

</cfoutput>

</html>