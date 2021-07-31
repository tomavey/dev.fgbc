<cfoutput>

    <cfif !gotRights("basic") || !isLoggedIn()>
        #includePartial(partial="/charis/promo")#
    <cfelse>
        #includePartial(partial="/home/categorymenu")#
    </cfif>

    #includePartial(partial="/charis/iconblocks")#

    <hr class="g-brd-gray-light-v4 my-0">

<!---
    #includePartial(partial="video2")#

    #includePartial(partial="ourservices")#

    <hr class="g-brd-gray-light-v4 my-0">

    #includePartial(partial="recentprojects")#

    #includePartial(partial="solutions")#

    #includePartial(partial="counters")#
--->

    #includePartial(partial="/charis/news")#

    <cfif getSetting("videoStoriesIsOpen")>
    #includePartial(partial="/charis/videostories")#
    </cfif>

</cfoutput>






