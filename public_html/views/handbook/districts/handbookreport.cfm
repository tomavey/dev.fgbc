<cfparam name="districts" type="query">
<cfset churchcount = 0>
<cfset previouscity = "">

<div class="span11">

<cfoutput query="districts" group="district">
	<p>
		<span style="font-size:1em">#district#</span>
		<span style="font-size:.7em">
			<cfoutput group="state">
			#state#: 
				<cfoutput>
					<cfset churchcount = churchcount +1>
					<cfif org_city NEQ previouscity>
						#org_city#; 
					</cfif>	
					<cfset previouscity = org_city>
				</cfoutput>
			</cfoutput>
		</span>
	</p>
</cfoutput>


<cfoutput>
#churchcount#
</cfoutput>
</div>