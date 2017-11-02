<!DOCTYPE html>
<html lang="en">

<cfoutput>

    #includePartial("head")#

        <body>

            <main>

                #includePartial("header")#

                #contentForLayout()#

                #includePartial("footer")#

            </main>

        <div class="u-outer-spaces-helper"></div>

        #includePartial("jsIncludeTags")#

    </body>

</cfoutput>

</html>