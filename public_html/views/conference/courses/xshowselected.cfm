<div id='selectworkshops' class="container">

<cfoutput>
    <cfif !isAuthorizedForCohorts()>

        #includePartial(partial="selectPersonToSelect")#

    <cfelse>

        #includePartial(partial="showSelected")#

    </cfif>    
</cfoutput>

</div>