<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
			<cfset usesLayout("/handbook/layout_handbook")>
	</cffunction>

	<cffunction name="index">
		<cfset prayForPeople = model("Handbookprayer").findall(where="type='person'", order="week,dayofweek", include="Handbookperson(Handbookstate,Handbookpositions))")>
		<cfset prayForOrganizations = model("Handbookprayer").findall(where="type='organization'", order="week,dayofweek", include="Handbookorganization(Handbookstate)")>
	</cffunction>	

	<cffunction name="thisweek">
		<cfparam name="params.thisweek" default="#week(now())#">
		<cfset prayForOrganizations = model("Handbookprayer").findall(where="week=#params.thisweek# AND type='organization'", order="week,dayofweek", include="Handbookorganization(Handbookstate)")>
		<cfset prayForPeople = model("Handbookprayer").findall(where="week=#params.thisweek# AND type='person'", order="week,dayofweek", include="Handbookperson(Handbookstate,Handbookpositions))")>
		<cfset subscribed = model("Handbooksubscribe").findOne(where="email = '#session.auth.email#' AND type='prayweekly'")>
		<cfif isObject(subscribed)>
			  <cfset params.isSubscribed = true>
		</cfif>
		<cfset renderPage(action="index")>
	</cffunction>	

	<cffunction name="thisday">
		<cfparam name="params.thisweek" default="#week(now())#">
		<cfparam name="params.thisday" default="#dayofweek(now())#">
		<cfset prayForOrganizations = model("Handbookprayer").findall(where="week=#params.thisweek# AND dayofweek=#params.thisday# AND type='organization'", order="week,dayofweek", include="Handbookorganization(Handbookstate)")>
		<cfset prayForPeople = model("Handbookprayer").findall(where="week=#params.thisweek# AND dayofweek=#params.thisday# AND type='person'", order="week,dayofweek", include="Handbookperson(Handbookstate,Handbookpositions))")>
		<cfset subscribed = model("Handbooksubscribe").findOne(where="email = '#session.auth.email#' AND type='praydaily'")>
		<cfif isObject(subscribed)>
			  <cfset params.isSubscribed = true>
		</cfif>
		<cfset renderPage(action="index")>
	</cffunction>	

	<cffunction name="setprayerdates">
		<cfset model("Handbookprayer").setprayerdates()>
		<cfset redirectTo(action="index")>
	</cffunction>
	
</cfcomponent>