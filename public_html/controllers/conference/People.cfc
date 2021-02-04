<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<cfset usesLayout("/conference/adminlayout")>
		<!--- <cfset filters(through="officeOnly", except="show")> --->
		<!--- Removed exception to protect data - TODO: Figure out a better way --->
		<cfset filters(through="officeOnly")>
		<cfset filters(through="setreturn", only="index,show,list")>
	</cffunction>

<!---------->
<!---CRUD--->
<!---------->

	<!--- peoples/index --->
	<cffunction name="index">
	<cfset var loc = structNew()>
		<cfif isDefined("params.key")>
			<cfset loc.regyear  = params.key-1>
		<cfelseif month(now()) LTE 9>
			<cfset loc.regyear  = year(now())-1>
		<cfelse>
			<cfset loc.regyear = year(now())>
		</cfif>

		<cfset datelimit = createDateTime(loc.regyear,8,01,01,01,01)>

		<cfset people = model("Conferenceperson").findAll(where="createdAt > '#datelimit#'", include="family(state),age_ranges", order="lname,equip_familiesid,id")>

	</cffunction>

	<!--- peoples/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
    	<cfset people = model("Conferenceperson").findByKey(key=params.key, include="family,age_ranges")>

    	<cfset regsforthisperson = model("Conferenceregistration").findAll(where="equip_peopleid = #params.key#", include="option, invoice")>

    	<cfset otherPeopleInSameFamily = model("Conferenceperson").findAll(where="equip_familiesid = #people.equip_familiesId# AND id <> #people.id#", include="family")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(people)>
	        <cfset flashInsert(error="people #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

		<cfif !gotRights("office")>
			<cfset renderView(layout="/conference/layout2017")>
		</cfif>

	</cffunction>

	<!--- peoples/new --->
	<cffunction name="new">
		<cfset people = model("Conferenceperson").new()>
		<cfset families = model("Conferencefamily").findAll(order="lname,id DESC")>
		<cfset ageRanges = Model("Conferenceage_range").findAll()>
		<cfif isdefined("params.familyid")>
			<cfset people.equip_familiesid = params.familyid>
		</cfif>
		<cfif isdefined("params.invoiceid")>
			<cfset people.equip_invoicesid = params.invoiceid>
			<cfset options = model("Conferenceoption").findAll(where="event = '#getEvent()#'", order="type,name")>
		</cfif>

	</cffunction>

	<!--- peoples/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset people = model("Conferenceperson").findByKey(key=params.key, include="family")>
		<cfset families = model("Conferencefamily").findAll(where="createdAt > '#year(now())-1#-08-01'", order="lname")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(people)>
	        <cfset flashInsert(error="people #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

		<cfset ageRanges = Model("Conferenceage_range").findAll()>

	</cffunction>

	<!--- peoples/create --->
	<cffunction name="create">
		<cfif isDefined("params.people.lname") and len(params.people.lname)>
			<!---Create a new family--->
			<cfset params.families.lname = params.people.lname>
			<cfset params.families.email = params.people.email>
			<cfset params.families.phone = params.people.phone>
			<cfset params.families.address = "test">
			<cfset family = model("Conferencefamily").create(params.families)>
			<cfif isObject(family)>
				<cfset params.people.equip_familiesId = family.id>
			<cfelse>
				<cfset renderText("oops")><cfabort>	
			</cfif>
		</cfif>
		<cfset people = model("Conferenceperson").create(params.people)>

		<!--- Verify that the people creates successfully --->
		<cfif isObject(people)>
			<cfif val(params.people.equip_invoicesid)>
				<cfset params.people.equip_peopleid = people.id>
				<cfif val(params.people.equip_optionsid)>
					<cfset thisoption = model("Conferenceoption").findOneById(params.people.equip_optionsid)>
					<cfset params.people.cost = thisoption.cost>
					<cfset params.people.quantity = 1>
				</cfif>

				<cfset registration = model("Conferenceregistration").create(params.people)>
			</cfif>

			<cfset flashInsert(success="The people was created successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the people.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>

	<!--- peoples/update --->
	<cffunction name="update">
		<cfset params.people.equip_familiesid = params.equip_familiesid>

		<cfset people = model("Conferenceperson").findByKey(key=params.key, include="family")>

		<!--- Verify that the people updates successfully --->
		<cfif people.update(params.people)>
			<cfset flashInsert(success="The people was updated successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the people.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>

	<!--- peoples/delete/key --->
	<cffunction name="delete">
		<cfset thisperson = Model("Conferenceperson").findOne(where="id=#params.key#", include="family")>

		<!--- Verify that the people deletes successfully --->
		<cfif thisperson.delete()>
			<cfset flashInsert(success="The people was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the people.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

<!--------------------->
<!--- END OF CRUD ----->
<!--------------------->


	<cffunction name="male">
		<cfset thisperson = model("Conferenceperson").findOne(where="id=#params.key#", include="family")>
		<cfset thisperson.gender = "M">
		<cfset thisperson.update()>
		<cfset redirectTo(action="index")>
	</cffunction>

	<cffunction name="female">
		<cfset thisperson = model("Conferenceperson").findOne(where="id=#params.key#", include="family")>
		<cfset thisperson.gender = "F">
		<cfset thisperson.update()>
		<cfset redirectTo(action="index")>
	</cffunction>

	<cffunction name="change_email">
    	<cfset people = model("Conferenceperson").findByKey(key=params.key, include="family")>
    	<cfset renderView(layout="/conference/layout")>
	</cffunction>

	<cffunction name="updateEmail">

		<cfset people = model("Conferenceperson").findByKey(key=params.key, include="family")>

		<!--- Verify that the people updates successfully --->
		<cfif people.update(params.people)>
			<cfset flashInsert(success="The people was updated successfully.")>
            <cfset redirectTo(controller="prayer_triplets", action="mygroup", key=params.key)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the people.")>
			<cfset renderView(action="change_email")>
		</cfif>
	</cffunction>

	<cffunction name="mailList">
		<cfset emailall = "">
		<cfset count = 0>

		<cfif isDefined("params.regonly")>
			<cfset distinctEmail = model("Conferenceperson").findMailListRegsOnly()>
		<cfelse>
			<cfset distinctEmail = model("Conferenceperson").findMailList()>
		</cfif>

		<cfif isdefined("params.key") and params.key is "download">
			<cfset params.download = true>
		<cfelse>
			<cfset params.download = false>
		</cfif>

		<cfset distinctEmail = removeNotListFromQuery(distinctEmail)>

		<cfset renderView(layout="/conference/layoutdownload")>

	</cffunction>

	<cffunction name="removeNotListFromQuery">
	<cfargument name="oldquery" required="true" type="query">
	<cfset var i = "">
	<cfset var previousEmail = "">
	<cfset newQuery = QueryNew(oldquery.columnlist)>

	<cfloop query="oldquery">
		<cfif !listFind(emailNotList(),email) && isValid("email",email) && email NEQ previousEmail>
			<cfset QueryAddRow(newquery)>
			<cfloop list="#oldquery.columnlist#" index="i">
				<cfset QuerySetCell(newQuery, i, oldquery[i])>
			</cfloop>
		</cfif>
	<cfset previousEmail = duplicate(email)>	
	</cfloop>
	<cfreturn newquery>
	</cffunction>

	<cffunction name="emailNotList">
		<cfreturn getSetting("emailNotList")>
	</cffunction>

	<cffunction name="emailList">
		<cfset emailList=model("Conferenceperson").findEmailList()>
		
		<cfset emailList = removeNotListFromQuery(emailList)>
		<cfif isdefined("params.key") and params.key is "download">
			<cfset params.download = true>
		<cfelse>
			<cfset params.download = false>
		</cfif>
		<cfset renderView(layout="/conference/layoutdownload")>
	</cffunction>

	<cffunction name="PastorNotList">
	<cfif isDefined("params.pastorsonly")>
		<cfset pastors = model("Conferenceregistration").connecthandbookpeople(true)>
	<cfelse>
		<cfset pastors = model("Conferenceregistration").connecthandbookpeople()>
	</cfif>
	</cffunction>

	<cffunction name="changeRegPerson" hint="I consolidate regs into one personid">
	<cfargument name="registrationId" required="true" type="numeric">
	<cfargument name="personId" required="true" type="numeric">

		<cfset reg = model("Registration").findByKey(arguments.registrationid)>
		<cfset reg.equip_peopleid = arguments.personid>
		<cfset reg.update()>

	</cffunction>

	<cffunction name="consolidateRegs">
	<cfargument name="personId" required="true" type="numeric">
	<cfargument name="newPersonId" required="true" type="numeric">
		<cfset regs = model("Conferenceregistration").findAll(where="equip_peopleid = #arguments.personid#")>
		<cfloop query="regs">
			<cfset changeRegPerson(id,arguments.newpersonid)>
		</cfloop>
		<cfset returnback()>
	</cffunction>

	<cffunction name="hasThisAdultSelectedWorkshops">
	<cfargument name="personid" required="true" type="numeric">
	<cfset workshop = model("Conferenceregistration").findOne(where="equip_peopleid = #arguments.personid# AND equip_optionsid = 270")>
		<cfif isObject(workshop)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="hasThisPersonRegistered">
	<cfargument name="personid" required="true" type="numeric">
	</cffunction>

	<cffunction name="getAllPeopleRegistered">
		<cfset registeredPeople = model("Conferenceperson").findAllPeopleRegistered()>
		<cfdump var="#registeredPeople#"><cfabort>
	</cffunction>

</cfcomponent>
