<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("fgbcmembershipappresources")>
		<cfset uploadableFile(property="file")>
	</cffunction>

</cfcomponent>
