<!---<cfdump var="#registrations#"><cfabort>--->
<cfif registrations.recordcount>
<cfoutput query="registrations" group="ccorderid">
<div class="eachItemShown">
	#linkto(action="show",controller="conference.invoices",key=EQUIP_INVOICESID, text=ccorderid)#
	<cfoutput group="EQUIP_PEOPLEID">
		<div class="searchname">
			#linkto(action="show", controller="conference.people", key=EQUIP_PEOPLEID, text=fname)# 
<!--- 
			#linkto(action="show", controller="conference.people", key=GetSpouseLink(EQUIP_PEOPLEID).id, text=GetSpouseLink(EQUIP_PEOPLEID).name)# 
 --->
			#linkto(action="show", controller="conference.families", key=EQUIP_FAMILIESID, text=lname)#
		</div>

		<cfoutput>
		<div class="searchreg">
			#linkto(action="show", controller="conference.registrations", key=CONFERENCEREGISTRATIONID, text=buttondescription)##editTag(CONFERENCEREGISTRATIONID)#
		</div>
		
		</cfoutput>
	</cfoutput>	
</div>	
</cfoutput>
<cfelse>
<div class="eachItemShown">
"No Registration Records Found!"
</div>
</cfif>

