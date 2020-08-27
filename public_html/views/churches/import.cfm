<cfquery name="getImportedAddresses" datasource="fgbc_main_3">
	
	SELECT * FROM lnglat

</cfquery>

<cfloop query="getImportedAddresses">
	
	<cfset addressLen = ListLen(FIELD1)>
	<cfif addresslen neq 0 and addresslen neq 1>
		<cfset longitude = listLast(FIELD1)>
		<cfset latitude = listGetAt(FIELD1, addressLen - 1)>

		<cfif longitude neq "">
			<cfquery name="insertLngLat" datasource="fgbc_main_3">
				UPDATE handbookorganizations set longitude = #longitude#, latitude = #latitude# where address1 like '%#listFirst(FIELD1)#%'
			</cfquery>
		</cfif>
	</cfif>
	

</cfloop>