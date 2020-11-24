<cfcomponent extends="Model" output="false">

	<cfset dsn = "fgbc_main_3">

	<cffunction name="config">
		<cfset table("equip_backups")>
	</cffunction>

	<cffunction name="getTables">
		<cfquery datasource="#dsn#" name="alltables">
			SHOW tables
			WHERE tables_in_fgbc_main_3 like "equip%"
		</cfquery>
		<cfreturn alltables>
	</cffunction>

	<cffunction name="backupTable">
	<cfargument name="tablename" required="true" type="string">
	<cfset var loc=structNew()>
		<cfset loc.newtable = "zbackup_#arguments.tablename#">
		<cftry>
				<cfquery datasource="fgbc_main_3">
					DROP TABLE #loc.newtable#
				</cfquery>
		<cfcatch></cfcatch>
		</cftry>
		<cfquery datasource="fgbc_main_3">
			CREATE TABLE #loc.newtable# LIKE #arguments.tablename#
		</cfquery>
		<cfquery datasource="fgbc_main_3">
			INSERT INTO #loc.newtable# SELECT * FROM #arguments.tablename#
		</cfquery>
		<cfquery datasource="fgbc_main_3" name="newtabledata">
			SELECT * from #loc.newtable#
			WHERE deletedAt IS NULL
		</cfquery>

		<cfset params.records = newtabledata.recordcount>
		<cfset params.name = arguments.tablename>
		<cfset loc.results = Model("Conferencebackup").create(params)>

	<cfreturn loc.results>
	</cffunction>

</cfcomponent>
