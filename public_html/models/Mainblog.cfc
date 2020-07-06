<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("fgbc_blogs")>
	</cffunction>
	
	<cffunction name="getFieldsData">
	<cfset var fieldsdata= structNew()>	
		<cfquery datasource="fgbc_main_3" name="fieldsdata">
			SHOW columns
			FROM fgbc_blogs
		</cfquery>
		<cfreturn fieldsdata>
	</cffunction>

	<cffunction name="unDeleteAll">
		<cfquery datasource="fgbc_main_3">
			UPDATE fgbc_blogs
			SET deletedAt = NULL
		</cfquery>	
	</cffunction>

</cfcomponent>
