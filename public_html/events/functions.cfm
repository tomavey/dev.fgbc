<!--- Place functions here that should be globally available in your application. --->


<cfscript>

<!--------------------------->
<!-----SETTINGS GETTERS------>
<!--------------------------->

public function getSetting(name, useSessionSetting=true){
		var value = ""
		try {
				var setting = model("Fgbcsetting").findOne(where="name='#name#'").value
			} catch(any e){}	
		if (isDefined("params[name]")){
			value = params[name]
		} elseif (isDefined("session.settings[name]") && useSessionSetting){	
			value = session.settings[name]	
		} elseif (isDefined("setting")){
			value = setting	
		} elseif (isDefined("application.wheels[name]")){
			value = application.wheels[name]
		} else (value = false)
		
		return value
	}

	public function setSetting(name, value, category="TBD", description="TBD") {
		var setting = model("Fgbcsetting").findOne(where="name = '#name#'")
		if ( isObject(setting) ) {
			setting.value = value
			if (setting.update()) {
				flashInsert(success="#name# was updated to #value#.")
			} else {
				flashInsert(success="#name# was NOT updated to #value#.")
			}
			return "true"
		} else {
			setting = model("Fgbcsetting").new(arguments)
			if(setting.save()) {
				flashInsert(success="#name# was saved as #value#.")
			} else {
				flashInsert(success="#name# was NOT saved as #value#.")
			}
			return "true"
		}
		return "false"
	}

	function getDataSource() {
		return application.wheels.dataSourceName
	}
	
	function getMinistryStaffAdmin() {
		return application.wheels.ministryStaffAdmin
	}
	
	function getNonStaffSortOrder() {
		return getSetting("nonStaffSortOrder")
	}
	
	function isLocalMachine() {
		if ( cgi.http_host contains ":8080" || cgi.http_host contains ":8888" || cgi.http_host contains "127.0.0.1" ) {
			return true
		} else {
			return false
		}
	}

	function isAGBM(personid) {
		var loc=structNew()
		loc.return = false
		loc.check = model("Handbookagbminfo").findOne(where="personid = #arguments.personid#")
		if ( isObject(loc.check) ) {
			loc.return = true
		}
		return loc.return
	}

	function isAgbmMember(required numeric personid) {
		return model("Handbookagbminfo").isAgbmMember(arguments.personid)
	}
	
	function isFormerAGBMMember(required numeric personid) {
		if ( isAGBM(personid) && !isAgbmMember(personid) ) {
			return true
		} else {
			return false
		}
	}
<!---------------------------------->
<!-----END OF SETTINGS GETTERS------>
<!---------------------------------->





<!----------------->	
<!---CONVERSIONS--->	
<!----------------->	

function commaListToQuoteList (list) {
		var newList = "";
		newlist = listMap(list, function (e) {
				return '"'&e&'"';
		})
		return newList;
}

function commaListToSingleQuoteList (list) {
	var newList = '';
	newlist = listMap(list, function (e) {
			return "'"&e&"'";
	})
	return newList;
}

