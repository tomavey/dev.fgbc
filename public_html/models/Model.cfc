<!---
	This is the parent model file that all your models should extend.
	You can add functions to this file to make them globally available in all your models.
	Do not delete this file.
--->
<cfcomponent extends="Wheels">


<cfscript>

	function superLogUpdates(required string modelName, createdBy=session.auth.email) {
		var old = model(arguments.modelName).findByKey(key=this.id, include="Handbookstate")
		var new = this
		var changes = new.changedProperties()
		for ( i in changes ) {
			if ( !i == "updatedAt" && !i == "sendhandbook" && !i == "private" ) {
				var newupdate = {
					modelName: arguments.modelName,
					recordId: this.id,
					columnName: i,
					datatype: "update",
					olddata: old[i],
					newData: new[i],
					createdBy: arguments.createdBy
				}
				model("Handbookupdate").create(newupdate)
			}
		}
		return true
	}

	function superLogCreates(required string modelName, createdBy=session.auth.email) {
		var newSave = {
			modelName: arguments.modelName,
			recordId: this.id,
			datatype: "new",
			createdBy = arguments.createdBy,
		}
		model("Handbookupdate").create(newSave);
	}
	
	function superLogDeletes(required string modelName, createdBy=session.auth.email) {
		var newSave = {
			modelName: arguments.modelName,
			recordId: this.id,
			datatype: "deleted",
			createdBy: arguments.createdBy
		}
		model("Handbookupdate").create(newSave);
	}
	

</cfscript>	


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

	private function $buildMysqlLikeString(likeList){
		var i = ''
		var likeList = listToArray(likeList)
		var titleIncludes = ''
		for (like in likeList) {
			titleIncludes = titleIncludes & " OR position LIKE '%#like#%'"
		}
		return replace(titleIncludes,"OR ","","one")
	}
	
	function $removeDuplicates(required array handbookReviewStruct) {
		var loc = arguments
		loc.newArray = []
		for ( loc.i=1;  loc.i<=arraylen(loc.handbookReviewStruct); loc.i++ ) {
			if ( !arrayFind(loc.newArray,loc.handbookReviewStruct[loc.i]) ) {
				arrayAppend(loc.newArray,loc.handbookReviewStruct[loc.i])
			}
		}
		return loc.newarray
	}

	function currentMembershipYear(struct params) {
		var loc = structNew()
		loc.return = year(now())
		if ( isDefined("params.currentMembershipyear") ) {
			loc.return = params.currentMembershipYear
		} else if ( isDefined("session.agbm.currentmembershipyear") ) {
			loc.return = session.agbm.currentmembershipyear
		} else {
			if ( dateCompare(createODBCDate(now()),createODBCDate(getSetting("agbmDeadlineDate"))) == -1 ) {
				loc.return = loc.return-1
			}
		}
		return loc.return
	}	
</cfscript>	


</cfcomponent>