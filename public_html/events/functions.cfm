<!--- Place functions here that should be globally available in your application. --->

	<cffunction name="getNonStaffSortOrder">
	<cfset var loc=structnew()>
	<cfset loc.nonStaffSortOrder = application.wheels.nonStaffSortOrder>
	<cfreturn loc.nonStaffSortOrder>
	</cffunction>

	<cffunction name="isLocalMachine">
		<cfif cgi.http_host is "localhost:8080" OR cgi.http_host is "localhost:8888">
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="QueryToArray" access="public" returntype="array" output="true"
	hint="This turns a query into an array of structures.">

	<!--- Define arguments. --->
	<cfargument name="Data" type="query" required="yes" />

		<cfscript>
			// Define the local scope.
			var LOCAL = StructNew();
			// Get the column names as an array.
			LOCAL.Columns = ListToArray( ARGUMENTS.Data.ColumnList );
			// Create an array that will hold the query equivalent.
			LOCAL.QueryArray = ArrayNew( 1 );
			// Loop over the query.
			for (LOCAL.RowIndex = 1 ; LOCAL.RowIndex LTE ARGUMENTS.Data.RecordCount ; LOCAL.RowIndex = (LOCAL.RowIndex + 1)){
			// Create a row structure.
			LOCAL.Row = StructNew();
			// Loop over the columns in this row.
			for (LOCAL.ColumnIndex = 1 ; LOCAL.ColumnIndex LTE ArrayLen( LOCAL.Columns ) ; LOCAL.ColumnIndex = (LOCAL.ColumnIndex + 1)){
			// Get a reference to the query column.
			LOCAL.ColumnName = LOCAL.Columns[ LOCAL.ColumnIndex ];
			// Store the query cell value into the struct by key.
			LOCAL.Row[ LOCAL.ColumnName ] = ARGUMENTS.Data[ LOCAL.ColumnName ][ LOCAL.RowIndex ];
			}
			// Add the structure to the query array.
			ArrayAppend( LOCAL.QueryArray, LOCAL.Row );
			}
			// Return the array equivalent.
			return( LOCAL.QueryArray );
		</cfscript>
	</cffunction>

	<cffunction name="queryToJson">
	<cfargument name="Data" type="query" required="yes" />
	<cfset var loc = structNew()>
	<cfset loc.columnnames = data.columnList>
	<cfset loc.jsonObject = "[">
		<cftry>
		<cfoutput query="data">
			<cfset loc.thisitem = "{">
			<cfloop list="#loc.columnNames#" index="loc.i">
				<cfset loc.thisdata = '"#escapeString(data[loc.i])#"'>
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

	<cffunction name="structToJson">
	<cfargument name="Data" type="struct" required="yes" />
	<cfset var loc = structNew()>
	<cfset loc.columnnames = StructKeyList(data)>
	<cfset loc.jsonObject = "[">
			<cfset loc.thisitem = "{">
			<cfloop list="#loc.columnNames#" index="loc.i">
				<cfset loc.thisdata = '"#escapeString(data[loc.i])#"'>
				<cfset loc.thisitem = loc.thisitem & '"' & lcase(loc.i) & '"' & ":" & loc.thisdata & ",">
			</cfloop>
			<cfset loc.thisitem = left(loc.thisitem,len(loc.thisitem)-1) & "},">
			<cfset loc.jsonObject = loc.jsonObject & loc.thisitem>
		<cfset loc.jsonObject = left(loc.jsonObject,Len(loc.jsonObject)-1)>
		<cfset loc.jsonObject = loc.jsonObject & "]">
		<cfreturn loc.jsonObject>
	</cffunction>

	<cffunction name="jsonThisString">
	<cfargument name="string" required="true" type="string">
	<cfset loc.newJson = "">
	<cfif find("convertToJson-",arguments.string)>
		<cfset arguments.string = replace(arguments.string,"convertToJson-","","all")>
		<cfset arguments.string = replace(arguments.string,'&quot;','"','all')>
		<cfset arguments.string = right(arguments.string,len(arguments.string)-1)>
		<cfset arguments.string = left(arguments.string,len(arguments.string)-1)>
		<cfset arguments.string = '[' & arguments.string & ']'>
	</cfif>
	<cfreturn arguments.string>
	</cffunction>

    <cffunction name="escapeString">
    <cfargument name="string" required="true">
    <cfset var loc = structNew()>
        <cfset loc.return =  arguments.string>
        <cfset loc.return = replace(loc.return,"&quot;", "'", "ALL")>
        <cfset loc.return = REReplace(loc.return,chr(34),"'","ALL")>
        <cfset loc.return = REReplace(loc.return, "\r\n|\n\r|\n|\r", "", "all")>
        <cfset loc.return = REReplace(loc.return, "\t", "", "all")>
        <cfreturn loc.return>
    </cffunction>

    <cffunction name="getDataSource">
    	<cfreturn application.wheels.dataSourceName>
    </cffunction>

	<cffunction name="getMinistryStaffAdmin">
		<cfreturn application.wheels.canSetMinistryStaff>
	</cffunction>

    <cffunction name="jsonToStruct">
    <cfargument name="jsonString" required="true">
    <cfset var loc=structNew()>
    <cfset loc = arguments>
    <cfset loc.return = structNew()>
