<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset table("equip_registrations")>
		<cfset belongsTo(name="person", modelName="Conferenceperson", foreignKey="equip_peopleid")>
		<cfset belongsTo(name="option", modelName="Conferenceoption", foreignKey="equip_optionsid")>
		<cfset belongsTo(name="invoice", modelName="Conferenceinvoice", foreignKey="equip_invoicesid")>
		<cfset belongsTo(name="workshop", modelName="Conferencecourse", foreignKey="equip_coursesid")>
		<cfset belongsTo(name="course", modelName="Conferencecourse", foreignKey="equip_coursesid")>
	</cffunction>

	<cffunction name="deleteByInvoiceId">
	<cfargument name="invoiceid" required="yes" type="numeric">
		<cfquery datasource="fgbc_main_3">
			SELECT from equip_registrations
			WHERE equip_invoiceid = #arguments.invoiceid#
		</cfquery>
	</cffunction>

	<cffunction name="allhandbookpeople">
		<cfquery datasource="fgbc_main_3" name="people">
			SELECT *, concat(lname,", ",fname," of ",city) as fullname
			FROM handbookpeople p
			JOIN handbookstates s
				ON p.stateid = s.id
			JOIN handbookpositions h
				ON h.personid = p.id
			WHERE p.deletedAt IS NULL
			AND h.deletedAt IS NULL
			AND p_sortorder <= 500
			ORDER BY lname, fname, city
		</cfquery>
		<cfreturn people>
	</cffunction>

	<cffunction name="connecthandbookpeople">
	<cfargument name="pastorsonly" default="false">
		<cfquery datasource="fgbc_main_3" name="people" cachedWithin="#CreateTimeSpan(0, 0, 3, 0)#" result="queryresult">
			SELECT p.id, p.lname, concat(p.lname,", ",p.fname," of ",p.city) as fullname, h.position, p.email, p.phone
			FROM handbookpeople p
			JOIN handbookpositions h
				ON p.id = h.personid
			WHERE p.deletedAt IS NULL
			AND h.deletedAt IS NULL
			AND h.p_sortorder <= 500
			<cfif arguments.pastorsonly>
			AND h.position like "%pastor%"
			</cfif>
			ORDER BY p.lname, p.fname, p.city
		</cfquery>
		<cfreturn people>
	</cffunction>

	<cffunction name="setHandbookPersonId">
	<cfargument name="regPersonId" required="true" type="numeric">
	<cfargument name="handbookPersonId" required="true" type="numeric">
		<cfquery datasource="fgbc_main_3">
			UPDATE equip_people
			SET handbookpersonid = #arguments.handbookPersonId#
			WHERE id = #arguments.regPersonId#
		</cfquery>
		<cfreturn true>
	</cffunction>

	<cffunction name="findPeopleToConnect">
	<cfargument name="params" required="true" type="struct">

		<cfset wherestring="event='#arguments.params.key#' AND equip_people.type='adult'">
		<cfset selectString = "concat(lname,', ',fname) as fullname, equip_peopleid, handbookpersonid, equip_people.type, lname">
		<cfset orderString = "lname, fname, equip_peopleid">

		<cfif isDefined("params.personid")>
			<cfset whereString = whereString & " AND equip_peopleid = #arguments.params.personid#">
		</cfif>

		<cfset registrations = model("Conferenceregistration").findAll(select=selectString, where=whereString, include="person(family),option", order=orderString, page=params.page, perPage=params.perpage)>

		<cfreturn registrations>
	</cffunction>

	<cffunction name="findPersonsRegs">
	<cfargument name="handbookpersonid" required="true" type="numeric">
		<cfset regs = findAll(where="handbookpersonid = #arguments.handbookpersonid#", include="person(family),option")>
		<cfreturn regs>
	</cffunction>

	<cffunction name="countRegs">
	<cfargument name="id" required="true" type="numeric">
	<cfargument name="params" required="true" type="struct">
	<cfargument name="includeAll" required="false">
	<cfset var loc=structNew()>
	<cfset loc = arguments>

	<cfset loc.includestring = "Person(Family,Age_ranges),Option,Invoice">

	<!---Start building wherestring--->
	<cfset loc.whereString = "equip_optionsid = #arguments.id#">
	<!---If a date is in params.key use that date or else use a date based on the conference year--->
	<cfif isDefined("arguments.params.key")>
		<cfset loc.whereString = loc.whereString & " AND equip_registrations.createdAt < '#$getOptionsDateYearsAgo(loc.id,arguments.params.key)#'">
	<cfelse>
		<cfset loc.whereString = loc.whereString & " AND equip_registrations.createdAt < '#$getOptionsDateYearsAgo(loc.id)#'">
	</cfif>

	<!---If params.key calls includeAll, include unpaid (ie: Comp) regs otherwise only include paid regs--->
	<cfif !isDefined("arguments.params.includeAll")>
		<cfset loc.whereString = loc.whereString & " AND (ccstatus = '1' OR ccstatus like '%paid%' OR ccstatus like '%comp%')">
	</cfif>

		<cfset loc.regs = findAll(where=loc.whereString, include=loc.includestring, order="EQUIP_OPTIONSID")>

		<cfset loc.count = 0>
		<cfloop query="loc.regs">
			<cfset loc.count = loc.count + quantity>
		</cfloop>

	<cfreturn loc.count>
	</cffunction>

	<cffunction name="countStaffRegs">
	<cfargument name="event" default="#getEvent()#">
	<cfset var loc = arguments>
		<cfset loc.registrations= findAll(where="type='Registration-Staff' AND event='#loc.event#'", include="option")>
		<cfreturn '#loc.registrations.recordcount#'>	
	</cffunction>

	<cffunction name="countRegsByType">
	<cfargument name="event" default="#getEvent()#">
	<cfargument name="type" default="All">
	<cfargument name="ccstatus" default="1">
	<cfargument name="includeFree" default="false">
	<cfargument name="regByDate" default=#now()#>
	<cfset var loc = arguments>
		<cfset loc.ccstatus = convertCCStatus(loc.ccstatus)>
		<cfset loc.whereStringAdd = "AND event='#loc.event#' AND ccstatus IN (#loc.ccstatus#) AND equip_registrations.createdAt < '#loc.regByDate#'">
		<cfset loc.whereString = "type IN '#loc.type#' " & loc.whereStringAdd>
		<cfif loc.type is "All">
			<cfset loc.whereString = "type LIKE '%Registration%' " & loc.whereStringAdd>
		</cfif>
		<cfif loc.type is "Couple">
			<cfset loc.whereString = "type LIKE '%Couple%' " & loc.whereStringAdd>
		</cfif>
		<cfif loc.type is "Single">
			<cfset loc.whereString = "type LIKE '%SIngle%' " & loc.whereStringAdd>
		</cfif>
		<cfif !loc.includeFree>
			<cfset loc.whereString = loc.wherestring & " AND cost <> 0">
		</cfif>
		<cfset loc.registrations= findAll(where=loc.whereString, include="option,invoice")>
		<cfset loc.return = quantityOfRegs(loc.registrations)>
		<!--- <cfthrow object=#serialize(loc.return)#> --->
		<cfreturn '#loc.return#'>	
	</cffunction>

	<cffunction name="quantityOfRegs">
	<cfargument name="registrations" type="query" required="true">
	<cfset var loc = arguments>
	<cfset loc.count = 0>
	<cfloop from="1" to="#loc.registrations.recordcount#" index=loc.i>
		<cfset loc.count = loc.count + loc.registrations.quantity[loc.i]>		
	</cfloop>
	<cfreturn loc.count>
	</cffunction>

	<cffunction name="countPeopleRegistered">
	<cfset var loc = structNew()>
		<cfset loc.regs = countRegsByType(ccstatus="all")>
		<cfset loc.coupleregs = countRegsByType(type="Couple",ccstatus="all")>
		<cfset loc.return = loc.regs + loc.coupleregs>
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="convertCCStatus">
	<cfargument name="ccStatus" required="true" type="string">
	<cfset var loc = arguments>
	<cfset loc.return = "">
	<cfif loc.ccstatus is "1">
		<cfset loc.return = "'1','paid'">
	</cfif>	
	<cfif loc.ccstatus is "0">
		<cfset loc.return = "0">
	</cfif>	
	<cfif loc.ccstatus is "All">
		<cfset loc.return = "'1','paid','comp','temp'">
	</cfif>	
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="countRegsForAllTypes">
	<cfset var return = "">
	<cfset return = countRegsByType(type="Registration-single")>

	</cffunction>


