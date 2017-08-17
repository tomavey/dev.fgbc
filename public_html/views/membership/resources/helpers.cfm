<cffunction name="getChurchAppName">
<cfargument name="appid" required="true" type="numeric">
<cfset var loc=structNew()>
<cfset loc.return = "">
	<cfset app = model("Membershipapplication").findOne(where="id=#arguments.appid#")>
	<cfif isObject(app)>
		<cfset loc.return = app.name_of_church & "-" & app.city & " (" & app.principle_leader & ")">
	</cfif>
	<cfreturn loc.return>
</cffunction>