<!---<cfdump var="#loc.jsonString#">--->
        <cfset loc.return2 = DeserializeJSON(loc.jsonString)>
        <cfset loc.jsonString = replace(jsonString,'", "','"%%"','all')>
        <cfset loc.jsonString = replace(jsonString,'","','"%%"','all')>
        <cfset loc.jsonString = replace(jsonString,'": "','"&&"','all')>
        <cfset loc.jsonString = replace(jsonString,'":"','"&&"','all')>
        <cfset loc.jsonString = replace(jsonString,"}","","all")>
        <cfset loc.jsonString = replace(jsonString,"{","","all")>
        <cfset loc.jsonString = replace(jsonString,"}","","all")>
        <cfset loc.jsonString = replace(jsonString,"Date ","","all")>
        <cfset loc.jsonString = trim(loc.jsonString)>
        <cfloop list = '#jsonString#' delimiters="%%" index="loc.i">
            <cfset loc.count = 1>
            <cfloop list = '#loc.i#' delimiters="&&" index= "loc.ii">
                <cfset loc.ii = escapeString(removeChars(trim(loc.ii),1,1))>
                <cfset loc.ii = escapeString(removeChars(trim(loc.ii),len(loc.ii),1))>
                <cfif loc.count is 1>
                    <cfset loc.keyy = loc.ii>
                <cfelseif loc.count is 2>
                    <cfset loc.value = loc.ii>
                    <cfbreak>
                </cfif>
                <cfset loc.count = loc.count + 1>
            </cfloop>
                <cfset loc.return[loc.keyy] = loc.value>
       </cfloop>
<!---<cfdump var="#loc.return#"><cfabort>--->
       <cfreturn loc.return>
    </cffunction>

    <cffunction name="listToQuery">
    <cfargument name="list" required="true" type="string">
    <cfargument name="columnName" required="true" type="string">
        <cfset var loc = structNew()>
        <cfset loc = arguments>
        <cfset loc.query = QueryNew(loc.columnName)>
            <cfloop list='#loc.list#' index="i">
                <cfset queryAddRow(loc.query)>
                <cfset querySetCell(loc.query,loc.columnName,i)>
            </cfloop>

    <cfreturn loc.query>
    </cffunction>

    <cffunction name="distinctsFromQuery">
        <cfargument name="oldquery" type="query">
        <cfquery dbType="query" name="newquery">
            SELECT DISTINCT *
            FROM oldquery
        </cfquery>
        <cfreturn newquery>
    </cffunction>

	<cffunction name="h">
	<cfargument name="text" required="true" type="string">
	<return xmlFormat(text)>
	</cffunction>


<cfscript>
	public function getSetting(name){
		var value = "";
		var setting = model("Fgbcsetting").findOne(where="name='#name#'").value;
		if (isDefined("params[name]")){
			value = params[name];
		} elseif (isDefined("session.settings[name]")){	
			value = session.settings[name];	
		} elseif (isDefined("setting")){
			value = setting;	
		} elseif (isDefined("application.wheels[name]")){
			value = application.wheels[name];
		};
		return value;
	}
</cfscript>
