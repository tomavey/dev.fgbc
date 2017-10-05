<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
		<cfset table("fgbc_announcements")>
		<!---not working
		<cfset uploadableFile(property="image", nameConflict="overwrite")>
		--->
	</cffunction>

</cfcomponent>