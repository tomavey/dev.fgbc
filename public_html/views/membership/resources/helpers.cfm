<cffunction name="getChurchAppName">
<cfargument name="appid" required="true">
<cfset var loc=structNew()>
<cfif val(params.key)>
	<cfset loc.whereString = "id=#arguments.appid#">
<cfelse>
	<cfset loc.whereString = "uuid='#arguments.appid#'">
</cfif>	

<cfdump var="#loc#"><cfabort>
<cfset loc.return = "">
	<cfset app = model("Membershipapplication").findOne(where=loc.whereString)>
	<cfif isObject(app)>
		<cfset loc.return = app.name_of_church & "-" & app.city & " (" & app.principle_leader & ")">
	</cfif>
	<cfreturn loc.return>
</cffunction>