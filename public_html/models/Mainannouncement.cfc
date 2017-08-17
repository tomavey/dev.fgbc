<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
		<cfset table("fgbc_announcements")>
		<!---cfset uploadableFile(property="image", destination="#expandpath('.')#/images/announcements/", nameConflict="overwrite")--->
	</cffunction>

</cfcomponent>