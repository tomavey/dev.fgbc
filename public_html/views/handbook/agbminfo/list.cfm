<cfparam name="people" type="query">
<!--- agbmlifememberAt --->
<cfset count = 0>
<cfset previousdistrict = "">
<cfset previousalpha = "">
<cfset showOrdainedOnly = false>
<cfset showCommissionedOnly = false>
<cfif isDefined("params.ordainedonly")>
	<cfset showOrdainedOnly = true>
</cfif>
<cfif isDefined("params.commissionedonly")>
	<cfset showCommissionedOnly = true>
</cfif>

<div class="table table-striped">
<!---
<h1><cfoutput>#getTitle()#</cfoutput></h1>	
--->
<!--- <cfdump var="#people#" abort> --->
<cfoutput>
	<p>
		<cfloop list="#getAlphabet()#" index="i">
			#linkto(text=i, route="handbookAgbmList", params="type=members&alpha=#i#")#
		</cfloop>
		#linkto(text="ALL", route="handbookAgbmList")#
		<cfif !showAge>
			#linkTo(text="Show Year Born", action="list", params="byage=DESC", class="btn pull-right")#
		</cfif>
	</p>
</cfoutput>

<p>
	<cfoutput query="districts">
		#linkto(text=district, route="handbookAgbmList", params="type=members&district=#districtid#")#
	</cfoutput>
	<cfoutput>#linkto(text="ALL", route="handbookAgbmList", params="type=members&district=all")#</cfoutput>
</p>

<cfoutput>
		#linkto(text="<i class='icon-download-alt'></i>", action="list", params=makeDownloadParamsList(), class="tooltipleft btn download", title="Download this list as an excel spreadsheet")#
</cfoutput>     

<table>
	<thead>
		<tr>
			<th>
				<cfif showAge>
					Name/Birthyear
				<cfelse>
					Name
				</cfif>
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
	</thead>	
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
				<cfset REQUEST.lastpayment = getLastPayment(personid)>
				<cfset REQUEST.payments = getPayments(personid)>
				<cfif !showOrdainedOnly || (showOrdainedOnly && find("Ordained",REQUEST.lastpayment))>
					<cfif !showCommissionedOnly || (showCommissionedOnly && find("Commissioned",REQUEST.lastpayment))>
	    			#includePartial("table")#<!---Table Row--->
						<cfset count = count +1>
					</cfif>
				</cfif>
				<cfset previousdistrict = district>
				<cfset previousalpha = alpha>
    		</cfoutput>
	</tbody>
</table>
<cfif isDefined("params.key") and params.key is "all">
<p>* = This person is in the database but is NOT listed in the Charis Fellowship handbook. They may be deleted from the database at a future date.</p>
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

#linkto(text="Ordained Only", route="handbookAgbmList", params="type=members&ordainedOnly=")# | 
#linkto(text="Commissioned Only", route="handbookAgbmList", params="type=members&commissionedOnly=")# |
#linkto(text="All", route="handbookAgbmList", params="type=members")# |


</cfoutput>
</div>