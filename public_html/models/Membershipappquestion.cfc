<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("fgbcmembershipappquestions")>
		<cfset property(name="language", default="English")>
	</cffunction>

</cfcomponent>