<!---I take an option id and return a date when that option was active on a specific month/day--->
	<cffunction name="$getOptionsDateYearsAgo">
	<cfargument name="id" required="true" type="numeric">
	<cfargument name="todayDate" default="#now()#">
	<cfset var loc="structNew()">
		<cfset loc = arguments>
		<!---Get the event connected with the optionId--->
			<cfset loc.event = $getOptionEvent(loc.id)>
		<!---Get the year of the event--->
			<cfset loc.OptionsDateYearAgo = $getDateYearsAgo(loc.event)>

	<!---Return the month/day during the year of that event--->
	<cfreturn $changeDateYear(loc.OptionsDateYearAgo,loc.todayDate)>

	</cffunction>

<!---I get the event name of a specific event option--->
	<cffunction name="$getOptionEvent">
	<cfargument name="id" required="true" type="numeric">
	<cfset var loc="structNew()">
	<cfset loc = arguments>
		<cfset loc.event=model("Conferenceoption").findOne(where="id=#loc.id#").event>
		<cfreturn loc.event>
	</cffunction>

<!---I extract the year from the event name--->
	<cffunction name="$getDateYearsAgo">
	<cfargument name="event" required="true" type="string">
	<cfset var loc="structNew()">
	<cfset loc = arguments>
		<cfset loc.eventYear = right(loc.event,4)>
	<cfreturn loc.eventYear>
	</cffunction>

