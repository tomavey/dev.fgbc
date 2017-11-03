<cfoutput>

    <cfif !gotRights("basic")>
        #includePartial("/charis/promo")#
    <cfelse>
        #includePartial("/home/categorymenu")#
    </cfif>
    #includePartial("/charis/iconblocks")#

    <hr class="g-brd-gray-light-v4 my-0">

<!---
    #includePartial("video2")#

    #includePartial("ourservices")#

    <hr class="g-brd-gray-light-v4 my-0">

    #includePartial("recentprojects")#

    #includePartial("solutions")#

    #includePartial("counters")#
--->

    #includePartial("/charis/news")#

</cfoutput>






