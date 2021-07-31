<cfparam name="people" type="query">
<cfset count = 0>
<cfset age60 = 0>
<cfset age50 = 0>
<cfset age40 = 0>
<cfset age30 = 0>
<cfset age20 = 0>
<cfset noage = 0>

<div class="table table-striped">
<cfif isDefined("params.excel")>
	  <cfset downloadthis = true>
<cfelse>
	  <cfset downloadthis = false>
</cfif>
<cfoutput>
<cfif not downloadthis>
  <cfif isDefined("params.groupby")>
     #linkto(text="<i class='icon-download-alt'></i>", params="groupby=#params.groupby#&excel=true", class="tooltipleft btn download", title="Download this list as an excel spreadsheet")#
  <cfelse>
     #linkto(text="<i class='icon-download-alt'></i>", params="excel=true", class="tooltipleft btn download", title="Download this list as an excel spreadsheet")#
  </cfif>
</cfif>
</cfoutput>
<h1><cfoutput>#getTitle()#</cfoutput></h1>	

<cfoutput>
<ul class="nav nav-tabs">
    <li class="#iif(not isDefined('params.groupby') AND not isdefined('params.showall'),DE('active'),DE('none'))#">
    	#linkTo(text="List Alphabetically w/pages", params="")#
    </li>
    <li class="#iif(not isDefined('params.groupby') AND isdefined('params.showall'),DE('active'),DE('none'))#">
    	#linkTo(text="List Alphabetically no pages", params="showall=true")#
    </li>
    <li class="#iif(isDefined('params.groupby') AND params.groupby is 'district' AND NOT isDefined('params.showall'),DE('active'),DE('none'))#">
		#linkTo(text="Group by District w/pages", params="groupby=district")#
	</li>
    <li class="#iif(isDefined('params.groupby') AND params.groupby is 'district' AND isDefined('params.showall'),DE('active'),DE('none'))#">
		#linkTo(text="Group by District no pages", params="groupby=district&showall=true")#
	</li>
</ul>
</cfoutput>

<cfif showpagination()>
	<cfoutput>
		#includePartial(partial="/_shared/paginationlinks")#
	</cfoutput>
</cfif>

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
		<cfif isDefined("params.groupby") AND params.groupby is "district">   
    		<cfoutput query="people" group="district">
			<cfif (districtid NEQ 30 and districtid neq 31) or isDefined("params.showministries")>
			<cfset districtcount = 0>
				<tr>
					<td colspan="5">
						<h2>#linkto(text=district, action="list", params="district=#districtid#&groupby=district&showall=")#</h2>
					</td>
    			</tr>	

				<cfoutput group="id">

					#includePartial(partial="agecounter")#
					#includePartial(partial="table")#
					<cfset count = count +1>
					<cfset districtcount = districtcount +1>

				</cfoutput>	
				<tr>
					<td colspan="5">
						&nbsp;&nbsp;&nbsp;&nbsp;Count for #district# = #districtcount#
					</td>
    			</tr>	
			</cfif>								    		
    		</cfoutput>
		<cfelse>
    		<cfoutput query="people" group="id">
				<cfif showThisPerson(id,params)><!---checks to eliminate members when mailing list is called for--->

    		
    			#includePartial(partial="agecounter")#

    			#includePartial(partial="table")#

    				<cfset count = count +1>
				</cfif>	
    		</cfoutput>
		</cfif>
	</tbody>
</table>
<cfif isDefined("params.key") and params.key is "all">
<p>* = This person is in the database but is NOT listed in the Charis Fellowship handbook. They may be deleted from the database at a future date.</p>
</cfif>

<cfif showpagination()>
	<cfoutput>
		#includePartial(partial="/_shared/paginationlinks")#
	</cfoutput>
</cfif>
<cfoutput>
<p>
   Total Count=#count#
</p>
<p>AGE DISTRIBUTION:</p>
<p>
   60+ = #age60#
</p>
<p>
   50's = #age50#
</p>
<p>
   40's = #age40#
</p>
<p>
   30's = #age30#
</p>
<p>
   20's = #age20#
</p>
<p>
<p>** = No birthday information on file = #noage#</p></p>
<p>* = Not on a church staff<p>
</cfoutput>
</div>
