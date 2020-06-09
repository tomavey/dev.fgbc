<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout(template="/handbook/layout_agbm")>
		<cfset filters(through="getCurrentMembershipYear")>
		<cfset filters(through="gotAgbmRights", except="rss,publiclist,json,list,pastorsnotagbm")>
	</cffunction>

	<!--- -handbookagbminfos/index --->
	<cffunction name="index">
		<cfif isDefined("params.key") and params.key is "members">
			<cfset people = model("Handbookagbminfo").findAllMembers(currentMembershipYear=currentmembershipyear)>
		<cfelse>
			<cfset handbookagbminfos = model("Handbookagbminfo").findAll(include="Handbookperson(Handbookstate)")>
		</cfif>
	</cffunction>

	<cffunction name="getCurrentMembershipYear">
		<cfif isDefined ("params.year")>
			<cfset currentmembershipyear = params.year>
		<cfelse>	
			<cfset currentmembershipyear = model("Handbookperson").currentMembershipYear(params)>
		</cfif>
	</cffunction>

	<cffunction name="list">
		<cfset setReturn()>
		<cfset orderString = "lname,fname">
		<cfset showAge=false>
		<cfif isDefined("params.byage")>
			<cfset orderString = "birthdayyear #params.byage#,lname,fname">
			<cfset showAge = true>
		</cfif>
		<cfset districts=model("Handbookdistrict").findAll(where="district NOT IN ('Empty','National Ministry','Cooperating Ministry')")>
		<cfif isDefined("params.search")>
			  <cfset people = model("Handbookagbminfo").findAllMembers(search=params.search,currentMembershipYear=currentmembershipyear)>
		<cfelseif isDefined("params.type") and params.type is "members" and isDefined("params.alpha") and len(params.alpha)>
			  <cfset people = model("Handbookagbminfo").findAllMembers(alpha=params.alpha,currentMembershipYear=currentmembershipyear,orderby=orderstring)>
		<cfelseif isDefined("params.type") and params.type is "members" and isDefined("params.district") and len(params.district)>
			  <cfset people = model("Handbookagbminfo").findAllMembers(district=params.district,currentMembershipYear=currentmembershipyear)>
		<cfelseif isDefined("params.type") and params.type is "members">
			  <cfset people = model("Handbookagbminfo").findAllMembers(currentMembershipYear=currentmembershipyear)>
		<cfelseif isDefined("params.type") and (params.type is "mailinglist" or params.type is "mail")>
			  <cfset people = model("Handbookagbminfo").findAllMailingList(currentMembershipYear=currentmembershipyear)>
		<cfelse>
			  <cfset people = model("Handbookagbminfo").findAllMembers(currentMembershipYear=currentmembershipyear,orderby=orderstring)>
		</cfif>
	
	<cfscript>
		if ( isDefined("params.countMin") ) {
			people = people.filter( 
				function (el) {
				return countOfMembershipYearsPaid(personid = el.personid) >= params.countMin;
				} 
			)
		}
	</cfscript>	

		<cfif !gotRights("agbm,superadmin,agbmadmin")>
	  	<cfset people = model("Handbookagbminfo").findAllMembers(currentMembershipYear=currentmembershipyear, orderby="district", publicOnly=true)>
			<cfset renderPage(template="publicList")>
		</cfif>

		<!---Set the layout for normal, download view, or download excel--->
		<cfif isdefined("params.download")>
			<cfset renderPage(template="download", layout="/layout_naked")>
		<cfelseif isDefined("params.excel")>
			<cfset renderPage(template="download", layout="/layout_download")>
		</cfif>

	</cffunction>

<cfscript>
	function countOfMembershipYearsPaid(required number personid) {
		return model("Handbookagbminfo").countOfMembershipYearsPaid(personid)
	}

	function agbm10YearMembers(){
		var countMin = 9
		if ( isDefined("params.countMin") ) {
			countMin = params.countMin
		}
		showAge=false
		people = model("Handbookagbminfo").getAgbm10YearMembers(countmin)
		if ( isdefined("params.download") ) {
			renderPage(template="download", layout="/layout_naked")
		}
		if ( isDefined("params.excel") ) {
			renderPage(template="download", layout="/layout_download")
		}
		
	}

	function countOfMembershipYearsPaid(personId){
		return countOfMembershipYearsPaid(personId)
	}

