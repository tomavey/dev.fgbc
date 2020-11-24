<cfcomponent extends="Model" output="false">
	
	<cffunction name="config">
		<cfset table(name="fgbc_announcements", modelName="Mainannouncement")>
		<!---not working
		<cfset uploadableFile(property="image", destination="#expandpath('.')#/images/announcements/", nameConflict="MakeUnique")>
		<cfset uploadableFile(property="image", nameConflict="overwrite")>
		--->
		<cfset beforeSave('')>
	</cffunction>

	<cffunction name="dumpthis">
		<cfdump var="#mainannouncement.properties()#"><cfabort>
	</cffunction>

</cfcomponent>