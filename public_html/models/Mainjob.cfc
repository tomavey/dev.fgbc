<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("fgbc_jobs")>
		<cfset validatesFormatOf(property="email", type="email")>
		<cfset validatesFormatOf(property="contactemail", type="email", message="Contact Email is invalid")>
	</cffunction>

</cfcomponent>