</cfscript>

	<cffunction name="publicList">
		<cfset ministerium = model("Handbookagbminfo").findAllMembers(currentMembershipYear=currentmembershipyear, orderby="district, lname")>
	</cffunction>

	<cffunction name="handbook">
		<cfset params.all = true>
		<cfset handbookPeople = model("Handbookperson").findHandbookPeople(params)>
	</cffunction>

	<!--- -handbookagbminfos/show/key --->
	<cffunction name="show">
		<cfset setReturn()>
		<cfset payments = model("Handbookagbminfo").findAll(where="personid = #params.key#", include="Handbookperson(Handbookstate)", order="membershipfeeyear DESC")>
	</cffunction>

	<cffunction name="delinquent">
		<cfif isDefined("params.key") and val(params.key)>
		  	<cfset currentmembershipyear = params.key>
		<cfelse>
			<cfset currentmembershipyear = model("Handbookperson").currentMembershipyear(params)>
		</cfif>
		<cfset people = model("Handbookperson").findAll(order="lname, fname", include="Handbookstate")>
		<cfif isDefined("params.download")>
			<cfset renderPage(layout="/layout_download")>
		</cfif>
	</cffunction>

	<!--- -handbookagbminfos/add --->
	<cffunction name="add">
		<cfset handbookagbminfo = model("Handbookagbminfo").new()>
		<cfset handbookagbminfo.membershipfeeyear = year(now())>
		<cfset handbookagbminfo.membershipfee = 100>
		<cfset handbookagbminfo.agbmlifememberAt = model("Handbookprofile").findOne(where="personid = #params.key#").agbmlifememberAt>
		<cfif month(now()) is 6>
			<cfset defaultdate = "#year(now())#"&"-05-31">
			<cfset handbookagbminfo.paidAt = defaultdate>
		</cfif>
		<!--- <cfscript>
			throw(message=serialize(handbookagbminfo.properties()))
		</cfscript> --->
		<cfset people = model("Handbookperson").findAll(order="lname,fname", include="Handbookstate")>
		<cfset organizations = model("Handbookorganization").findAll(include="Handbookstate", order="org_city,state_mail_abbrev,name")>
		<cfset thisperson = model("Handbookperson").findOne(where="id=#params.key#", order="lname,fname", include="Handbookstate")>
		<cfset thisPersonsLastPayment = model("Handbookagbminfo").findAll(where="personid=#params.key#", order="membershipfeeyear DESC")>
		<cfset handbookagbminfo.category = thisPersonsLastPayment.category>
		<cfset handbookagbminfo.ordained = thisPersonsLastPayment.ordained>
		<cfset handbookagbminfo.licensed = thisPersonsLastPayment.licensed>
		<cfset handbookagbminfo.commissioned = thisPersonsLastPayment.commissioned>
		<cfset handbookagbminfo.commission = thisPersonsLastPayment.commission>
		<!--- <cfif isDefined("params.key") && val(params.key)>
			<cfset handbookagbminfo.personid = params.key>
		</cfif> --->
		<cfset renderPage(action="new")>
	</cffunction>

	<!--- -handbookagbminfos/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset handbookagbminfo = model("Handbookagbminfo").findByKey(params.key)>
			<cfset handbookagbminfo.agbmlifememberAt = model("Handbookprofile").findOne(where="personid = #handbookagbminfo.personid#").agbmlifememberAt>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookagbminfo)>
	        <cfset flashInsert(error="Handbookagbminfo #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

		<cfset organizations = model("Handbookorganization").findAll(include="Handbookstate", order="org_city,state_mail_abbrev,name")>

	</cffunction>

	<!--- -handbookagbminfos/create --->
	<cffunction name="create">
		<!--- <cfscript>
			throw(message=serialize(params.handbookagbminfo))
		</cfscript> --->

		<cfset handbookagbminfo = model("Handbookagbminfo").new(params.handbookagbminfo)>

		<!--- Verify that the handbookagbminfo creates successfully --->
		<cfif handbookagbminfo.save()>
			<cfif len(handbookagbminfo.agbmlifememberat)>
				<cfset makeAgbmLifeMember(handbookAgbmInfo.personId,handbookagbminfo.agbmlifememberat)>
			</cfif>
			<cfset flashInsert(success="The handbookagbminfo was created successfully.")>
			<cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbookagbminfo.")>
			<cfset renderPage(action="new")>
		</cfif>

	</cffunction>

	<!--- -handbookagbminfos/update --->
	<cffunction name="update">
		<cfset handbookagbminfo = model("Handbookagbminfo").findByKey(params.key)>
		<cfset handbookagbminfo.agbmlifememberAt = model("Handbookprofile").findOne(where="personid = #handbookagbminfo.personid#").agbmlifememberAt>
		<!--- <cfscript>
			throw(message=serialize(handbookagbminfo.properties()))
		</cfscript> --->
		<!--- Verify that the handbookagbminfo updates successfully --->
		<cfif handbookagbminfo.update(params.handbookagbminfo)>
			<cfif len(handbookagbminfo.agbmlifememberat)>
				<cfset makeAgbmLifeMember(handbookAgbmInfo.personId,handbookagbminfo.agbmlifememberat)>
			</cfif>
			<cfset flashInsert(success="The handbookagbminfo was updated successfully.")>
			<cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbookagbminfo.")>
			<cfset renderPage(action="edit")>
		</cfif>

	</cffunction>

	<!--- -handbookagbminfos/delete/key --->
	<cffunction name="delete">
		<cfset handbookagbminfo = model("Handbookagbminfo").findByKey(params.key)>

		<!--- Verify that the handbookagbminfo deletes successfully --->
		<cfif handbookagbminfo.delete()>
			<cfset flashInsert(success="The handbookagbminfo was deleted successfully.")>
		            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbookagbminfo.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="getLastPayment">
	<cfargument name="personid" required="true" type="numeric">
	<cfargument name="formatted" default="true">
	<cfset var loc=structNew()>

	<cfset loc.currentMembershipYear = model("Handbookperson").currentMembershipYear(params)>

	<cfset loc.fontcolor = "black">

		<cfset loc.lastPayment = model("Handbookagbminfo").findAll(where="personid = #arguments.personid#", order="membershipfeeyear DESC")>

		<cfif loc.lastPayment.recordcount>

		<cfif loc.lastPayment.membershipfeeyear NEQ loc.currentMembershipYear>
			  <cfset loc.fontcolor = "red">
		</cfif>

		<cfif loc.lastPayment.category EQ 1>
			  <cfset loc.check = loc.lastpayment.licensed + loc.lastpayment.ordained + loc.lastpayment.commissioned>
			  <cfif !loc.check>
			  		<cfset loc.fontcolor = "red">
			  </cfif>
		</cfif>

			<cfsavecontent variable="loc.return">
					<cfoutput>
						<cfif arguments.formatted>
							<cfif len(agbmlifememberAt)>
								Lifetime member since #agbmlifememberAt#
							<cfelse>	
								<p style="color:#loc.fontcolor#">
									#dollarFormat(loc.lastPayment.membershipfee)# for #loc.lastPayment.membershipfeeyear#<br/>
										<cfif loc.lastPayment.commissioned>
											Commissioned #loc.lastpayment.commission#
										<cfelse>
											<cfif loc.lastPayment.category>
												Cat. #loc.lastPayment.category#; 
											</cfif>
											<cfif loc.lastPayment.ordained>
												Ordained
											<cfelseif loc.lastpayment.licensed>
												; Licensed
											</cfif>
										</cfif>
								</p>
							</cfif>
						<cfelse>
								#dollarFormat(loc.lastPayment.membershipfee)# for #loc.lastPayment.membershipfeeyear#
								<cfif loc.lastPayment.commissioned>
									Commissioned #loc.lastpayment.commission#
								<cfelse>	
									Cat. #loc.lastPayment.category#<cfif loc.lastPayment.ordained>; Ordained<cfelseif loc.lastpayment.licensed>; Licensed</cfif>
								</cfif>
						</cfif>
					</cfoutput>
			</cfsavecontent>

		<cfelse>
			<cfset loc.return = "na">
		</cfif>

	<cfreturn loc.return>
	</cffunction>

	<cffunction name="getPayments">
	<cfargument name="personid" required="true" type="numeric">
	<cfset var loc=structNew()>
		<cfset loc.Payments = model("Handbookagbminfo").findAll(where="personid = #arguments.personid#", order="membershipfeeyear DESC")>

		<cfif loc.Payments.recordcount>
			<cfsavecontent variable="loc.return">
					<cfoutput query="loc.payments">
						<cfif len(agbmlifememberAt)>
							<p>Lifetime member since #agbmlifememberAt#</p>
						</cfif>
						<p>#dollarFormat(loc.Payments.membershipfee)# for #loc.Payments.membershipfeeyear#<br/>
						Cat. #loc.Payments.category#<cfif loc.Payments.ordained>; Ordained<cfelseif loc.Payments.licensed>; Licensed</cfif></p>
					</cfoutput>
			</cfsavecontent>
		<cfelse>
			<cfset loc.return = "na">
		</cfif>

	<cfreturn loc.return>
	</cffunction>

	<cffunction name="getAGBMMailList">
	<cfargument name="orderby" default="lname,fname">
	<cfset var loc=structNew()>
		<cfset mailListAgbmPeople = model("Handbookperson").findAll(where="grouptypeid = 16", include="Handbookgroup,Handbookstate", order=arguments.orderby, maxrows="5")>
		<cfdump var="#mailListAgbmPeople#"><cfabort>
	</cffunction>

	<cffunction name="pastorsNotAgbm">
	<cfif isDefined("params.type") AND params.type is "seniorpastors">
		  <cfset wherestring = "p_sortorder = 1 AND position LIKE '%pastor%' AND ">
	<cfelseif isDefined("params.type") AND params.type is "staffpastors">
		  <cfset wherestring = "p_sortorder > 1 AND position LIKE '%pastor%' AND ">
	<cfelseif isDefined("params.type") AND params.type is "allpastors">
		  <cfset wherestring = "position LIKE '%pastor%' AND ">
	<cfelse>
		  <cfset wherestring = "p_sortorder < 500 AND ">
	</cfif>

		<cfset wherestring = wherestring & "statusid in (1,8,3,4,2,9) AND fnamegender = 'M' AND id <> 1">
		<cfset srPastors = model("Handbookperson").findAll(
			where=wherestring,
			include="Handbookstate,Handbookpositions(Handbookorganization)", order="lname,fname")>

		<cfif isDefined("params.download")>
			 <cfset renderPage(layout="/layout_download")>
		</cfif>

	</cffunction>

	<cffunction name="setyear">
		<cfset session.agbm.currentmembershipyear = params.key>
		<cfset returnBack()>
	</cffunction>

	<cffunction name="dashboard">
	<cfset var loc=structNew()>
	<cfset loc.currentMembershipYear = model("Handbookperson").currentMembershipYear(params)>
	<cfset params.currentmembershipyear = loc.currentMembershipYear>
		  <cfset dataThisYear = model("Handbookperson").getAGBMDashboardInfo(params)>
			<cfset dataThisYear.Year = params.currentMembershipYear>
	<cfset params.currentmembershipyear = loc.currentMembershipYear - 1>
		  <cfset dataPreviousYear = model("Handbookperson").getAGBMDashboardInfo(params)>
		  <cfset dataPreviousYear.Year = params.currentMembershipYear>
	<cfset params.currentmembershipyear = loc.currentMembershipYear - 2>
		  <cfset dataPreviousPreviousYear = model("Handbookperson").getAGBMDashboardInfo(params)>
		  <cfset dataPreviousPreviousYear.Year = params.currentMembershipYear>
	</cffunction>

	<cffunction name="rss">
		<cfif application.wheels.environment is not "production">
			<cfset set(environment="production")>
		</cfif>
		<cfset ministerium = model("Handbookagbminfo").findAllMembers(currentMembershipYear=currentmembershipyear, orderby="district,lname,fname")>
		<cfset renderPage(layout="rsslayout")>
	</cffunction>

	<cffunction name="json">
		<cfset data = model("Handbookagbminfo").Handbookagbminfoasjson(publicOnly=true)>
		<cfset renderPage(layout="/layout_json", template="json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="handbookMembershipReport">

		<cfset setreturn()>

		<cfset currentMembershipYear = model("Handbookperson").currentMembershipYear(params)>

		<cfset cat1Ordained = model("Handbookperson").findAllAgbmByCat(params,'cat1Ordained').people>

		<cfset cat0Ordained = model("Handbookperson").findAllAgbmByCat(params,'Cat0Ordained').people>

		<cfset cat1Licensed = model("Handbookperson").findAllAgbmByCat(params,'cat1Licensed').people>

		<cfset cat0Commissioned = model("Handbookperson").findAllAgbmByCat(params,'Cat0Commissioned').people>

		<cfset cat1Mentored = model("Handbookperson").findAllAgbmByCat(params,'cat1Mentored').people>

		<cfset cat2Ordained = model("Handbookperson").findAllAgbmByCat(params,'cat2Ordained').people>

		<cfset cat2Licensed = model("Handbookperson").findAllAgbmByCat(params,'Cat2Licensed').people>

		<cfset cat2Mentored = model("Handbookperson").findAllAgbmByCat(params,'Cat2Mentored').people>

		<cfset cat3 = model("Handbookperson").findAllAgbmByCat(params,'Cat3').people>

		<cfif isDefined("params.plain")>
			 <cfset renderPage(layout="/layout_naked")>
		</cfif>

	</cffunction>



	<cffunction name="getPositionForHandbookReport">
	<cfargument name="personid" required="true" type="numeric">
	<cfset var loc = arguments>
	<cfset loc.whereString = "id=#loc.personid#">
	<cfset loc.includeString = "Handbookpositions(Handbookpositiontype,Handbookorganization(State,Handbookstatus))">
	<cfset loc.selectString = "name,statusid,status,handbookpositions.position as position,org_city,handbookstates.state_abbrev as state">

		<cfset loc.whereString1 = loc.whereString & " AND status = 'AGBM Only'">
		<cfset loc.positions1 = model("Handbookperson").findAll(select=loc.selectString, where=loc.whereString1, include=loc.includeString)>
		<cfif loc.positions1.recordcount>
			<cfset loc.return = gbcit(trim(loc.positions1.name)) & "; " & unrepeatcity(loc.positions1.org_city,loc.positions1.name) & " " & loc.positions1.state>
			<cfreturn loc.return>
		</cfif>


		<cfset loc.whereString2 = loc.whereString & " AND status = 'Member'">
		<cfset loc.positions2 = model("Handbookperson").findAll(select=loc.selectString, where=loc.whereString2, include=loc.includeString)>
		<cfif loc.positions2.recordcount>
			<cfset loc.return = gbcit(loc.positions2.name) & "; " & unrepeatcity(loc.positions2.org_city,loc.positions2.name) & " " & loc.positions2.state>
			<cfreturn loc.return>
		</cfif>


		<cfset loc.whereString3 = loc.whereString & " AND status = 'Member (co-member)'">
		<cfset loc.positions3 = model("Handbookperson").findAll(select=loc.selectString, where=loc.whereString3, include=loc.includeString)>
		<cfif loc.positions3.recordcount>
			<cfset loc.return = gbcit(trim(loc.positions3.name)) & "; " & unrepeatcity(loc.positions3.org_city,loc.positions3.name) & " " & loc.positions3.state>
			<cfreturn loc.return>
		</cfif>

		<cfreturn "AGBM Member">

	</cffunction>

	<cffunction name="gbcIt">
	<cfargument name="churchname" required="true" type="string">
	<cfset var loc=structNew()>
	<cfset loc.return = replace(arguments.churchname,"Grace Brethren Church","GBC","all")>
	<cfreturn trim(loc.return)>
	</cffunction>

	<cffunction name="unRepeatCity">
	<cfargument name="city" required="true" type="string">
	<cfargument name="name" required="true" type="string">
	<cfset var loc=structNew()>
	<cfset loc.return = arguments.city & ",">
	<cfif find(city,name)>
		<cfset loc.return = "">
	</cfif>
	<cfreturn trim(loc.return)>
	</cffunction>

	<cffunction name="testget">
	<cfargument name="personid" default="233">
	<cfset var loc=arguments>
	<cfif isDefined("params.personid")>
		<cfset loc.personid = params.personid>
	</cfif>
	<cfif isDefined("params.key")>
		<cfset loc.personid = params.key>
	</cfif>

		<cfdump var="#getPositionForHandbookReport(loc.personid)#"><cfabort>
	</cffunction>

	<cffunction name="paidLastYearNotThisYear" access="private">
	<cfargument name="personid" required="true" type="numeric">
	<cfargument name="currentMembershipyear" required="true" type="string">
	<cfset var loc=structNew()>
	<cfset loc.currentmembershipyear = arguments.currentMembershipyear>

	<cfset loc.return = false>
	<cfset loc.lastyear = loc.currentmembershipyear-1>
	<cfset loc.thisyear = loc.currentmembershipyear>

		<cfset loc.lastYearsPayment = model("Handbookagbminfo").findOne(where="personid = #arguments.personid# AND membershipfeeyear = '#loc.lastyear#'")>
		<cfif isObject(loc.lastYearsPayment)>
			<cfset loc.thisYearsPayment = model("Handbookagbminfo").findOne(where="personid = #arguments.personid# AND membershipfeeyear = '#loc.thisyear#'")>
			<cfif NOT isObject(loc.thisYearsPayment)>
				<cfset loc.return = true>
			</cfif>
		</cfif>
	<cfreturn loc.return>
	</cffunction>
	

<cfscript>

	public function makeAgbmLifeMember(personid, year) {
		var person = model("Handbookprofiles").findOne(where="personid=#personid#")
		person.agbmlifememberAt = "#year#"
		person.update()
	}

	public function isAgbmLifeMember(personid) {
		return model("Handbookagbminfo").isAgbmLifeMember(personid)
	}

	public function listNew(orderby="district"){
		var loc = arguments;
		if (isDefined("params.orderby")){loc.orderby = params.orderby};
		if (isDefined("params.refresh")){loc.refresh = params.refresh};
		agbmMembers = model("Handbookagbminfo").getAgbmMembers(argumentcollection=loc);
		districts=model("Handbookdistrict").findAll(where="district NOT IN ('Empty','National Ministry','Cooperating Ministry')");
	}

	public function testMembershipFeeInfo(){
		writedump(model("Handbookagbminfo").$getMembershipFeeInfo(1973));abort;
	}

	public function testIsAgbmMember(){
		var return = model("Handbookagbminfo").isAgbmMember(params.personid);
		writeDump(return);abort;
	}

	private function countOfMembershipYearsPaidSince(){
		if ( !isDefined('params.year') ) { params.year = year(now()) }
		if ( !isDefined('params.span') ) { params.span = 10 }
		if ( !isDefined('params.personid') ) { throw(message="personid is required") }
		var args = {
			asOfMembershipFeeYear: params.year, 
			personid: params.personid, 
			yearSpan: params.span
		}
		var test = model("Handbookagbminfo").CountOfMembershipYearsPaid(argumentCollection = args)
		return test
		throw(message=test)
	}

	public function getDistrictName(id){
		var district = model("Handbookdistrict").findOne(where="districtid=#id#");
		if (isObject(district)) { 
			return district.district;
		}
		return "NA";
	}

</cfscript>

</cfcomponent>
