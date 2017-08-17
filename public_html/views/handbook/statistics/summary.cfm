<cfset attTotal = 0>
<cfset attCount = 0>
<cfoutput query="handbookstatistics">
	<cfif len(att)>
	<cfset attCount = attCount + 1>
	<cfset attTotal = attTotal + val(att)>
	</cfif>
</cfoutput>
<cfoutput>
	#attcount#
	#atttotal#
</cfoutput>