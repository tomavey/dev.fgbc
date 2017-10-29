<cfparam name="people" type="query">
<cfset count = 0>
<cfset previousdistrict = "">
<cfset previousalpha = "">

<div class="table table-striped">
<!---
<h1><cfoutput>#getTitle()#</cfoutput></h1>	
--->

<cfoutput>
	<p>
		<cfloop list="#getAlphabet()#" index="i">
			#linkto(text=i, route="handbookAgbmList", params="type=members&alpha=#i#")#
		</cfloop>
		#linkto(text="ALL", route="handbookAgbmList")#
	</p>
</cfoutput>

<p>
	<cfoutput query="districts">
		#linkto(text=district, route="handbookAgbmList", key="members", params="type=members&district=#districtid#")#
	</cfoutput>
	<cfoutput>#linkto(text="ALL", route="handbookAgbmList", params="type=members&district=all")#</cfoutput>
</p>

<cfif isDefined("params.district")>
	<cfset downloadParamsList = "download=true&district=#params.district#">
<cfelseif isDefined("params.alpha")>	
	<cfset downloadParamsList = "download=true&alpha=#params.alpha#">
<cfelse>
	<cfset downloadParamsList = "download=true">
</cfif>

<cfoutput>
	<cfif isDefined("params.key")>
	#linkto(text="<i class='icon-download-alt'></i>", action="list", key=params.key, params=downloadParamsList, class="tooltipleft btn download", title="Download this list as an excel spreadsheet")#
	<cfelse>	
	#linkto(text="<i class='icon-download-alt'></i>", action="list", params=downloadParamsList, class="tooltipleft btn download", title="Download this list as an excel spreadsheet")#
	</cfif>
</cfoutput>     

<table>
	<thead>
		<tr>
			<th>
				Name
			</th>
			<th>
				Organization
			</th>
			<th>
				District
			</th>
			<th>
				Last Payment
			</th>
			<cfif gotRights("superadmin,agbmadmin")>
			<th>
				&nbsp;
			</th>
			</cfif>			
		</tr>
	<tbody>
    		<cfoutput query="people">
				<cfif isDefined("params.district") and district IS NOT previousdistrict and params.district is not "all">
				<tr>
					<td colspan="5"><h2>#district#</h2></td>
				</tr>	
				</cfif>
				<cfif isDefined("params.alpha") and alpha IS NOT previousalpha and params.alpha is not "all">
				<h2>#alpha#</h2>
				</cfif>
    			#includePartial("table")#
				<cfset count = count +1>
				<cfset previousdistrict = district>
				<cfset previousalpha = alpha>
    		</cfoutput>
	</tbody>
</table>
<cfif isDefined("params.key") and params.key is "all">
<p>* = This person is in the database but is NOT listed in the FGBC handbook. They may be deleted from the database at a future date.</p>
</cfif>

<!---cfif showpagination()>
	<cfoutput>
		#includePartial("/_shared/paginationlinks")#
	</cfoutput>
</cfif--->
<cfoutput>
<p>
   Total Count=#count#
</p>
</cfoutput>
</div>