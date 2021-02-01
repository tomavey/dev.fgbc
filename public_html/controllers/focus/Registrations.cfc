//TODO - Convert to cfscript
<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<cfset useslayout('/focus/layoutadmin')>
		<cfset filters(through='checkOffice', except="whoiscoming,list,summary,index,regFox")>
		<cfset filters(through="setReturn", only="index,show")>
		<cfset filters(through="getRetreatRegions")>
	</cffunction>

<cfscript>
	//  -registrations/index 

	function index(showHowMany="10") {
		showsummary=true;
		message = "Listing Registrations: ";

		if ( isDefined("params.byLName") ) {
			var orderby = "lname";
		}
		elseif ( isDefined("params.download") ) {
			var orderby = "lname,fname"
		} else {
			var orderby = "registrantid DESC";
		}

		if ( isDefined("params.menuname") ) {
			params.retreatid = getIdFromMenuName(params.menuname);
		}
		var whereString = ""
		var includeString = "item(retreat),registrant,invoice";

		if ( isDefined("params.showCancelled") ) {
			whereString = "cancelledAt IS NOT NULL";
			retreat = model("Focusretreat").findbyKey(params.retreatid);
			reportTitle = "Listing All Cancelled Registrations";
		} else if ( isdefined("params.retreatid") ) {
			whereString = "showregs='yes' AND retreatid='#params.retreatid#' AND cancelledAt IS NULL";
			retreat = model("Focusretreat").findbyKey(params.retreatid);
			reportTitle = "Listing Registrations for #retreat.regid#:";
		} else if ( isdefined("params.retreat") ) {
			whereString="retreatid='#params.retreatid#' AND cancelledAt IS NULL";
			retreat = model("Focusretreat").findOne(where="regid='#params.retreat#'");
			params.retreatid = retreat.id;
			reportTitle = "Listing Registrations for #retreat.regid#:";
		} else if ( isdefined("params.search") ) {
			whereString="(lname='#params.search#' OR fname='#params.search#' OR email like '%#params.search#%')";
			orderby = "createdAt DESC"
			showsummary = false;
		} else if ( isdefined("params.option") ) {
			whereString = "name='#params.option#' AND cancelledAt IS NULL";
			reportTitle = "Listing Registrations for #params.option#:";
		} else if ( isdefined("params.optionid") ) {
			whereString="itemid='#params.optionid#' AND cancelledAt IS NULL";
			reportTitle = "Listing Registrations for  option ID###params.optionid#:";
			showsummary = true;
		} else if ( isdefined("params.itemid") ) {
			whereString = "itemid='#params.itemid#' AND cancelledAt IS NULL";
			item = model("Focusitem").findOne(where="id=#params.itemid#")
			reportTitle = "Listing Registrations for option #item.description#: ";
			showsummary = true;
		}
			else {
			whereString = "showregs='yes' AND active='yes' AND cancelledAt IS NULL";
			reportTitle = "Listing Registrations for the most recent #showHowMany# focus retreat regs: ";
		}

		registrations = model("Focusregistration").findAll(where=whereString, include=includeString, order=orderby);
		registrationCounts = model("Focusregistration").findAll(where=whereString, include=includeString, order="itemid DESC");

		if ( isDefined("params.download") ) {
			renderView(action="download", layout="/layout_download");
		}
	}

