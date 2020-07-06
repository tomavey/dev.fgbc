<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset belongsTo(name="Handbookorganization", foreignkey="itemid")>
		<cfset belongsTo(name="Handbookperson", foreignkey="itemid")>
	</cffunction>

	<cffunction name="setPrayerDates">
	<cfset var loc = structNew()>
	<cfset deleteAll()>
	<cfset loc.churches = model("Handbookorganization").findAll(select="id", where="statusid IN (1,4,8,9,10,11)", include="Handbookstate", order="rand()")>
	<cfset updatePrayerDates(loc.churches,"organization")>
	<cfset loc.people = model("Handbookperson").findAll(select="id", where="p_sortorder < 500 AND statusid IN (1,4,8,9,10,11)", include="Handbookpositions(Handbookorganization),Handbookstate", order="rand()")>
	<cfset updatePrayerDates(loc.people,"person")>
	<cfreturn true>
	</cffunction>

	<cffunction name="updatePrayerDates">
	<cfargument name="items" required="true" type="query">
	<cfargument name="type" required="true" type="string">
	<cfset var loc = structNew()>

	<cfset loc.weeks = 50>
	<cfset loc.thisweek = 1>
	<cfset loc.thisdayofweek = 1>
	<cfset loc.itemsPerWeek = round(arguments.items.recordcount/loc.weeks)>

	  <cfoutput query="arguments.items">

		<cfif loc.thisdayofweek GT 7>
			<cfset loc.thisdayofweek = 1>
		</cfif>

        <cfif (NOT currentrow MOD loc.itemsPerWeek)><!---if current row is evenly divisible by loc.weeks--->
    	  	<cfset loc.thisweek = loc.thisweek +1>
    		<cfset loc.thisdayofweek = 1>
        </cfif>

			<cfset loc.pray = new()>
			<cfset loc.pray.itemid = id>
			<cfset loc.pray.type = arguments.type>
    		<cfset loc.pray.updatedBy = session.auth.email>
    		<cfset loc.pray.week = loc.thisweek>
    		<cfset loc.pray.dayofweek = loc.thisdayofweek>
			<cfset loc.pray.save()>

		<cfset loc.thisdayofweek = loc.thisdayofweek + 1>
      </cfoutput>
	  <cfreturn true>
	</cffunction>
	
</cfcomponent>