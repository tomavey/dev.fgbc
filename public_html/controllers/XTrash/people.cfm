<!--- route="handbookPerson" pattern="handbook/person/[key]" handbookpeople/show/key --->
<cffunction name="show">

	<cftry>

   	<cfset handbookperson = model("Handbookperson").findOne(where="id=#params.key#", include="Handbookstate,Handbookprofile,Handbookpictures,Handbooknotes")>
		<cfset tags=model("Handbooktag").findMyTagsForId(params.key,"person")>

	<cfif gotrights("agbm,office,superadmin,agbmadmin")>
		<!---Set up new form for groups within the show report--->
			<cfset handbookGroup = model("Handbookgroup").new()>
			<cfset handbookGroup.personId = params.key>
			<cfset allgroups = model("Handbookgrouptype").findAll(order="title")>
			<cfset groups = model("Handbookgroup").findAll(where="personid=#params.key#", include="handbookGroupType")>
	</cfif>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookperson)>
	        <cfset flashInsert(error="Handbookperson #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

		<cfif isdefined("params.ajax")>
			<cfset renderPartial("show")>
		</cfif>

	<cfcatch>
		<cfset #sendPersonPageErrorNotice()#>
   	<cfset redirectTo(action="index", error="Oops! Something went wrong try to access this person.  We are working on a solution. You should be able to continue from this page.")>
	</cfcatch>
	</cftry>

	</cffunction>

	<cffunction name="view">
		<cfset handbookperson = model("Handbookperson").findOne(where="id=#params.key#", include="State,Handbookpositions,Handbookpictures")>
		<cfif handbookperson.private is "yes">
			<cfset redirectTo(action="index")>
		</cfif>
		<cfset renderPage(layout="/handbook/layout_handbook2")>
	</cffunction>

	<!---route="handbookVcard", pattern=pattern="/people/vcard/[key]"--->
	<cffunction name="vcard">
		<cfset handbookperson = model("Handbookperson").findByKey(key=params.key, include="Handbookstate,Handbookprofile,Handbookpictures,Handbooknotes")>
	<cfsavecontent variable="vcard">
		<cfoutput>
		<cfcontent type="text/x-vCard">
		<cfheader name="Content-Disposition" value="inline; filename=newPerson.vcf">
		BEGIN:VCARD
		VERSION:3.0
		N;charset=iso-8859-1:#handbookperson.lname#;#handbookperson.fname#
		BDAY;value=date:#handbookperson.handbookprofile.birthdayasstring#
		EMAIL;type=HOME:#handbookperson.email#
		ADR;type=WORK;charset=iso-8859-1:;;#handbookperson.address1#;#handbookperson.address2#;#handbookperson.city#;#handbookperson.state_mail_abbrev#;#handbookperson.zip#
		TEL;type=HOME:#handbookperson.phone#
		END:VCARD
		</cfoutput>
	</cfsavecontent>
	<cfset renderText(vcard)>
</cffunction>

	<!--- "newHandbookPerson" /handbook/people/new --->
	<cffunction name="new">
		<cfset var loc = structNew()>
			<cfset loc.newposition = [ model("Handbookposition").new() ]>
			<cfset loc.newprofile = model("Handbookprofile").new()>
	
			<cfset handbookperson = model("Handbookperson").new(handbookpositions = loc.newposition, handbookprofile=loc.newprofile)>
	
			<!---Set up organizationid if provided in key--->
			<cfif isDefined("params.key")>
					<cfset handbookperson.handbookpositions[1].organizationid = params.key>
			</cfif>
	
			<!---Set the default sortorder or use sortorder provided in params is exists--->
			<cfif isDefined("params.sortorder")>
					<cfset handbookperson.handbookpositions[1].p_sortorder = params.sortorder>
			<cfelse>
					<cfset handbookperson.handbookpositions[1].p_sortorder = #getNonStaffSortOrder()#>
			</cfif>
	
			<cfif isAgbmAdmin>
					<cfset handbookperson.handbookpositions[1].p_sortorder = #getNonStaffSortOrder()#>
					<cfset handbookperson.handbookpositions[1].position = "AGBM Only">
					<cfset handbookperson.handbookpositions[1].positiontypeid = 32>
			</cfif>
	
			<cfif isDefined("params.organizationid")>
					<cfset handbookperson.handbookpositions[1].organizationid = params.organizationid>	
			</cfif>
	
			<cfset renderPage(layout="/handbook/layout_handbook1.cfm")>
	
		</cffunction>

		<cffunction name="wifesbirthday">
			<cfset profiles = model("Handbookprofile").findAll(where="wifesbirthday IS NOT NULL")>
		<cfloop query="profiles">
			<cfset test = loadDateAsString(personid,dateformat(wifesbirthday,"yyyy-mm-dd"))>
			<cfdump var="#test#">
		</cfloop>
			<cfset profiles = model("Handbookprofile").findAll(where="wifesbirthday IS NOT NULL")>
		<cfdump var="#profiles#"><cfabort>
		</cffunction>
	
		<cffunction name="loadDateAsString">
		<cfargument name="personid" required="true" type="numeric">
		<cfargument name="date" required="true" type="string">
		<cfargument name="key" default="wifesbirthdayasstring">
		<cfset var loc = structNew()>
	
		<cfset loc.person = model("Handbookprofile").findOne(where="personid = #arguments.personid#")>
		<cfset loc.person[arguments.key] = "#arguments.date#">
	<!---<cfdump var="#loc.person#"><cfabort>
	--->
		<cfset loc.test = loc.person.save()>
		<cfreturn loc.test>
		</cffunction>

		<cffunction name="sendProfileFormLink">
			<cfargument name="emailTo" required="false" type="string">
			<cfargument name="emailFrom" default="#session.auth.email#">
			<cfset var loc = structNew()>
		
					<cfif not isDefined("arguments.emailto")>
							<cfset arguments.emailto = model("Handbookperson").findOne(where="id=#params.key#", include="Handbookstate").email>
					</cfif>
					<cfif arguments.emailto is "tomavey@fgbc.org">
							<cfset arguments.emailto = "tomavey@comcast.net">
					</cfif>
		
				<cfset params.emailto=arguments.emailto>
		
					 <cfset sendEMail(to=arguments.emailto, from=arguments.emailfrom, subject="From the Charis Fellowship Online Handbook: Your person profile.", template="sendprofileform", layout="/layout_naked")>
		
		 </cffunction>

		 <cffunction name="sendNoticeOfPersonUpdate">
			<cfargument name="personid" required="true" type="numeric">
			
				<cfset sendEmail(
					to=application.wheels.HandbookProfileSecretary,
					from="tomavey@fgbc.org",
					subject="Person Update",
					layout="/layout_naked",
					template="/views/handbook_updates/notice"
					)>
			
			<cfreturn true>
			</cffunction>
			
			<cffunction name="possibleConferenceRegs">
			<cfargument name="personid" required="true" type="numeric">
			<cfset var loc=structNew()>
			<cfset loc.person = model("Handbookperson").findOne(where="id=#arguments.personid#", include="Handbookstate")>
			<cfset loc.regs = model("equip_registration").findAll(where='lname like "#loc.person.lname#%"', include="equip_person(equip_family)")>
				<cfsavecontent variable="loc.return">
					<table class="table">
						<cfoutput query="loc.regs" group="equip_personid">
						<tr>
							<td>#lname#, #fname#</td>
							<td>#email#</td>
							<td>#dateFormat(createdAt,"yyyy")#</td>
							<td>
							<cfif handbookpersonid is arguments.personid>
								LINKED
							<cfelse>
								#linkto(text="link", action="connectRegToHandbook", params="regpersonid=#equip_personid#&handbookpersonid=#params.key#")#
							</cfif>
							</td>
						</tr>
						</cfoutput>
					</table>
				</cfsavecontent>
			<cfreturn loc.return>
			</cffunction>

			<cffunction name="findNextHandbookPerson">
				<cfargument name="personid" required="true" type="numeric">
				<cfset var loc=structNew()>
				<cfset loc.nextid=0>
				<cfset loc.nextrow = false>
				<cfset var loc.return=0>
				<cftry>
					<cfset HandbookPeople = model("Handbookperson").findAll(where="p_sortorder < #getNonStaffSortOrder()+1#", order="alpha", include="Handbookstate,Handbookpositions")>
					<cfloop query="handbookPeople">
						<cfif loc.nextrow>
							<cfreturn id>
						</cfif>
						<cfif handbookPeople.id is arguments.personid>
							<cfset loc.nextrow = true>
						</cfif>
					</cfloop>
				<cfcatch></cfcatch></cftry>
					<cfreturn 0>
				</cffunction>
							
		

<cffunction name="checkpics">
	<cfset pics = model("Handbookpicture").findAll()>
	<cfloop query = "pics">
		<cfset thispic = model("Handbookpicture").findAll(where="personid = #personid#")>
		<cfif thispic.recordCount is 1 AND thispic.usefor NEQ "default">
			<cfoutput>#id# - #personid# - #usefor#<br/></cfoutput>
			<cfquery datasource="fgbc_main_3" result="data">
				update handbookpictures
				set usefor = "default"
				where id = #id#
			</cfquery>
		</cfif>
	</cfloop>
	<cfabort>
</cffunction>


<!---used in commented out section of people.show if page error happens in try/catch--->
<cffunction name="sendPersonPageErrorNotice">
	<cfargument name="subject"  default="Charis Fellowship Handbook Person Page Error">
	<cftry>
			<cfset sendEmail(from=application.wheels.errorEmailAddress, to=application.wheels.errorEmailAddress, template="personpageerroremail.cfm", subject=arguments.subject)>
		<cfcatch>
		</cfcatch>
	</cftry>
</cffunction>

<!---Testing editor--->

