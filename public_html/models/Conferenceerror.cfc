<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset table("equip_errors")>
	</cffunction>

	<cffunction name="post">
	<cfset var loc=structNew()>	
		<cfset loc.errorpost = model("Error").new()>
		<cfset loc.errorpost.session = serializeJSON(session)>
		<cfset loc.errorpost.cgi = serializeJSON(cgi)>
		<cfset loc.errorpost.form = serializeJSON(form)>
		<cfset loc.errorpost.url = serializeJSON(url)>
		<cfset loc.errorpost.request = serializeJSON(request)>
		<cfset loc.errorpost.cookie = serializeJSON(cookie)>
		<cftry>
			<cfset loc.errorpost.error = serializeJSON(error)>
			<cfcatch></cfcatch>
		</cftry>
		<cfset check = loc.errorpost.save()>
		<cfreturn check>
	</cffunction>
	
</cfcomponent>