function queryToArray(required query data){
			var LOCAL = StructNew()
			LOCAL.Columns = ListToArray( ARGUMENTS.Data.ColumnList )
			LOCAL.QueryArray = ArrayNew( 1 )
			for (LOCAL.RowIndex = 1 ; LOCAL.RowIndex LTE ARGUMENTS.Data.RecordCount ; LOCAL.RowIndex = (LOCAL.RowIndex + 1)){
				LOCAL.Row = StructNew()
				for (LOCAL.ColumnIndex = 1 ; LOCAL.ColumnIndex LTE ArrayLen( LOCAL.Columns ) ; LOCAL.ColumnIndex = (LOCAL.ColumnIndex + 1)){
					LOCAL.ColumnName = LOCAL.Columns[ LOCAL.ColumnIndex ]
					LOCAL.Row[ LOCAL.ColumnName ] = ARGUMENTS.Data[ LOCAL.ColumnName ][ LOCAL.RowIndex ]
				}
				ArrayAppend( LOCAL.QueryArray, LOCAL.Row )
			}
			return( LOCAL.QueryArray )
}

	function queryToJson(required query data, useSerializeJSON = true){
		if ( useSerializeJSON ) {
			return serializeJSON(capitalizeColumnNameInQuery(arguments.data),"struct")
		}	else {
			return queryToJsonNoSerial(arguments.data)
		}
	}

	function capitalizeColumnNameInQuery(qry){
		return qry
	}

	function structToJson(required struct Data) {
		var loc = structNew()
		loc.columnnames = StructKeyList(data)
		loc.jsonObject = "["
		loc.thisitem = "{"
		for ( loc.i in loc.columnNames ) {
			loc.thisdata = '"#$escapeString(data[loc.i])#"'
			loc.thisitem = loc.thisitem & '"' & lcase(loc.i) & '"' & ":" & loc.thisdata & ","
		}
		loc.thisitem = left(loc.thisitem,len(loc.thisitem)-1) & "},"
		loc.jsonObject = loc.jsonObject & loc.thisitem
		loc.jsonObject = left(loc.jsonObject,Len(loc.jsonObject)-1)
		loc.jsonObject = loc.jsonObject & "]"
		return loc.jsonObject
	}

	function jsonThisString(required string string) {
		loc.newJson = ""
		if ( find("convertToJson-",arguments.string) ) {
			arguments.string = replace(arguments.string,"convertToJson-","","all")
			arguments.string = replace(arguments.string,'&quot','"','all')
			arguments.string = right(arguments.string,len(arguments.string)-1)
			arguments.string = left(arguments.string,len(arguments.string)-1)
			arguments.string = '[' & arguments.string & ']'
		}
		return arguments.string
	}

	function $escapeString(required string) {
		var loc = structNew()
		loc.return =  arguments.string
		loc.return = replace(loc.return,"&quot", "'", "ALL")
		loc.return = REReplace(loc.return,chr(34),"'","ALL")
		loc.return = REReplace(loc.return, "\r\n|\n\r|\n|\r", "", "all")
		loc.return = REReplace(loc.return, "\t", "", "all")
		return loc.return
	}

	function jsonToStruct(required jsonString) {
		var loc=structNew()
		loc = arguments
		//      <cfset loc.return = structNew()> 
		loc.return2 = DeserializeJSON(loc.jsonString)
		loc.jsonString = replace(jsonString,'", "','"%%"','all')
		loc.jsonString = replace(jsonString,'","','"%%"','all')
		loc.jsonString = replace(jsonString,'": "','"&&"','all')
		loc.jsonString = replace(jsonString,'":"','"&&"','all')
		loc.jsonString = replace(jsonString,"}","","all")
		loc.jsonString = replace(jsonString,"{","","all")
		loc.jsonString = replace(jsonString,"}","","all")
		loc.jsonString = replace(jsonString,"Date ","","all")
		loc.jsonString = trim(loc.jsonString)
		for ( loc.i in listToArray( "", "%%" ) ) {
			loc.count = 1
			for ( loc.ii in listToArray( "", "&&" ) ) {
				loc.ii = $escapeString(removeChars(trim(loc.ii),1,1))
				loc.ii = $escapeString(removeChars(trim(loc.ii),len(loc.ii),1))
				if ( loc.count == 1 ) {
					loc.keyy = loc.ii
				} else if ( loc.count == 2 ) {
					loc.value = loc.ii
					break
				}
				loc.count = loc.count + 1
			}
			loc.return[loc.keyy] = loc.value
		}
		// <cfdump var="#loc.return#"><cfabort>
		return loc.return2
	}

	function listToQuery(required string list, required string columnName) {
		var loc = structNew()
		loc = arguments
		loc.query = QueryNew(loc.columnName)
		for ( i in loc.list ) {
			queryAddRow(loc.query)
			querySetCell(loc.query,loc.columnName,i)
		}
		return loc.query
	}

	public function stringToArray(required string oldString){
					var stringToList = replace(oldString," ",",","all")
					return listToArray(stringToList)
				}

	function distinctsFromQuery(query oldquery) {
		cfquery( dbType="query", name="newquery" ) {

			writeOutput("SELECT DISTINCT *
					FROM oldquery")
		}
		return newquery
	}

	function combineTwoQueries(required query query1, required query query2) {
		cfquery( dbtype="query", name="data" ) {

			writeOutput("SELECT *
				FROM arguments.query1
				UNION
				SELECT *
				FROM arguments.query2")
		}
		return data
	}

	function getDistinctColumnValuesFromQuery(required oldquery, required column) {
		cfquery( dbtype="query", name="newQuery" ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically
	
			writeOutput("SELECT DISTINCT #column#
			FROM oldquery");
		}
		return newQuery;
	}

	public function removeDuplicatesFromList(list,delimiter,case=true){
		var i = 0;
		var listitem = "";
		var newlist = "";

		if(!isDefined("delimiter")){delimiter=","};
		for (i=1; i LTE listLen(list,delimiter); i=i+1){
			listItem = listGetAt(list,i,delimiter);
			if (case is true){
			if (!listFind(newlist,listitem,delimiter)){
				newlist = newlist & delimiter & listitem;
				}
			}
			else {
			if (!listFindNoCase(newlist,listitem,delimiter)){
				newlist = newlist & delimiter & listitem;
				}
			}	
		};
		return replace(newlist,',','','one');
	}

	
<!-------------------------->	
<!---END OF CONVERSIONS----->	
<!-------------------------->	

	function h(required string text) {

		writeOutput("<return xmlFormat(text)>")
	}

	function dd(message) {
		throw(serialize(message))
	}

	function ddd(object) {
		writeDump(var="#object#", format="js");abort;
	}

</cfscript>
	
		

<cffunction name="queryToJsonNoSerial">
	<cfargument name="Data" type="query" required="yes" />
	<cfset var loc = structNew()>
	<cfset loc.columnnames = data.columnList>
	<cfset loc.jsonObject = "[">
		<cftry>
		<cfoutput query="data">
			<cfset loc.thisitem = "{">
			<cfloop list="#loc.columnNames#" index="loc.i">
				<cfset loc.thisdata = '"#$escapeString(data[loc.i])#"'>
				<cfset loc.thisitem = loc.thisitem & '"' & lcase(loc.i) & '"' & ":" & loc.thisdata & ",">
			</cfloop>
			<cfset loc.thisitem = left(loc.thisitem,len(loc.thisitem)-1) & "},">
			<cfset loc.jsonObject = loc.jsonObject & loc.thisitem>
		</cfoutput>
		<cfset loc.jsonObject = left(loc.jsonObject,Len(loc.jsonObject)-1)>
		<cfcatch></cfcatch></cftry>
	<cfset loc.jsonObject = loc.jsonObject & "]">
	<cfreturn loc.jsonObject>
</cffunction>