<!---I change a date to the same day/month in another year--->
	<cffunction name="$changeDateYear">
	<cfargument name="year" required="true" type="string">
	<cfargument name="dateToConvert" default="#now()#">
	<cfset var loc="structNew()">
	<cfset loc = arguments>
		<cfset loc.day1 = datePart("d",loc.dateToConvert)>
		<cfset loc.month1 = datePart("m",loc.dateToConvert)>
		<cfif loc.month1 is 2 and loc.day1 is 29>
			<cfset loc.day1 = 28>
		</cfif>
		<cfset loc.hour1 = datePart("h",loc.dateToConvert)>
		<cfset loc.minute1 = datePart("n",loc.dateToConvert)>
		<cfset loc.second1 = datePart("s",loc.dateToConvert)>
		<cfset loc.return = createDateTime(loc.year,loc.month1,loc.day1,loc.hour1,loc.minute1,loc.second1)>
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="getAvgAgeToDate">
	<cfargument name="event" default="#getEvent()#">
	<cfargument name="todaydate" default="#now()#">
		<cfset var loc=structNew()>

		<cfset loc.includeString = "Person(Family,Age_ranges),Option,Invoice">
		<cfset loc.whereString = "event='#arguments.event#' AND equip_registrations.createdAt < '#arguments.todayDate#' AND equip_options.type = 'Registration'">

		<cfset loc.regsToDate = findAll(where=loc.whereString, include=loc.includestring)>

		<cfset loc.counter = 0>
		<cfset loc.totalage = 0>

		<cfloop query="loc.regsToDate">
			<cfset loc.counter = loc.counter + 1>
			<cfif val(agevalue)>
				<cfset loc.totalage = loc.totalage + agevalue>
			</cfif>
		</cfloop>
		<cftry>
			<cfset loc.return = round(loc.totalage/loc.counter)>
		<cfcatch>
			<cfset loc.return = "NA">
		</cfcatch>
		</cftry>
		<cfreturn loc.return>
	</cffunction>

	<cffunction name="RegsByUseridAndFBid">
	<cfargument name="auth" required="true" type="struct">
	<cfargument name="orderby" default="conferencefamilyid">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
		<cfif !StructKeyExists(loc.auth,"userid")>
			<cfset loc.auth.userid = 0>
		</cfif>
		<cfif !StructKeyExists(loc.auth,"fbid")>
			<cfset loc.auth.fbid = 0>
		</cfif>

		<cfset loc.regsByUserid = RegsByUserid(loc.auth.userid)>
		<cfset loc.regsByFBid = RegsByFBid(loc.auth.fbid)>
		<cfset loc.regs = queryAppend(loc.regsByUserid,loc.regsByFBid)>
		<cfset loc.regs = groupQuery(loc.regs,"id")>
		<cfset loc.regs = orderQuery(loc.regs,"conferencefamilyid")>
	<cfreturn loc.regs>
	</cffunction>

	<cffunction name="RegsByUserid">
	<cfargument name="userid" required="true" type="numeric">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
		<cfset regs = findAll(where="#regsByWhereString()# AND userid = #loc.userid#", include=regsByIncludeString())>
		<cfreturn regs>
	</cffunction>

	<cffunction name="RegsByFBid">
	<cfargument name="fbid" required="true" type="numeric">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
		<cfset regs = findAll(where="#regsByWhereString()# AND fbid = #loc.fbid# AND fbid <> 0", include=regsByIncludeString())>
		<cfreturn regs>
	</cffunction>

	<cffunction name="regsByIncludeString">
		<cfreturn "person(family(user)),invoice,option">
	</cffunction>

	<cffunction name="regsByWhereString">
		<cfreturn "event = '#getEvent()#'">
	</cffunction>

</cfcomponent>
