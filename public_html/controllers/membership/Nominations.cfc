//TODO - Convert to cfscript
<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<cfset filters(through="checkIn", only="index")>
		<cfset filters(through="setreturn", only="index")>
		<cfset usesLayout("layout")>
	</cffunction>

	<cffunction name="checkIn">
		<cfif isdefined("params.checkin") and params.checkin is "fgbc">
			<cfset session.auth.nominate = 1>
		<cfelseif isdefined("params.checkout")>
			<cfset session.auth.nominate = 0>
		</cfif>
	</cffunction>

	<cffunction name="isOffice">
		<cftry>
		<cfif session.auth.nominate>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
		<cfcatch>
			<cfreturn false>
		</cfcatch>
		</cftry>
	</cffunction>

	<!--- nominations/index --->
	<cffunction name="index">
	<cfargument name="nominateYear" default="#getSetting('nominateYear')#">
		<cfif isDefined("params.year")>
			<cfset arguments.nominateYear = params.year>
		</cfif>
		<cfset nominations = model("Fgbcnomination").findAll(where="year='#arguments.nominateYear#'",
			include="district", order="region")>
	</cffunction>

	<!--- nominations/list --->
	<cffunction name="list">
	<cfif isDefined("params.year")>
		<cfset nominateYear = params.year>
	<cfelse>
		<cfset nominateYear = getSetting('nominateYear')>
	</cfif>
		<cfset nominations = model("Fgbcnomination").findAll(where="status = 'active' AND year='#nominateYear#'", include="district", order="region")>
		<cfset nominateMessage = nominateMessage(nominateYear)>
	</cffunction>

	<!--- nominations/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
    	<cfset nominations = model("Fgbcnomination").findByKey(key=params.key, include="District")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(nominations)>
	        <cfset flashInsert(error="Nominations #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<cffunction name="thankyou">

		<!--- Find the record --->
    	<cfset nominations = model("Fgbcnomination").findByKey(key=params.key, include="District")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(nominations)>
	        <cfset flashInsert(error="Nominations #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- nominations/new --->
	<cffunction name="new">
		<cfif isBefore("#year(now())#-07-01") OR isDefined("params.open") OR gotRights("office")>
			<cfset nominations = model("Fgbcnomination").new()>
			<cfset nominations.year = getSetting('nominateYear')>
			<cfset nominations.status = "Pending">
			<cfset districts = model("Handbookdistrict").findAll()>
		<cfelse>
			<cfset reDirectTo(action="closed")>
		</cfif>
	</cffunction>

	<!--- nominations/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset nominations = model("Fgbcnomination").findByKey(params.key)>
		<cfset districts = model("Handbookdistrict").findAll()>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(nominations)>
	        <cfset flashInsert(error="Nominations #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- nominations/create --->
	<cffunction name="create">
		<cfset nominations = model("Fgbcnomination").create(params.nominations)>

		<!--- Verify that the nominations creates successfully --->
		<cfif nominations.hasErrors()>
			<cfset flashInsert(error="There was an error creating the nominations.")>
			<cfset districts = model("Handbookdistrict").findAll()>
			<cfset renderView(action="new")>
		<!--- Otherwise --->
		<cfelse>
			<cfset sendNotificationToOffice(nominations.id)>
			<cfset flashInsert(success="The nominations was created successfully.")>
      <cfset redirectTo(action="thankyou", key=nominations.id)>
		</cfif>
	</cffunction>

	<!--- nominations/update --->
	<cffunction name="update">
		<cfset nominations = model("Fgbcnomination").findByKey(params.key)>

		<!--- Verify that the nominations updates successfully --->
		<cfif nominations.update(params.nominations)>
			<cfset flashInsert(success="The nominations was updated successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the nominations.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>

	<!--- nominations/delete/key --->
	<cffunction name="delete">
		<cfset nominations = model("Fgbcnomination").findByKey(params.key)>

		<!--- Verify that the nominations deletes successfully --->
		<cfif nominations.delete()>
			<cfset flashInsert(success="The nominations was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the nominations.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

<cfscript>

	public function sendNotificationToOffice(id){
		try {
			var list = getSetting('sendNominationNoticesTo')
			key = arguments.id
			nominations = model("Fgbcnomination").findByKey(key=key, include="District")
			if ( !isLocalMachine() ) { 
				sendEmail(to=list, from="charis@fgbc.org", subject="A Fellowship Council Nomination", template="send_notification_to_office.cfm")
			} catch(any e) {
				consoleLog("Something when wrong with a FC nomination notification")
			}
		}
	}

	private function nominateMessage(year){
		var nominateYear = year;
		var message = "";
		if (nominateYear is 2018) {
			message = "Why only one name from Region C? Districts have the privilege of nominating names to the Fellowship Council.  This year, only the Florida District nominated (Rich Schnieders). The Charis Fellowship nominating committee can add names but they felt that there was sufficient representation from other districts in region C.";
		}
		else {
			message = "Charis Fellowship Cooperating Districts have the privilege of nominating names to the Fellowship Council.  The Charis Fellowship nominating committee can add names if needed to complete the ballot.";
		};
		return message;
	}

	public function updateNomYearAndTerm(){

	}

</cfscript>
</cfcomponent>
