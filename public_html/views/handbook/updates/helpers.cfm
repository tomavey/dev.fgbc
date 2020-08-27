<cffunction name="nameColumn">
<cfargument name="ColumnName" required="true" type="string">
<cfset var nameColumn = structnew()>

	<cfset nameColumn.lname = "Last Name">
	<cfset nameColumn.fname = "First Name">
             <cfset nameColumn.statusid = "Status">
             <cfset nameColumn.stateid = "State">
             <cfset nameColumn.org_city = "City">
             <cfset nameColumn.organizationid = "Organization">
             <cfset nameColumn.p_sortorder = "Staff Order">
             <cfset nameColumn.phone = "Home Phone">
             <cfset nameColumn.phone2 = "Cell Phone">
             <cfset nameColumn.phone3 = "Work Phone">

	<cfif structKeyExists(nameColumn,arguments.columnname)>
		<cfreturn nameColumn[arguments.columnname]>
	<cfelse>
		<cfreturn arguments.columnname>
	</cfif>

</cffunction>