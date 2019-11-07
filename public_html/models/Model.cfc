<!---
	This is the parent model file that all your models should extend.
	You can add functions to this file to make them globally available in all your models.
	Do not delete this file.
--->
<cfcomponent extends="Wheels">

	<cffunction name="superLogUpdates">
	<cfargument name="modelName" required="true" type="string">
	<cfargument name="createdBy" default="#session.auth.email#">

		<cfset old = model("#arguments.modelName#").findByKey(this.id)>
		<cfset new = this>
		<cfset changes= new.changedProperties()>
		<cfoutput>
		<cfloop list="#changes#" index="i">
			<cfif not i is "updatedAt">
				<cfset newupdate.modelName = arguments.modelName>
				<cfset newupdate.recordId = this.id>
				<cfset newupdate.columnName = i>
				<cfset newupdate.datatype = "update">
				<cfset newupdate.olddata = old[i]>
				<cfset newupdate.newData = new[i]>
				<cfset newupdate.createdBy = "#arguments.createdBy#">
				<cfset update = model("Handbookupdate").create(newupdate)>
			</cfif>
		</cfloop>
		</cfoutput>
	</cffunction>

	<cffunction name="superLogCreates">
	<cfargument name="modelName" required="true" type="string">
	<cfargument name="olddata" default="#this.id#">
	<cfargument name="createdBy" default="#session.auth.email#">

		<cfset newSave.modelName = arguments.modelName>
		<cfset newSave.recordId = this.id>
		<cfset newSave.datatype = "new">
		<cfset newSave.olddata = arguments.olddata>
		<cfset newSave.createdBy = "#arguments.createdBy#">
		<cfset update = model("Handbookupdate").create(newSave)>

	</cffunction>

	<cffunction name="superLogDeletes">
	<cfargument name="modelName" required="true" type="string">
	<cfargument name="olddata" default="NA">
	<cfargument name="createdBy" default="#session.auth.email#">

		<cfset newSave.modelName = arguments.modelName>
		<cfset newSave.recordId = this.id>
		<cfset newSave.datatype = "deleted">
		<cfset newSave.olddata = arguments.olddata>
		<cfset newSave.createdBy = arguments.createdBy>
		<cfset update = model("Handbookupdate").create(newSave)>

	</cffunction>

	<cffunction name="htmlEdit">
	<cfset var loc=StructNew()>
		<cfloop list="#this.propertyNames()#" index="loc.i">
			<cfif isValid("string", loc.i)>
				<cftry>
				<cfset this[loc.i] = trim(htmlEditFormat(this[loc.i]))>
				<cfcatch></cfcatch></cftry>
			</cfif>
		</cfloop>
	</cffunction>

<cfscript>
	function buildNewQuery( required query newQuery, required struct rowToAdd ) {
		queryAddRow(newQuery)
		for ( var item in rowToAdd ) {
			querySetCell( newQuery,item,newUser[item] )
		}
		return newQuery
	}
</cfscript>	

	<cffunction name="XbuildNewQuery">
	<cfargument name="oldquery" required="true" type="query">
	<cfargument name="rowToAdd" required="true" type="structure">
		<cfset var loc = structNew()>
		<cfset loc = arguments>

			<cfset queryAddRow(loc.newquery)>

			<cfloop list='#loc.oldquery.columnlist#' index="i">
				<cfset querySetCell(loc.newquery,i,'#evaluate(i)#')>
			</cfloop>

		<cfreturn loc.newquery>

	</cffunction>

	<cffunction name="QueryAppend" access="public" returntype="query" output="false"
	hint="This takes two queries and appends the second one to the first one. Returns the resultant third query.">

	<cfargument name="QueryOne" type="query" required="true" />
	<cfargument name="QueryTwo" type="query" required="true" />
	<cfargument name="UnionAll" type="boolean" required="false" default="true" />

	<cfset var loc = StructNew() />
	<cfset loc = arguments>

		<cfquery name="loc.NewQuery" dbtype="query">
		SELECT *
		FROM loc.QueryOne
		UNION
		<cfif loc.UnionAll>
			ALL
		</cfif>
		SELECT *
		FROM loc.QueryTwo
		</cfquery>

	<cfreturn loc.NewQuery />
	</cffunction>

	<cffunction name="groupQuery">
	<cfargument name="oldQuery" required="true" type="query">
	<cfargument name="groupColumn" required="true" type="string">
	<cfset var loc = structnew()>
	<cfset loc = arguments>
	<cfset loc.selectfields = loc.oldquery.columnlist>
	<cfset loc.newquery = querynew('#loc.oldquery.columnlist#')>

	<cfquery dbType="query" name="loc.oldQuerySorted">
		SELECT *
		FROM loc.oldQuery
		ORDER BY '#loc.groupcolumn#'
	</cfquery>

	<cfoutput query=loc.oldQuerySorted group="#loc.groupcolumn#">
		<cfset buildNewQuery(loc.oldquery,loc.newQuery)>
	</cfoutput>

	<cfreturn loc.newquery>

	</cffunction>

	<cffunction name="orderQuery">
	<cfargument name="oldQuery" required="true" type="query">
	<cfargument name="orderby" required="true" type="string">
	<cfset var loc=structNew()>
	<cfset loc = arguments>
		<cfquery dbtype="query" name="loc.newQuery">
			SELECT *
			FROM loc.oldquery
			ORDER BY #loc.orderBy#
		</cfquery>
	<cfreturn loc.newquery>
	</cffunction>

	<cffunction name="getEvent">
        <cfreturn getSetting("event")>
	</cffunction>

<cfscript>

	public function getDataSourceName(){
		return application.wheels.datasourcename;
	}

	private function getTypeOfRegOptions(){
		return application.wheels.typeOfRegOptions;
	}

</cfscript>	


</cfcomponent>