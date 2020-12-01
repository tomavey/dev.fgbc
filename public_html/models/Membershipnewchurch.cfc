<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset table("fgbcnewchurches")>
		<cfset validatesPresenceOf(properties="fname", message="Please provide a first name.")>
		<cfset validatesPresenceOf(properties="lname", message="Please provide a first name.")>
		<cfset validatesPresenceOf(properties="email", message="Please provide an email address.")>
		<cfset validatesPresenceOf(properties="phone", message="Please provide a phone number.")>
		<cfset validatesPresenceOf(properties="churchcity", message="Where is you church located (city)?")>
		<cfset validatesPresenceOf(properties="churchstateid", message="Where is you church located (state)?")>
		<cfset belongsTo(name="state", modelName="Handbookstate", foreignKey="churchstateid")>
	</cffunction>

	<cffunction name="validate">
	<cfargument name="newChurchid" required="true" type="numeric">
	<cfset var loc=structNew()>
		<cfset loc.newchurch = findOne(where="id = #arguments.newchurchid#")>
		<cfset loc.newchurch.validatedAt = now()>
		<cfif loc.newchurch.update(validate=false)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>	
		</cfif>			
	</cffunction>

</cfcomponent>
