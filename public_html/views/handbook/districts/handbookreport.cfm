<cfparam name="districts" type="query">
<cfset churchcount = 0>
<cfset previouscity = "">

<cfoutput query="districts" group="district">
	<div style="font-size:1em">
		#district#
		<div style="font-size:.7em">
			<cfoutput group="state">
			#state#: 
				<cfoutput>
					<cfset churchcount = churchcount +1>
					<cfif org_city NEQ previouscity>
						#org_city#; 
					</cfif>	
					<cfset previouscity = org_city>
				</cfoutput>
				<br/>
			</cfoutput>
		</div>
	</div>
	<br/>
</cfoutput>


<cfoutput>
#churchcount#
</cfoutput>