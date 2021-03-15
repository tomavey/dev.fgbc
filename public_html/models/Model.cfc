<!---
	This is the parent model file that all your models should extend.
	You can add functions to this file to make them globally available in all your models.
	Do not delete this file.
--->
<cfcomponent extends="wheels.Model">


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

<cfscript>

	function getEvent(params){
		if ( isDefined("params.event" )) { return params.event }
		return getSetting("event")
	}

	public function getDataSourceName(){
		return getDatasource()
	}

	private function getTypeOfRegOptions(){
		return getSetting("typeOfRegOptions")
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

	//Used by agbm/inspire  - currentMembershipYear is calculated using a member year start set in settings
	function currentMembershipYear(struct params) {
		var loc = structNew()
		loc.return = year(now())
		loc.agbmDeadlineDate = getSetting("agbmDeadlineDate")
		loc.todayString = now()
		loc.testing = false
		//for testing
		if ( isDefined("params.agbmDeadlineDate") ) { loc.agbmDeadlineDate = params.agbmDeadlineDate }
		if ( isDefined("params.testing") ) { loc.testing = true }
		//use params first
		if ( isDefined("params.currentMembershipyear") ) {
			loc.return = params.currentMembershipYear
		} 
		//then check session.agbm
		else if ( isDefined("session.agbm.currentmembershipyear") && !loc.testing ) {
			loc.return = session.agbm.currentmembershipyear
		} 
		//then use setting for agbmDeadlineDate
		else {
			loc.return = getAgbmDeadlineYearFromSetting()
		}
		
		return loc.return
	}	

	//This created a deadline date from the agbmDeadlineDate setting for the current date context
	function getAgbmDeadlineYearFromSetting(){
		var loc = {}
		loc.today = now()
		loc.deadline = getSetting("agbmDeadlineDate")
		loc.todayObj = {
			year: year(loc.today),
			dayOfYear: dayOfYear(loc.today)
		}
		loc.deadLineObj.dayOfYear = dayOfYear(loc.deadline)
		//if todays dayOfYear is less than or equaly to the deadline, return current year - 1
		if ( loc.todayObj.dayOfYear <= loc.deadLineObj.dayOfYear ) {
			return loc.todayObj.year - 1
		} else {
			return loc.todayObj.year
		}
	}

</cfscript>	


</cfcomponent>