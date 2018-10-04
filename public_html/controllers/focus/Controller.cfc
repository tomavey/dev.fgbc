<cfcomponent extends="controllers.Controller">

	<cffunction name="getRetreatRegions">
		<cfset retreatRegions = model("Handbookdistrict").findall(order="focusretreat")>
	</cffunction>

    <cffunction name="itemIsSoldOut" hint="used by view-helper to determine if a specific reg item should show">
    <cfargument name="itemid" required="false" type="numeric">
        <cfif isDefined("params.itemid")>
            <cfset arguments.itemid = params.itemid>
        </cfif>
        <cfset item = model("Focusitem").findOne(where="id=#arguments.itemid#")>
        <cfset itemCount = model("Focusitem").findCountSold(arguments.itemid)>

        <cfif val(item.maxtosell) is 0 OR item.maxtosell gt itemCount>
            <cfreturn false>
        <cfelse>
            <cfreturn true>
        </cfif>
    </cffunction>

</cfcomponent>