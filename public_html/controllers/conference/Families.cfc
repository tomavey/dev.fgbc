<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout("/conference/adminlayout")>
		<cfset filters(through="officeOnly", except="showregs")>
		<cfset filters(through="setReturn", only="index,show,list,envelopes")>
	</cffunction>

	<!--- families/index --->
	<cffunction name="index">
		<cfset families = model("Conferencefamily").findAll(where="event = '#application.wheels.event#'", include="state,person(registration(option))", order="lname,id")>
	</cffunction>

	<!--- families/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
    	<cfset family = model("Conferencefamily").findAll(where="id=#params.key#", include="person,state")>

    	<!--- Check if the record exists --->
	    <cfif NOT family.recordcount>
	        <cfset flashInsert(error="family #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<cffunction name="showregs">
		<cfset usesLayout("/layout")>

    	<cfset family = model("Conferencefamily").findAll(where="id=#params.key#", include="person(registration(option)),state")>
<!---
		<cfdump var="#family#"><cfabort>
 --->

	</cffunction>

	<!--- families/new --->
	<cffunction name="new">
		<cfset family = model("Conferencefamily").new()>
		<cfset states = model("Handbookstate").findAll()>
	</cffunction>

	<!--- families/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset family = model("Conferencefamily").findByKey(key=params.key)>
		<cfset handbook_states = model("Conferencestate").findAll()>
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(family)>
	        <cfset flashInsert(error="family #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- families/create --->
	<cffunction name="create">

		<cfset family = model("Conferencefamily").new(params.family)>

		<!--- Verify that the family creates successfully --->
		<cfif family.save()>
			<cfset flashInsert(success="The family was created successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the family.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<!--- families/update --->
	<cffunction name="update">
		<cfset family = model("Conferencefamily").findByKey(params.key)>

		<!--- Verify that the family updates successfully --->
		<cfif family.update(params.family)>
			<cfset flashInsert(success="The family was updated successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the family.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- families/delete/key --->
	<cffunction name="delete">
		<cfset family = model("Conferencefamily").findByKey(params.key)>
		<cfset Model("Conferenceperson").deletePeopleByFamilyId(params.key)>

		<!--- Verify that the family deletes successfully --->
		<cfif family.delete()>
			<cfset flashInsert(success="The family was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the family.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="deleteAll">
		<cfset families = model("Conferencefamily").findAll()>

		<!--- Verify that the family deletes successfully --->
		<cfif families.delete()>
			<cfset flashInsert(success="All families were deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting all families.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="backup">
		<cfset backupresults = Model("family").backup()>
	</cffunction>

	<cffunction name="badges">
		<cfif isDefined("params.key")>
			<cfset datestart = params.key>
		<cfelseif isDefined("params.date")>
			<cfset datestart = params.date>
		<cfelse>
			<cfset datestart = createDate(year(now())-1,09,01)>
		</cfif>

		<cfset whereString = "(type = 'Adult' OR type = 'spouse') AND createdat > '#datestart#'">
		<cfif isDefined("params.previousyear")>
			<cfset datestart = createDate(year(now())-2,10,01)>
			<cfset dateend = createDate(year(now())-1,08,01)>
			<cfset whereString = "(type = 'Adult' OR type = 'spouse') AND createdat > '#datestart#' AND createdAt < '#dateend#'">
		</cfif>

		<cfset badges = model("Conferenceperson").findall(where=whereString, include="family", order="lname,fname")>

		<cfset count = QueryAddColumn(badges,"registered")>


		<cfoutput query="badges">
			<cfif isregistered(id)>
				<cfset querySetCell(badges,"registered",1, currentRow)>
			</cfif>
		</cfoutput>
		<cfquery dbtype="query">
			SELECT *
			FROM badges
			WHERE registered = 1
		</cfquery>
		<cfif isdefined("params.download")>
			  <cfset renderPage(layout="/conference/layoutdownload")>
		</cfif>
	</cffunction>

	<cffunction name="testIsRegistered">
		<cfset check = isRegistered(params.key)>
		<cfdump var="#check#"><cfabort>
	</cffunction>

	<cffunction name="isRegistered">
	<cfargument name="personid" required="true" type="numeric">
	<cfset var loc = structNew()>
	<cfset loc.return = false>
	<cfset loc.reg = model("Conferenceregistration").findOne(where="equip_peopleid=#arguments.personid#")>

	<cfif isObject(loc.reg)>
		<cfreturn loc.return>
	</cfif>

       <cfset loc.familyid = model("Conferenceperson").findOne(where="id=#arguments.personid#", include="family").equip_familiesid>
	   <cfset loc.spouse = model("Conferenceperson").findOne(where="equip_familiesid=#loc.familyid#", include="family")>
	   <cfif isObject(loc.spouse)>
	    	 <cfset loc.reg = model("Conferenceregistration").findOne(where="equip_peopleid=#loc.spouse.id#", include="invoice")>
		<cfif isObject(loc.reg)>
        		  <cfset loc.return = true>
	        	</cfif>
	</cfif>

	<cfreturn loc.return>
	</cffunction>

	<cffunction name="testIsRegistered">
	<cfargument name="personid" default="#params.key#">
	<cfset test = isRegistered(arguments.personid)>
	<cfdump var="#test#"><cfabort>
	</cffunction>

	<cffunction name="envelopes">
	<cfargument name="page" default="0">
	<cfargument name="maxrows" default="-1">

	<cfif isDefined("params.page")>
		<cfset arguments.page = params.page>
	</cfif>
	<cfif isDefined("params.maxrows")>
		<cfset arguments.maxrows = params.maxrows>
	</cfif>
	<cfif not isDefined("params.date")>
		<cfset params.date = "#year(now())-1#/08/01">
	</cfif>

	<cfset whereString = "createdat > '#params.date#'">
	<cfif isDefined("params.familyid")>
		<cfset whereString = whereString & " AND id=#params.familyid#">
	</cfif>

   		<cfset envelopes = model("Conferencefamily").findAll(where=whereString, order="lname")>

		<cfset options = model("Conferenceoption").findAll(where="event='#application.wheels.event#'", order="name")>
		<cfset listcounts = QuotedValueList("options.name")>
		<cfset listcounts = replace(listcounts,"'","","all")>
		<!--- <cfdump var="#badges#"><cfabort> --->
		<cfif isdefined("params.download")>
			  <cfset renderPage(layout="/conference/layoutdownload")>
		</cfif>
	</cffunction>

	<cffunction name="showThisEnvelope">
	<cfargument name="info" required="true" type="struct">
	<cfargument name="previousinvoice" required = "true"  type="string">
	<cfset var loc=structNew()>
	<cfset loc = arguments>

		<cfset loc.showThisEnvelope = true>
		<cfif loc.info.name EQ "NA" AND loc.info.invoice EQ loc.previousinvoice>
			<cfset loc.showThisEnvelope = false>
		</cfif>

		<cfif !len(loc.info.items)>
			<cfset loc.showThisEnvelope = false>
		</cfif>

	<cfreturn loc.showThisEnvelope>
	</cffunction>

<!---This method is used by the envelope view to gather information that should be on the registration envelope--->
	<cffunction name="thisFamilyEnvelopeInfo">
	<cfargument name="familyid" required="true">
	<cfargument name="optionid" default="0">
	<cfset var EnvelopeInfo = structnew()>
	<cfset var familyRegInfo = structnew()>
	<cfset var him = structnew()>
	<cfset var her = structnew()>
	<cfset EnvelopeInfo.items = "">
	<cfset EnvelopeInfo.invoice = "">
	<cfset EnvelopeInfo.status = "">
	<cfset itemOrder="FIELD(type, 'Meal', 'Other', 'Workshop', 'Registration')">

		<cfset him = Model("Conferenceperson").findAll(where="Equip_familiesid = #arguments.familyid# AND type='adult'", include="family")>
		<cfset her = Model("Conferenceperson").findAll(where="equip_familiesid=#arguments.familyid# AND type='Spouse'", include="family")>


		<cfif him.recordcount and her.recordcount>
			<cfset EnvelopeInfo.name = him.fname & " & " & her.fname>
			<cfif isDefined("params.showFnameId")>
				<cfset EnvelopeInfo.name = "<a href='/index.cfm/conference.registrations/consolidateregs/?temppersonid=#him.id#&lname=#lname#' target='_blank'>&##8225;</a> " & EnvelopeInfo.name>
			</cfif>
			<cfset wherestring = "event='#application.wheels.event#' AND (equip_peopleid = #him.id# OR equip_peopleid = #her.id#)">

		<cfelseif him.recordcount>
			<cfset EnvelopeInfo.name = him.fname>
			<cfif isDefined("params.showFnameId")>
				<cfset EnvelopeInfo.name = "<a href='/index.cfm/conference.registrations/consolidateregs/?temppersonid=#him.id#&lname=#lname#' target='_blank'>&##8225;</a> " & EnvelopeInfo.name>
			</cfif>
			<cfset wherestring = "event='#application.wheels.event#' AND equip_peopleid = #him.id#">
		<cfelseif her.recordcount>
			<cfset EnvelopeInfo.name = her.fname>
			<cfif isDefined("params.showFnameId")>
				<cfset EnvelopeInfo.name = "<a href='/index.cfm/conference.registrations/consolidateregs/?temppersonid=#him.id#&lname=#lname#' target='_blank'>&##8225;</a> " & EnvelopeInfo.name>
			</cfif>
			<cfset wherestring = "event='#application.wheels.event#' AND equip_peopleid = #her.id#">
		<cfelse>
			<cfset EnvelopeInfo.name = "NA">
		</cfif>

		<cfif isDefined("params.option")>
			<cfset wherestring = whereString & " AND name = '#params.option#'">
		</cfif>

			<cfset familyRegInfo = Model("Conferenceregistration").findAll(where=wherestring, include="option,invoice", order=itemOrder)>

		<cftry>
			<cfset envelopeInfo.status = paystatus(familyRegInfo.ccstatus)>
		<cfcatch></cfcatch></cftry>

		<cftry>
			<cfset envelopeInfo.invoice = familyRegInfo.ccorderid>
		<cfcatch></cfcatch></cftry>

		<cftry>
		<cfloop query="familyRegInfo">
			<cfset EnvelopeInfo.items = EnvelopeInfo.items & "; " & name & "[" & quantity & "]">
		</cfloop>
		<cfcatch></cfcatch></cftry>

		<cfset EnvelopeInfo.items = replace(EnvelopeInfo.items,"; ","","one")>

	<cfreturn EnvelopeInfo>
	</cffunction>

	<cffunction name="TestThisFamilyEnvelopeInfo">
		<cfset test1 = thisFamilyEnvelopeInfo(1610)>
		<cfset test2 = thisFamilyEnvelopeInfo(1545)>
		<cfdump var="#test1#"><cfdump var="#test2#"><cfabort>
	</cffunction>



</cfcomponent>
