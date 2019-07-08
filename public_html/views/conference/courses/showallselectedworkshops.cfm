<cfparam name="workshops" type="query">
<cfparam name="totalThisQuantity" default="0">
<cfparam name="totalAllQuantity" default="0">
<cfparam name="totalAllCount" default="0">
<cfparam name="request.emailall" default="">
<cfparam name="request.emailallall" default="">
<cfset accumulatedEmailList = "">
<cfset summary = structNew()>
<div id="showallselectedcohorts">
<p>&nbsp;</p>
<p><a href="#summaryOfCounts" class="btn">Go to summary of totals</a>
<cfoutput>
#linkto(text='Download', controller="conference.courses", action="downloadallselectedcohorts", params="download=1", class="btn pull-right")#
</cfoutput>
</p> 
<cfoutput query="workshops" group="title">
<cfset grouprowcount = 0>

<div class="eachItemShown" id="list">

	<h1>#title#</h1>

<!---
	<cfif isDefined("subtype") && showSubTypesOfCourses()>
            <p class="subtype">#subtype#</p>
	</cfif>
--->
	<p>
		<table class="reglist">
			<th>&nbsp;</th><th>Name</th>
			<cfif gotRightsForEmailLinks()>
				<th>Email</th>
			</cfif>
		<cfset totalThisQuantity = 0>
	<cfoutput>
	<cfif not isDefined("params.noMll")	OR not isRegMLL(personid)>
	<cfset grouprowcount = grouprowcount +1>
			<tr>
				<td>#grouprowcount#</td>
				<td>
					<cfif gotRights("office")>
						#linkto(text='#cleanname(lname)#, #cleanname(fname)#' , controller="conference.people", action="show", key=EQUIP_PEOPLEID)#
					<cfelse>	
						#cleanname(lname)#, #cleanname(fname)#
					</cfif>
				</td>
				<td>

					<cfif len(conferencepersonemail)>
						<cfset thisemail = Conferencepersonemail>
					<cfelseif len(getSpouseEmail(equip_peopleid))>
						<cfset thisemail = getSpouseEmail(equip_peopleid)>
					</cfif>
					<cfif gotRightsForEmailLinks()>
						#mailto(thisemail)#
					</cfif>
				</td>
			<cfif gotRights("superadmin,office")>
				<td>
					#showTag(controller="conference.courses", action="showselectedworkshops", personid="#equip_peopleid#", params="personid=#equip_peopleid#")#
					#linkTo(text="<i class='icon-envelope'></i>", href="mailto:#email#&body=https://charisfellowship.us/invoice/#equip_invoicesid#", title="Email this invoice", class="tooltipside")#
					#linkTo(text="<i class='icon-trash'></i>", action="deletedSelectedWorshopsForRegId", key=id, title="Delete this selection", class="tooltipside")#
				</td>
			</cfif>
			</tr>
		<cfset totalThisQuantity = totalThisQuantity + val(quantity)>
		<cfset emailEveryone(Conferencepersonemail)>
		<cfset emailEveryoneAll(Conferencepersonemail)>
	</cfif>

	</cfoutput>
		</table>
		<cfset summary[title].count = totalThisQuantity>
		<p>Total for #title#: #totalThisQuantity#</p>
		<cfif val(max)>
		<p>Maximum: #max#</p>
		</cfif>

		<p>Link: #linkTo(controller="conference.courses", action=params.action, key="#equip_coursesid#", onlyPath=false)#</p>
		<cfif gotRightsForEmailLinks()>
			<p>Email All: #emailEveryone()#</p>
		</cfif>
		<p>Questions posted: #linkTo(controller="conference.coursequestions", action="list", params="courseid=#equip_coursesid#", onlyPath=false)#</p>
		<cftry>
		<p>Room and Date: #getEventEquipmentForThisCourse(eventid).selectName#</p>
		<cfset request.equipment =  #getEventEquipmentForThisCourse(eventid).equipment#>
		<cfif len(request.equipment)>
			<p>Equipment requested:#getEventEquipmentForThisCourse(eventid).equipment#</p>
		<cfelse>
			<p>No equipment requests</p>
		</cfif>
		<cfcatch></cfcatch>
		</cftry>
<!--- 		<p>These people also signed up for: #alsoSignedUpFor(equip_coursesid)#</p> --->
</div>

<cfset totalAllQuantity = totalAllQuantity + totalThisQuantity>
<cfset totalAllCount = totalAllCount + grouprowcount>


</cfoutput>
<cfoutput>
<div class="eachItemShown" id="summaryOfCounts">
<cftry>
<h3>Summary of counts</h3>
<cfset summaryKeys  = StructKeyArray(summary)>
<cfset ArraySort(summaryKeys, "text")>
<table>
	<cfloop from="1" to="#structCount(summary)#" index="i">
		<tr>
			<td>
				#summaryKeys[i]#
			</td>
			<td>
				#summary[summaryKeys[i]].count#
			</td>
		</tr>
	</cfloop>
	
</table>
</ol>
<cfcatch>Something is broken</cfcatch></cftry>
<cfset emaillistall = #emailEveryoneAll()#>
Total signups = #totalAllQuantity#<br/>
Total number of registered people eligible to sign up = #countpeopleregistered#</br>
Total of these registered people that have signed up = #listlen(emaillistall,";")#<br/>
Cohorts with no signups: #emptyWorkshops#
</div>

<cfif gotRightsForEmailLinks()>
	<p>Email All = #emaillistall#</p>
</cfif>
</cfoutput>

<hr/>
<cfif gotRightsForEmailLinks()>
	<cfoutput>
		<table>
		<cfloop list="#emailEveryoneAll()#" delimiters=";" index="i">
		<tr>
		<td>
			#i#
		</td>
		</tr>
		</cfloop>
		</table>
		</cfoutput>
</cfif>
</div>

