<cfdump var="#data#" format="text">
<cfabort>
<cfparam name="columnNames" default="">

<cfoutput>
	INSERT INTO #params.key#
<cfloop list="#data.columnlist#" index="i">
	<cfset columnNames = "; '" & i & "' " & columnNames>
</cfloop>
	<cfset columnNames = replace(columnNames,";","","one")>
	(#columnNames#)
<cfloop query="data">	
	<cfloop list="#data.columnlist#" index="i">
		#fieldSQL(i,evaluate(i))#,
	</cfloop>	
</cfloop>
	
</cfoutput>
