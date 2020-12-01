<cfparam name="cohorts" required="true" type="query">
<cfparam name="params.type" default="cohort">
<cfoutput>

<div class="container">

    <cfif !isAuthorizedForCohorts()>

        #includePartial(partial="selectPersonToSelect")#

    <cfelse>

        #includePartial(partial="select")#

    </cfif>

    </div><!---Container--->

</cfoutput>