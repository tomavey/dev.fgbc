<div id='selectworkshops' class="container">

<cfoutput>
    <cfif !isAuthorizedForCohorts()>

        #includePartial("selectPersonToSelect")#

    <cfelse>

        #includePartial("showSelected")#

    </cfif>    
</cfoutput>

</div>