<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset useslayout('/focus/layoutadmin')>
		<cfset filters(through='checkOffice', except="whoiscoming,list,summary")>
		<cfset filters(through="setReturn", only="index,show")>
		<cfset filters(through="getRetreatRegions")>
	</cffunction>

	<!--- -registrations/index --->
	<cffunction name="index">
	<cfargument name="showHowMany" default="10">
		<cfset showsummary=true>
		<cfset message = "Listing Registrations: ">	


		<cfif isDefined("params.byLName")>
			<cfset orderby = "lname">
		<cfelse>
			<cfset orderby = "registrantid DESC">
		</cfif>

		<cfif isdefined("params.retreatid")>
			<cfset registrations = model("Focusregistration").findAll(where="showregs='yes' AND retreatid='#params.retreatid#'", include="item(retreat),registrant,invoice", order=orderby)>
			<cfset registrationCounts = model("Focusregistration").findAll(where="showregs='yes' AND retreatid='#params.retreatid#'", include="item(retreat),registrant,invoice", order="itemid DESC")>
			<cfset retreat = model("Focusretreat").findbyKey(params.retreatid)>
			<cfset reporttitle = "Listing Registrations for #retreat.regid#:">
		<cfelseif isdefined("params.retreat")>
			<cfset retreat = model("Focusretreat").findOne(where="regid='#params.retreat#'")>
			<cfset params.retreatid = retreat.id>
			<cfset registrations = model("Focusregistration").findAll(where="retreatid='#params.retreatid#'", include="item(retreat),registrant,invoice", order=orderby)>
			<cfset registrationCounts = model("Focusregistration").findAll(where="retreatid='#params.retreatid#'", include="item(retreat),registrant,invoice", order="itemid DESC")>
			<cfset reporttitle = "Listing Registrations for #retreat.regid#:">
		<cfelseif isdefined("params.search")>
			<cfset registrations = model("Focusregistration").findAll(where="showregs='yes' AND (lname='#params.search#' OR fname='#params.search#')", include="item(retreat),registrant,invoice", order=orderby)>
			<cfset reporttitle = "Listing Registrations for #params.search#:">
			<cfset showsummary = false>
		<cfelseif isdefined("params.option")>
			<cfset registrations = model("Focusregistration").findAll(where="name='#params.option#'", include="item(retreat),registrant,invoice", order=orderby)>
			<cfset registrationCounts = model("Focusregistration").findAll(where="name='#params.option#'", include="item(retreat),registrant,invoice", order="itemid DESC")>
			<cfset reporttitle = "Listing Registrations for #params.option#:">
		<cfelseif isdefined("params.optionid")>
			<cfset registrations = model("Focusregistration").findAll(where="itemid='#params.optionid#'", include="item(retreat),registrant,invoice", order=orderby)>
			<cfset registrationCounts = model("Focusregistration").findAll(where="itemid='#params.optionid#'", include="item(retreat),registrant,invoice", order="itemid DESC")>
			<cfset reporttitle = "Listing Registrations for  option ID###itemid#:">
			<cfset showsummary = true>
		<cfelseif isdefined("params.itemid")>
			<cfset registrations = model("Focusregistration").findAll(where="itemid='#params.itemid#'", include="item(retreat),registrant,invoice", order=orderby)>
			<cfset registrationCounts = model("Focusregistration").findAll(where="itemid='#params.itemid#'", include="item(retreat),registrant,invoice", order="itemid DESC")>
			<cfset reporttitle = "Listing Registrations for option ID###params.itemid#:">
			<cfset showsummary = true>
		<cfelse>
			<cfset registrations = model("Focusregistration").findAll(where="showregs='yes' AND active='yes'", include="item(retreat),registrant,invoice", order=orderby, maxrows="10")>
			<cfset registrationCounts = model("Focusregistration").findAll(where="showregs='yes' AND active='yes'", include="item(retreat),registrant,invoice", order="itemid DESC")>
			<cfset message = "Listing Registrations for the most recent #showHowMany# regs for: ">	
		</cfif>
		<cfif isDefined("params.download")>
			<cfset renderPage(action="download", layout="/layout_download")>
		</cfif>

		<cfset setreturn()>
	</cffunction>

	<cffunction name="list">
			<cfset registrations = model("Focusregistration").findAll(where="showregs='yes' AND retreatid='#params.retreatid#'", include="item(retreat),registrant,invoice", order="itemid")>
			<cfset retreat = model("Focusretreat").findByKey(params.retreatid)>
			<cfset reporttitle = "Listing Registrations for #retreat.regid#:">
	</cffunction>

	<!--- -registrations/show/key --->
	<cffunction name="show">
		<cfset setReturn()>

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
			<cfset renderPage(action="new")>
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
			<cfset renderPage(action="edit")>
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
		private function getIdFromMenuName(name){
			var retreat = model("Focusretreat").findOne(where="menuname = '#name#' AND active = 'yes'", order="startAt DESC");
			try {
				return retreat.id
			} catch (any e) {
				writeOutput("Cannot find #name#");abort
			}
		}
	</cfscript>

	<cffunction name="whoiscoming">
	<cfif isDefined("params.keyy")>
		<cfset params.key = params.keyy>
	</cfif>	

	<cftry>
		<cfset whoiscoming = model("Focusitem").findAll(where="retreatId=#params.key#", include="retreat,registration(registrant,invoice)", order="lname,fname")>
		<cfcatch>
			<cfset whoiscoming = model("Focusitem").findAll(where="menuname='#params.key#'", include="retreat,registration(registrant,invoice)", order="lname,fname")>
		</cfcatch>
	</cftry>

	<cfset retreats = model("Focusretreat").findAll(where="active='yes' and startAt > now()", order="startAt")>
		<cfset renderPage(layout="/focus/layout2")>
	</cffunction>

	<cffunction name="countRegsToDate">
		<cfargument name="retreatID" required="true">
		<cfargument name="asOf" default="#now()#">
		<cfif !isNumeric(arguments.retreatId)>
			<cfset arguments.retreatId = getIdFromRegid(arguments.retreatId)>
		</cfif>
		<cfset var regs = model("Focusregistration").findAll(where="retreatId = #arguments.retreatID#", include="item")>
		<cfset var total = 0>
		<cfloop query=regs>
			<cfset total = total + val(regCount)>
		</cfloop>
		<cfreturn total>
	</cffunction>

	<cffunction name="getIdFromRegid">
		<cfargument name="regId" required="true">
		<cfset retreat = model("focusretreat").findOne(where="regId = '#arguments.regId#'")>
		<cfreturn retreat.id>
	</cffunction>

	<cffunction name="summary">
	<cfargument name="asOf" default="#now()#">
	<cfset regs = structNew()>
	
	<cfif isDefined("params.asof")>
		<cfset asof = params.asof>
	</cfif>

		<cfset regs.central18total = countRegsToDate("central18",-0,asof)>

		<cfloop list="central17single,central17singleprivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-1,asof))>
		</cfloop>
		<cfloop list="central16single,central16singleprivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-2,asof))>
		</cfloop>
		<cfloop list="central15single,central15singleprivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-3,asof))>
		</cfloop>
		<cfloop list="central14single,central14singleprivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-4,asof))>
		</cfloop>
		<cfloop list="central13single,central13singleprivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-5,asof))>
		</cfloop>
		<cfloop list="centralsingle,centralprivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-6,asof))>
		</cfloop>

		<cfset regs.east18total = countRegsToDate("east18")>

		<!--- <cfloop list="east18single,east18singleprivate,east18Couple" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",0,asof))>
		</cfloop> --->
		<cfloop list="east17single,east17singleprivate,east17Couple" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-1,asof))>
		</cfloop>
		<cfloop list="east16single,east16singleprivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-2,asof))>
		</cfloop>
		<cfloop list="east15single,east15singleprivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-3,asof))>
		</cfloop>
		<cfloop list="east14single,east14singleprivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-4,asof))>
		</cfloop>
		<cfloop list="east13single,east13singleprivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-5,asof))>
		</cfloop>
		<cfloop list="eastsingle,eastprivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-6,asof))>
		</cfloop>

		<cfloop list="SW19Single1,SW19Single2,SW19SinglePrivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-0,asof))>
		</cfloop>
		<cfloop list="SW18SinglePrivate,SW18Single" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-1,asof))>
		</cfloop>
		<cfloop list="SW17SinglePrivate,SW17Single" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-2,asof))>
		</cfloop>
		<cfloop list="SW16SinglePrivate,SW16Single" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-3,asof))>
		</cfloop>
		<cfloop list="SW15SinglePrivate,SW15Single" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-4,asof))>
		</cfloop>
		<cfloop list="SW14Private,SW14Shared" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-5,asof))>
		</cfloop>
		<cfloop list="SWSingle,SWPrivate" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-6,asof))>
		</cfloop>


		<cfloop list="South19Single,South19Double,South19Triple" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-0,asof))>
		</cfloop>
		<cfloop list="South2018Sgl,South2018Dbl" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-1,asof))>
		</cfloop>
		<cfloop list="South2017Sgl,South2017Dbl" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-2,asof))>
		</cfloop>
		<cfloop list="South2016Sgl,South2016Dbl" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-3,asof))>
		</cfloop>
		<cfloop list="South2015Sgl,South2015Dbl" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-4,asof))>
		</cfloop>
		<cfloop list="focusSouth2014Sgl,focusSouth2014Dbl" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-5,asof))>
		</cfloop>
		<cfloop list="focusSouth2013Sgl,focusSouth2013Dbl" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-6,asof))>
		</cfloop>

		<cfloop list="FocusNW19" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-0,asof))>
		</cfloop>
		<cfloop list="FocusNW18" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-1,asof))>
		</cfloop>
		<cfloop list="FocusNW17" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-2,asof))>
		</cfloop>
		<cfloop list="FocusNW16" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-3,asof))>
		</cfloop>
		<cfloop list="FocusNW15" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-4,asof))>
		</cfloop>
		<cfloop list="FocusNW2014b" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-5,asof))>
		</cfloop>
		<cfloop list="FocusNW2014" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-6,asof))>
		</cfloop>
		<cfloop list="FocusNW" index="i">
			<cfset regs[i] = model("Focusregistration").countRegsToDate(i,dateAdd("yyyy",-7,asof))>
		</cfloop>

			<cfset regs.east12total = regs.eastsingle + regs.eastprivate>
			<cfset regs.east13total = regs.east13single + regs.east13singleprivate>
			<cfset regs.east14total = regs.east14single + regs.east14singleprivate>
			<cfset regs.east15total = regs.east15single + regs.east15singleprivate>
			<cfset regs.east16total = regs.east16single + regs.east16singleprivate>
			<cfset regs.east17total = regs.east17single + regs.east17singleprivate + regs.east17couple>>
			<!--- <cfset regs.east18total = regs.east18single + regs.east18singleprivate + regs.east18couple> --->
			
			<cfset regs.central12total = regs.centralsingle + regs.centralprivate>
			<cfset regs.central13total = regs.central13single + regs.central13singleprivate>
			<cfset regs.central14total = regs.central14single + regs.central14singleprivate>
			<cfset regs.central15total = regs.central15single + regs.central15singleprivate>
			<cfset regs.central16total = regs.central16single + regs.central16singleprivate>
			<cfset regs.central17total = regs.central17single + regs.central17singleprivate>
			<!--- <cfset regs.central18total = regs.Central18ThreePlusShare + regs.Central18NoLodging + regs.Central18TwoShare + regs.Central18PrivateNearbyHotel + regs.Central18CoupleNearbyHotel> --->

			<cfset regs.southwest13total = regs.SWSingle + regs.SWPrivate>
			<cfset regs.southwest14total = regs.SW14Shared + regs.SW14Private>
			<cfset regs.southwest15total = regs.SW15Single + regs.SW15SinglePrivate>
			<cfset regs.southwest16total = regs.SW16Single + regs.SW16SinglePrivate>
			<cfset regs.southwest17total = regs.SW17Single + regs.SW17SinglePrivate>
			<cfset regs.southwest18total = regs.SW18Single + regs.SW18SinglePrivate>
			<cfset regs.southwest19total = regs.SW19Single1 + regs.SW19Single2 + regs.SW19SinglePrivate>

			<cfset regs.south13total = regs.focusSouth2013Sgl + regs.focusSouth2013Dbl>
			<cfset regs.south14total = regs.focusSouth2014Sgl + regs.focusSouth2014Dbl>
			<cfset regs.south15total = regs.South2015Sgl + regs.South2015Dbl>
			<cfset regs.south16total = regs.South2016Sgl + regs.South2016Dbl>
			<cfset regs.south17total = regs.South2017Sgl + regs.South2017Dbl>
			<cfset regs.south18total = regs.South2018Sgl + regs.South2018Dbl>
			<cfset regs.south19total = regs.South19Single + regs.South19Double + regs.South19Triple>

			<cfset regs.northwest13total = regs.focusNW>
			<cfset regs.northwest14total = regs.FocusNW2014>
			<cfset regs.northwest14Btotal = regs.FocusNW2014b>
			<cfset regs.northwest15total = regs.FocusNW15>
			<cfset regs.northwest16total = regs.FocusNW16>
			<cfset regs.northwest17total = regs.FocusNW17>
			<cfset regs.northwest18total = regs.FocusNW18>
			<cfset regs.northwest19total = regs.FocusNW19>

	</cffunction>

</cfcomponent>
