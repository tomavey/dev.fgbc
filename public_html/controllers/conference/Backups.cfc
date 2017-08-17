<cfcomponent extends="Controller" output="false">

	<cfset dsn = "fgbc_main_3">

	<cffunction name="init">
		<cfset usesLayout("/conference/adminlayout")>
		<cfset filters(through="officeOnly", except="backupall")>
	</cffunction>
	
	<cffunction name="list">
		<cfset alltables = Model("Conferencebackup").getTables()>
	</cffunction>
	
	<cffunction name="xbackup">
	<cfset var results = structNew()>
		<cfset results = backupTable(params.key)>
		<cfif isdefined("results.message")>
		<cfdump var="#results#"><cfabort>
		<cfelse>
		<cfset redirectTo(controller="conference.backups", action="list")>
		</cfif>
	</cffunction>
	
	<cffunction name="backupall">
		<cfset alltables = model("Conferencebackup").getTables()>
		<cfloop query="alltables">
			<cfset loc.newtable = model("Conferencebackup").backupTable(tables_in_fgbc_main_3)>
		</cfloop>
		<cfset redirectTo(controller="conference.backups", action="list")>
	</cffunction>
	
	<cffunction name="backup">
	<cfargument name="tablename" required="false" type="string">
	<cfset var loc = structNew()>
	<cfif isDefined("arguments.tablename")>
		<cfset loc.table = arguments.tablename>
	<cfelse>
		<cfset loc.table = params.key>
	</cfif>
	<cfset loc.newtable = model("Conferencebackup").backupTable(loc.table)>

	<cfset redirectTo(controller="conference.backups", action="list")>

	</cffunction>
	
	<cffunction name="getLastBackup">
	<cfargument name="table" required="true">
	<cftry>
	<cfset lastBackup = model("Conferencebackup").findAll(where="name='#arguments.table#'", order="ID DESC")>
	<cfcatch>
		<cfset lastBackup.records="NA">	
		<cfset lastBackup.createdAt="NA">	
	</cfcatch>
	</cftry>
	<cfreturn lastBackup>	
	</cffunction>
	
	<cffunction name="dump">
		<!---Get Column Info from Selected Table--->
			<cfquery datasource="#dsn#" name="columns">
				SHOW columns
				FROM #params.key#
			</cfquery>
			<cfquery datasource="#dsn#" name="data">
				SELECT *
				FROM #params.key#	
			</cfquery>
	</cffunction>

	<cffunction name="testGetLastBackup">
	<cfset test = getLastBackup("equip_prayer_triplets")>
	<cfdump var="#test#"><cfabort>
	</cffunction>
	
	<cffunction name="fieldSQL">
	<cfargument name="fieldName" required="true" type="string">
	<cfargument name="fieldData" required="true">
	<cfset var sqltxt = "">	
	<cfset var data = "">	
	<cfset var columns = "">	
	<cfset var columnInfo = "">	
	
			<cfquery datasource="#dsn#" name="columns">
				SHOW columns
				FROM #params.key#
			</cfquery>
			<cfquery dbtype="query" name="columninfo">
				SELECT * FROM columns
				WHERE upper(field) = '#ucase(arguments.fieldname)#'
			</cfquery>	

			<cfif columnInfo.type contains "int">
				<cfset sqltxt = arguments.fieldData & ", ">
			<cfelseif columnInfo.type contains "decimal">
				<cfset sqltxt = arguments.fieldData & ", ">
			<cfelseif columnInfo.type contains "text">
				<cfset sqltxt = "'" & arguments.fieldData & "'', ">
			<cfelseif columnInfo.type contains "char">
				<cfset sqltxt = "'" & arguments.fieldData & "'', ">
			</cfif>	
		<cfreturn sqltxt>	
	</cffunction>

</cfcomponent>