</cfscript>

	<cffunction name="list">
		<!---lists registrations for a specific retreat by option--->	
		<cfset registrations = model("Focusregistration").findAll(where="showregs='yes' AND retreatid='#params.retreatid#'", include="item(retreat),registrant,invoice", order="itemid")>
		<cfset retreat = model("Focusretreat").findByKey(params.retreatid)>
		<cfset reporttitle = "Listing Registrations by option for #retreat.regid#:">
	</cffunction>

	<!--- -registrations/show/key --->
	<cffunction name="show">
		<!--- Find the record --->
    	<cfset registration = model("Focusregistration").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(registration)>
	        <cfset flashInsert(error="Registration #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<cffunction name="addTo">
		<cfset registration = model('Focusregistration').new()>
		<cfset registrant = model("Focusregistrant").findAll(where="id=#params.key#", include="registrations(item(retreat),invoice)")>
		<cfset registration.registrantid = registrant.id>
		<cfset registration.invoiceid = registrant.invoiceid>
		<cfset invoice = model("Focusinvoice").findbykey(registration.invoiceid)>
		<cfset items = model("Focusitem").findAll(where="retreatid = #registrant.retreatid#")>
	</cffunction>

	<cffunction name="add">
		<cfset thisitem = model("Focusitem").findByKey(params.registration.itemid)>
		<cfset params.registration.cost = thisitem.price>
		<cfset params.registration.quantity = 1>

		<cfset thisreg = model("Focusregistration").new(params.registration)>
		<cfset test = thisreg.save()>
		<cfset returnBack()>
	</cffunction>

	<cffunction name="getCount">
	<cfargument name="itemid" required="true" type="numeric">
		<cfset var count = model("Focusregistration").count(where="itemid = #arguments.itemid#")>
		<cfreturn count>
	</cffunction>

	<!--- -registrations/new --->
	<cffunction name="new">
		<cfset registration = model("Focusregistration").new()>
	</cffunction>

	<!--- -registrations/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset registration = model("Focusregistration").findByKey(params.key)>

		<!---Get info for selects--->
		<cfset registrants = model("Focusregistrant").findall(order="lname,fname")>
		<cfset items = model("Focusitem").findall(order="id DESC")>

		<cfset invoices = model("Focusinvoice").findall(order="id DESC")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(registration)>
	        <cfset flashInsert(error="Registration #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- -registrations/create --->
	<cffunction name="create">
		<cfset registration = model("Focusregistration").new(params.registration)>

		<!--- Verify that the registration creates successfully --->
		<cfif registration.save()>
			<cfset flashInsert(success="The registration was created successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the registration.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>

	<!--- -registrations/update --->
	<cffunction name="update">
		<cfset registration = model("Focusregistration").findByKey(params.key)>

		<!--- Verify that the registration updates successfully --->
		<cfif registration.update(params.registration)>
			<cfset flashInsert(success="The registration was updated successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the registration.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>

	<!--- -registrations/delete/key --->
	<cffunction name="delete">
		<cfset registration = model("Focusregistration").findByKey(params.key)>

		<!--- Verify that the registration deletes successfully --->
		<cfif registration.delete()>
			<cfset flashInsert(success="The registration was deleted successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the registration.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

<cfscript>

	public function cancelReg(registrantId = params.registrantId){
		var canceledRegs = model("Focusregistration").findAll(where="registrantId=#arguments.registrantId#")
		for (canceledReg in canceledRegs) {
			var thisReg = model("Focusregistration").findOne(where="id=#canceledReg.id#")
			thisReg.cancelledAt = now()
			thisReg.update()
		}		
		returnBack()
	}

	public function unCancelReg(registrantId = params.registrantId){
		var canceledRegs = model("Focusregistration").findAll(where="registrantId=#arguments.registrantId#")
		for (canceledReg in canceledRegs) {
			var thisReg = model("Focusregistration").findOne(where="id=#canceledReg.id#")
			thisReg.cancelledAt = ""
			thisReg.update()
		}		
		returnBack()
	}

</cfscript>

	<cfscript>
		private function getIdFromMenuName(name){
			var retreat = model("Focusretreat").findOne(where="menuname = '#name#' AND active = 'yes'", order="startAt DESC");
			try {
				return retreat.id
			} catch (any e) {
				writeOutput("Cannot find #name#");abort
			}
		}

		public function regfox(){
			regFoxFormName = "NoName"
			showEmail = false
			if ( isDefined("params.regfoxformname") ) {
				regFoxFormName = params.regfoxformname
			}
			if ( gotRights("office") ) {
				showEmail = true
			}
		}

	</cfscript>



	<cffunction name="whoiscoming">
		<cfif isDefined("params.keyy")>
			<cfif val(params.key)>
				<cfset params.key = params.keyy>
			<cfelse>
				<cfset params.key = getIdFromMenuName(params.keyy)>		
			</cfif>	
		<cfelse>	
			<cfset renderText("Something is not working correctly! Try again.")>
		</cfif>	

		<cftry>
			<cfset whoiscoming = model("Focusitem").findAll(where="retreatId=#params.key#", include="retreat,registration(registrant,invoice)", order="lname,fname")>
			<cfcatch>
				<cfset whoiscoming = model("Focusitem").findAll(where="menuname='#params.key#'", include="retreat,registration(registrant,invoice)", order="lname,fname")>
			</cfcatch>
		</cftry>

		<cfset retreats = model("Focusretreat").findAll(where="active='yes' and startAt > now()", order="startAt")>
		<cfset renderView(layout="/focus/layout2")>
	</cffunction>

	<cffunction name="XcountRegsToDate">
		<cfargument name="retreatID" required="true">
		<cfargument name="yearsAgo" default = 0>
		<cfargument name="asOf" default="#now()#">

		<cfif !isNumeric(arguments.retreatId)>
			<cfset arguments.retreatId = getIdFromRegid(arguments.retreatId)>
		</cfif>
		<cfset var regs = model("Focusregistration").findAll(where="retreatId = #arguments.retreatID# AND createdAt <= '#arguments.asOf#'", include="item")>
		<cfset var total = 0>
		<cfloop query=regs>
			<cfset total = total + val(regCount)>
		</cfloop>
		<cfreturn total>
	</cffunction>

	<cfscript>
		private function countRegsToDate(required retreatId, number yearsAgo = 0, asOf = '#now()#'){
			var regs = ""
			var total = 0
			var reg = ""
			asOf = dateAdd("yyyy",-yearsAgo,asOf)
			writeDump(asOf)
			if (!isNumeric(retreatId)) {
				retreatId = getIdFromRegid(retreatId)
			}
			regs = model("Focusregistration").findAll(where="retreatId = #retreatID# AND createdAt <= '#asOf#'", include="item")
			for (var reg in regs ) {
				total = total + val(reg.regCount)
			}
			return total
		}

		public function testCountRegsToDate(){
			writeDump(countRegsToDate("central18",0,"2019-08-01"));abort;
		}
	</cfscript>

	<cffunction name="getIdFromRegid">
		<cfargument name="regId" required="true">
		<cfset retreat = model("focusretreat").findOne(where="regId = '#arguments.regId#'")>
		<cfreturn retreat.id>
	</cffunction>

	<cffunction name="summary">
	<cfargument name="asOf" default="#now()#">
	<cfset var yearsago = 0>
	<cfset regs = structNew()>
	
	<cfif isDefined("params.asof")>
		<cfset asof = params.asof>
	</cfif>

	<!---Central Retreats--->

		<!---2020--->
		<cfset regs.central20total = countRegsToDate("central20",yearsAgo,asof)>

		<!---2019--->
		<cfset yearsAgo = yearsAgo + 1>
		<cfset regs.central19total = countRegsToDate("central19",yearsAgo,asof)>

		<!---2018--->
		<cfset yearsAgo = yearsAgo + 1>
		<cfset regs.central18total = countRegsToDate("central18",yearsago,asof)>


	<!---East Retreats--->

		<!---2020--->
		<cfset yearsAgo = 0>
		<cfset regs.east20total = countRegsToDate("east20",yearsAgo,asof)>

		<!---2019--->
		<cfset yearsAgo = yearsAgo + 1>
		<cfset regs.east19total = countRegsToDate("east19",yearsAgo,asof)>

		<!---2018--->
		<cfset yearsAgo = yearsAgo + 1>
		<cfset regs.east18total = countRegsToDate("east18",yearsAgo,asof)>


	<!---Southwest Retreats--->

		<!---2021--->
		<cfset yearsAgo = 0>
		<cfset regs.southwest21total = countRegsToDate("southwest21",yearsAgo,asof)>

		<!---2020--->
		<cfset yearsAgo = yearsAgo + 1>
		<cfset regs.southwest20total = countRegsToDate("southwest20",yearsAgo,asof)>

		<!---2019--->
		<cfset yearsAgo = -yearsAgo - 1>
		<cfloop list="SW19Single1,SW19Single2,SW19SinglePrivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",yearsAgo,asof))>
		</cfloop>
		<cfset regs.southwest19total = regs.SW19Single1 + regs.SW19Single2 + regs.SW19SinglePrivate>

		
	<!---South Retreats--->

		<!---2021--->
		<cfset yearsAgo = 0>
		<cfset regs.south21total = countRegsToDate("south21",yearsAgo,asof)>

		<!---2020--->
		<cfset yearsAgo = yearsAgo + 1>
		<cfset regs.south20total = countRegsToDate("south20",yearsAgo,asof)>
		
		<!---2019--->
		<cfset yearsAgo = -yearsAgo - 1>
		<cfloop list="South19Single,South19Double,South19Triple" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",yearsAgo,asof))>
		</cfloop>
		<cfset regs.south19total = regs.South19Single + regs.South19Double + regs.South19Triple>


	<!---Northwest Retreat--->	

		<!---2021--->
		<cfset yearsAgo = 0>
		<cfset regs.northwest21total = countRegsToDate("northwest21",yearsAgo,asof)>

		<!---2020--->
		<cfset yearsAgo = yearsAgo + 1>
		<cfset regs.northwest20total = countRegsToDate("northwest20",yearsAgo,asof)>

		<!---2019--->
		<cfset yearsAgo = -yearsAgo - 1>
		<cfloop list="FocusNW19" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",yearsAgo,asof))>
		</cfloop>
		<cfset regs.northwest19total = regs.FocusNW19>

	</cffunction>

</cfcomponent>
