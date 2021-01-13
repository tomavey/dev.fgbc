//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset table("fgbc_jobs")>
		<cfset validatesFormatOf(property="email", type="email", message="Show Email is invalid")>
		<cfset validatesFormatOf(property="contactemail", type="email", message="Contact Email is invalid")>
	</cffunction>

</cfcomponent>
