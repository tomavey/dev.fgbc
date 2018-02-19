<cfcomponent extends="Controller" output="false">
<!---Added just in case--->

	<cffunction name="init">
		<cfset usesLayout(template="/handbook/layout_admin")>
		<cfset filters(through="isAuthorized", only="new,edit")>
		<cfset filters(through="paramsKeyRequired", only="sizeByPercent,getSummary")>
		<cfset filters(through="setReturn", only="index")>
	</cffunction>

	<cffunction name="isAuthorized">
		<cftry>
			<cfif not gotRights("superadmin,office")>
				<cfset redirectto(action="nopermission")>
				<cfabort>
			</cfif>
		<cfcatch>
				<cfset redirectto(action="nopermission")>
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="nopermission">
	</cffunction>

	<!---fgbcdelegates/getChurchId--->
	<cffunction name="getChurchid">
		<cfset churches = model("Handbookorganization").findAll(where="statusid = 1", include="Handbookstate", order="org_city,state_mail_abbrev")>
		<cfset renderPage(layout="/handbook/layout_handbook2")>
	</cffunction>

	<cffunction name="welcome">
		<cfif gotRights("superadmin,office")>
			<cfset redirectTo(action="index")>
		</cfif>

	</cffunction>

	<!--- handbook-statistics/index --->
	<cffunction name="index">
		<cfset var loc=structNew()>

		<cfif isDefined("params.year") and len(params.year)>
			<cfset statyear = params.year>
		<cfelse>
			<cfset statYear = year(now())-1>
		</cfif>

		<cfif not isdefined("params.key")>
			<cfset params.key = "year">
		</cfif>

		<cfif isdefined("params.year")>
			<cfset handbookstatistics = model("Handbookstatistic").findAll(where="year=#params.year#",include="Handbookorganization(Handbookstate)", order=params.key)>
		<cfelse>
			<cfset handbookstatistics = model("Handbookstatistic").findAll(where="year=#statYear#", include="Handbookorganization(Handbookstate)", order=params.key)>
		</cfif>

		<cfif isDefined("params.summary") and params.summary>
			<cfset renderPage(controller="handbook-statistics", action="summary")>
		</cfif>
	</cffunction>

	<!--- handbook-statistics/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
    	<cfset handbookstatistic = model("Handbookstatistic").findAll(where="organizationid=#params.key#",include="Handbookorganization(Handbookstate)",order="year DESC")>

		<cfif not GotRights("superadmin,office")>
			  <cfset renderPage(layout="/handbook/layout_handbook1")>
		</cfif>

	</cffunction>

	<!--- handbook-statistics/new --->
	<cffunction name="new">
		<cfset handbookstatistic = model("Handbookstatistic").new()>
		<cfif isdefined("params.key")>
			<cfset params.key = keyFromChurchid()>
			<cfset handbookstatistic.organizationid = params.key>
			<cfset thisorg = model("Handbookorganization").findOne(where="id=#params.key#", include="Handbookstate")>
		</cfif>
		<cfset handbookstatistic.year = year(now())-1>
		<cfset organizations = model("Handbookorganization").findall(where='statusid in (1,4)', include="Handbookstate", order="org_city,state_mail_abbrev,name")>
	</cffunction>

	<!--- handbook-statistics/submit --->
	<cffunction name="submit">
		<cfif !isdefined("params.key") && !isdefined("params.churchid")>
			  <cfset flashInsert(error="Welcome! Please select your church from this drop-down list...")>
			  <cfset redirectTo(action="getChurchid")>
		</cfif>
		<cfif isDefined("params.extendDeadline")>
			<cfset session.statistics.extendDeadLine = true>
		</cfif>
		<cfset handbookstatistic = model("Handbookstatistic").new()>
		<cfif isdefined("params.key") || isDefined("params.churchid")>
			<cfset params.key = keyFromChurchid()>
			<cfset handbookstatistic.organizationid = params.key>
			<cfset thisorg = model("Handbookorganization").findOne(where="id=#params.key#", include="Handbookstate")>
		<cfelse>
			<cfset renderText("Church not found.")>
		</cfif>
		<cfif !isDefined("params.year")>
			<cfset handbookstatistic.year = year(now())-1>
		<cfelse>
			<cfset handbookstatistic.year = params.year>
		</cfif>	
		<cfset organizations = model("Handbookorganization").findall(where='statusid = 1', include="Handbookstate", order="org_city,state_mail_abbrev,name")>
		<cfset renderPage(layout="/handbook/layout_handbook2")>
	</cffunction>

	<!--- handbook-statistics/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset handbookstatistic = model("Handbookstatistic").findByKey(params.key)>
		<cfset organizations = model("Handbookorganization").findall(include="Handbookstate", order="selectName")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookstatistic)>
	        <cfset flashInsert(error="HandbookStatistic #params.key# was not found")>
			<cfset returnBack()>
	    </cfif>

	</cffunction>

	<!--- handbook-statistics/create --->
	<cffunction name="create">
		<cfset var ii = "">

		<cftry>
		<cfloop list="att,members,memfee,members,baptisms,conversions" index="ii">
			<cfif isDefined("params.handbookstatistic[ii]") && isValid("string",params.handbookstatistic[ii])>
				<cfset params.handbookstatistic[ii] = LSParseNumber(params.handbookstatistic[ii])>	
			</cfif>
		</cfloop>
		<cfcatch></cfcatch>
		</cftry>


		<cfset handbookstatistic = model("Handbookstatistic").new(params.handbookstatistic)>
		<cfset organizations = model("Handbookorganization").findall(include="Handbookstate", order="selectName")>


		<!--- Verify that the handbookstatistic creates successfully --->
		<cfif handbookstatistic.save()>
			<cfset flashInsert(success="The handbookstatistic was created successfully.")>
			<cfif isdefined("params.pay") and params.pay>
<!---			
<cfdump var="#handbookstatistic.properties()#">
<cfdump var="#params#">
<cfabort>
--->
	            <cfset redirectTo(action="payonline", params="churchid=#params.handbookstatistic.organizationid#&year=#handbookstatistic.year#")>
			<cfelse>
	            <cfset returnBack()>
			</cfif>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbookstatistic.")>
			<cfif isdefined("params.pay") and params.pay>
				<cfset renderPage(action="submit")>
			<cfelse>
				<cfset renderPage(action="new")>
			</cfif>
		</cfif>
	</cffunction>

	<!--- handbook-statistics/update --->
	<cffunction name="update">
		<cfset handbookstatistic = model("Handbookstatistic").findByKey(params.key)>

		<cfloop list="att,members,memfee,members,baptisms,conversions" index="ii">
			<cfif isDefined("params.handbookstatistic[ii]") && isValid("string",params.handbookstatistic[ii])>
				<cftry>
				<cfset params.handbookstatistic[ii] = LSParseNumber(params.handbookstatistic[ii])>	
				<cfcatch></cfcatch></cftry>
			</cfif>
		</cfloop>

		<!--- Verify that the handbookstatistic updates successfully --->
		<cfif handbookstatistic.update(params.handbookstatistic)>
			<cfset flashInsert(success="The handbookstatistic was updated successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbookstatistic.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- handbook-statistics/delete/key --->
	<cffunction name="delete">
		<cfset handbookstatistic = model("Handbookstatistic").findByKey(params.key)>

		<!--- Verify that the handbookstatistic deletes successfully --->
		<cfif handbookstatistic.delete()>
			<cfset flashInsert(success="The handbookstatistic was deleted successfully.")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbookstatistic.")>
		</cfif>
        <cfset returnBack()>
	</cffunction>

	<cffunction name="delinquent">
		<cfset churches = model("Handbookorganization").findAll(where="statusid = 1", include="Handbookstate", order="state_mail_abbrev,org_city,name")>
		<cfif isDefined("params.download")>
			<cfset renderPage(layout="/layout_download.cfm")>
		</cfif>
	</cffunction>

	<cffunction name="howDelinquent">
	<cfargument name="churchid" required="true" type="numeric">
	<cfset var loc = structNew()>
		<cfif month(now()) LTE 7>
			<cfset loc.year = year(now()) - 1>
		<cfelse>
			<cfset loc.year = year(now())>
		</cfif>
		<cfset loc.1 = loc.year-1>
		<cfset loc.2 = loc.year-2>
		<cfset loc.3 = loc.year-3>
		<cfset loc.4 = loc.year-4>
		<cfset loc.return = "">
		<cfset loc.count = 0>

		<cfloop from="1" to="4" index="i">
			<cfif noMemFee(arguments.churchid,loc[i])>
				<cfset loc.text = loc[i]+1>
				<cfset loc.count = 1>
			<cfelse>
				<cfset loc.text = "&nbsp;">
			</cfif>
				<cfset loc.return = loc.return & "</td><td>" & loc.text>
		</cfloop>

		<cfset loc.return = replace(loc.return,"; ","","one")>

		<cfif loc.count>
			<cfreturn loc.return>
		<cfelse>
			<cfreturn false>
		</cfif>

	</cffunction>

	<cffunction name="noMemFee">
	<cfargument name="churchid" required="true" type="numeric">
	<cfargument name="year" required="true" typeq="string">
		<!---First check to see if this church joined after this date--->
		<cfset church = model("Handbookorganization").findOne(where="id=#arguments.churchid#", include="Handbookstate")>
		<cfset statistic = model("Handbookstatistic").findOne(where="organizationid = #arguments.churchid# AND year = '#arguments.year#'")>

		<cfif val(church.joinedAt) GTE arguments.year>
			<cfreturn false>
		<cfelseif isObject(statistic)>
			<cfreturn false>
		<cfelse>
			<cfreturn true>
		</cfif>

		<!---then check for a payment record for this church for this year--->
	</cffunction>

	<cffunction name="testNoMemfee">
		<cfset test = noMemFee(churchid=params.key, year=params.key)>
		<cfdump var="#test#"><cfabort>
	</cffunction>


	<cffunction name="allCurrent">
		<cfif isDefined("params.notPaid")>
			<cfset churches = allCurrentNotPaid()>
		<cfelse>		
			<cfset churches = model("Handbookorganization").findAll(where="statusid = 1", include="Handbookstate", order="state_mail_abbrev,org_city,name")>
		</cfif>	
		<cfset yearago = model("Handbookstatistic").findMemFeePaidBy()>
		<cfset twoyearsago = model("Handbookstatistic").findMemFeePaidBy('-2')>
		<cfif isDefined("params.download")>
			<cfset isDownload = true>
			<cfset renderPage(layout="/layout_download")>
		</cfif>
	</cffunction>

	<cffunction name="allCurrentNotPaid">
		<cfset var churches = model("Handbookorganization").findAll(where="statusid = 1", include="Handbookstate", order="state_mail_abbrev,org_city,name")>
		<cfset var notpaidchurches = queryNew("id,name,city,emails")>
		<cfloop query="churches">
			<cfif getFeePaid(id) is "NONE">
				<cfset queryAddRow(notpaidchurches,1)>
				<cfset querySetCell(notpaidchurches,"id",#id#)>
				<cfset querySetCell(notpaidchurches,"name",#name#)>
				<cfset querySetCell(notpaidchurches,"city",#org_city#)>
				<cfset querySetCell(notpaidchurches,"emails",#getOrgEmails(id)#)>
			</cfif>
		</cfloop>
		<cfreturn notpaidchurches>
	</cffunction>

	<cffunction name="emailAllCurrentNotPaid">
	<cfset var churches = allcurrentnotpaid()>
	<cfloop query="churches">
	<cfoutput>
		Email would be send to #emails# of #name# for #id#<br/>
	</cfoutput>
	</cfloop>
	<cfabort>
	</cffunction>

	<cffunction name="testAllCurrentNotPaid">
		<cfdump var="#allCurrentNotPaid()#"><cfabort>
	</cffunction>

	<cffunction name="getThisYear">
	<cfset var loc = structNew()>
	<cfset loc.now = now()>
	<cfset loc.year = year(now())>
	<cfif isDefined("params.year")>
		<cfset loc.year = params.year>
	</cfif>
		<cfreturn loc.year>
	</cffunction>

	<cffunction name="getFeePaid">
	<cfargument name="orgid" required="true" type="numeric">
		<cfset fee = model("Handbookstatistic").findOne(where="organizationid=#arguments.orgid# AND year = '#getThisYear()-1#'", order="createdAt DESC")>
		<cfif isObject(fee)>
			<cfif val(fee.memfee)>
				<cfreturn fee.memfee>
			<cfelse>
				<cfreturn "Memfee not paid">
			</cfif>
		<cfelse>
			<cfreturn "NONE">
		</cfif>
	</cffunction>

	<cffunction name="getFeeTotal">
	<cfargument name="rate" default="#params.rate#">
	<cfargument name="max" default="#params.max#">
	<cfargument name="year" default='#params.year#'>
	<cfset feeTotal = 0>
		<cfset stats = model("Handbookstatistic").findAll(where="year='#arguments.year#'")>
		<cfloop query = "stats">
			<cfif val(att) * arguments.rate GTE params.max>
				<cfset feeTotal = feeTotal + params.max>
			<cfelse>
				<cfset feeTotal = feeTotal + (params.rate * val(att))>
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="payonline">

		<cfset payonline = structnew()>
		<cfset payonline.merchant = "fellowshipofgracen">
		<cfset church = model("Handbookorganization").findOne(where="id=#params.churchid#", include="handbookstate", order="createdAt DESC")>
		<cfset church.name = replace(church.name," ","","all")>
		<cfset church.org_city = replace(church.org_city," ","","all")>
		<cfset payonline.orderid = createOrderId(church.properties())>
		<cfif !isDefined("params.year")>
			<cfset payonline.usethisyear = year(now())-1>
		<cfelse>
			<cfset payonline.usethisyear = params.year>
		</cfif>	
		<cfset stat = model("handbookstatistics").findOne(where="organizationid=#params.churchid# AND year = #payonline.usethisyear#", order="id DESC")>
		<cfset payonline.amount = (val(stat.att) * getOnlineMemFee())>
		<cfif payonline.amount GTE getOnlineMemFeeMax()>
			<cfset payonline.amount = getOnlineMemFeeMax()>
		</cfif>
		<cfset payonline.url = "http://#CGI.http_host#/handbook/statistics/confirm">
		<cfset renderPage(layout="/handbook/layout_handbook2")>

	</cffunction>

	<cffunction name="createOrderId">
	<cfargument name="churchinfo" required="true" type="struct">
		<cfset var ii = "">
		<cfset var orderid = ""> 
		<cfset orderid = churchinfo.id & churchinfo.name & churchinfo.org_city>
		<cftry>
			<cfloop list='-,!,_, ,",&' index='ii'>
				<cfset orderid = replace(orderid,ii,"","all")>
			</cfloop>
		<cfcatch>
			<cfset orderid = churchinfo.id & "year" & year(now())>
		</cfcatch></cftry>
		<cfif len(orderid) GTE 44>
			<cfset orderid = left(orderid,44)>
		</cfif>
		<cfset orderid = orderid & "MEMFEE">	
		<cfreturn orderid>
		<cfdump var="#orderid#"><cfabort>
	</cffunction>

	<cffunction name="confirm">
		<cfif params.status>
			<cfset church = model("Handbookorganization").findOne(where="id=#val(params.orderid)#", include="Handbookstate")>
			<cfset statistic = model("Handbookstatistic").findOne(where="organizationid=#val(params.orderid)# AND year = #year(now())-1#")>
			<cfset renderPage(layout="/handbook/layout_handbook2")>
			<cfset sendEmail(to=application.wheels.registrarEmail, from=application.wheels.registrarEmail, subject="Statistical Report", type="html", template="confirm")>
		<cfelse>
			<cfset redirectTo(action="paymentfailed")>
		</cfif>
	</cffunction>

	<cffunction name="paymentfailed">
	</cffunction>

	<cffunction name="ewpSummary">
	<cfset var ewp = structNew()>
		<cfset ewp.memberchurches = model("Handbookorganization").findAll(where="statusid =1", include="state").recordcount>
		<cfset ewp.campuses = model("Handbookorganization").findAll(where="statusid IN (8,9)", include="state").recordcount>
		<cfset ewp.campuses = model("Handbookorganization").findAll(where="statusid IN (4,2)", include="state").recordcount>
	<cfreturn ewp>
	</cffunction>


	<!---Stat Report Functions--->
	<cffunction name="getSummary">
		<cfset summary1 = model("Handbookstatistic").findStatsSummary(params.key)>
		<cfif isdefined("params.compYear")>
			<cfset summaryCompYear = model("Handbookstatistic").findStatsSummary(params.key)>
		</cfif>
		<cfif isdefined("params.compYear2")>
			<cfset summaryCompYear2 = model("Handbookstatistic").findStatsSummary(params.key)>
		</cfif>
		<cfif isdefined("params.compYear3")>
			<cfset summaryCompYear3 = model("Handbookstatistic").findStatsSummary(params.key)>
		</cfif>
		<cfif isdefined("params.compYear4")>
			<cfset summaryCompYear4 = model("Handbookstatistic").findStatsSummary(params.key)>
		</cfif>
		<cfset ewp = ewpSummary()>
	</cffunction>

	<cffunction name="thisChurchesGrowth">
	<cfargument name="churchid" required="true" type="numeric">
	<cfargument name="year1" required="true" type="string">
	<cfargument name="year2" required="true" type="string">
	<cfargument name="delta" required="true" type="numeric">
	<cfset var loc=structNew()>

	<cfset loc.year1 = model("Handbookstatistic").findOne(where="organizationid=#arguments.churchid# AND year = '#arguments.year1#'")>
	<cfif not isObject(loc.year1)>
		<cfset arguments.year1 = arguments.year1-1>
		<cfset loc.year1 = model("Handbookstatistic").findOne(where="organizationid=#arguments.churchid# AND year = '#arguments.year1#'")>
		<cfif not isObject(loc.year1)>
			<cfset arguments.year1 = arguments.year1+2>
			<cfset loc.year1 = model("Handbookstatistic").findOne(where="organizationid=#arguments.churchid# AND year = '#arguments.year1#'")>
		</cfif>
	</cfif>

	<cfset loc.year2 = model("Handbookstatistic").findOne(where="organizationid=#arguments.churchid# AND year = '#arguments.year2#'")>
	<cfif not isObject(loc.year2)>
		<cfset arguments.year2 = arguments.year2-1>
		<cfset loc.year2 = model("Handbookstatistic").findOne(where="organizationid=#arguments.churchid# AND year = '#arguments.year2#-1'")>
		<cfif not isObject(loc.year2)>
			<cfset arguments.year2 = arguments.year2+2>
			<cfset loc.year2 = model("Handbookstatistic").findOne(where="organizationid=#arguments.churchid# AND year = '#arguments.year2#-1'")>
		</cfif>
	</cfif>

	<cftry>
		<cfset loc.growth = round(((loc.year1.att - loc.year2.att)/loc.year2.att)*100)>
	<cfcatch>
		<cfset loc.growth = "na">
	</cfcatch>
	</cftry>

	<cfset loc.growthdescription = "Static">
	<cfif loc.growth GTE arguments.delta>
		<cfset loc.growthdescription = "Growing">
	</cfif>
	<cfif loc.growth LTE 0 and abs(loc.growth) GTE arguments.delta>
		<cfset loc.growthdescription = "Declining">
	</cfif>
	<cfif loc.growth is "na">
		<cfset loc.growthdescription = "Na">
	</cfif>

	<cftry>
		<cfset loc.year1att = loc.year1.att>
	<cfcatch>
		<cfset loc.year1att = "na">
	</cfcatch>
	</cftry>

	<cftry>
		<cfset loc.year2att = loc.year2.att>
	<cfcatch>
		<cfset loc.year2att = "na">
	</cfcatch>
	</cftry>

	<cfif val(loc.growth)>
		<cfset loc.growth = toString(numberformat(loc.growth,"()"))>
		<cfset loc.growth = loc.growth & '%'>
	</cfif>

	<cfset loc.return = "<td>" & loc.year1att & "</td><td>" & loc.year2att & "</td><td>" & loc.growth
		& "</td><td class=" & loc.growthdescription & ">" & loc.growthdescription & "</td>">
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="testChurchGrowth">
		<cfset test = thisChurchesGrowth(churchid=1,year1='2010',year2='2007',delta=5)>
		<cfdump var="#test#"><cfabort>
	</cffunction>

	<cffunction name="churchgrowth">
		<cfset churches = model("Handbookorganization").findAll(where="statusid = 1", include="Handbookstate", order="state,org_city")>
		<cfif isDefined("params.download")>
			<cfset renderPage(layout="/layout_download.cfm")>
		</cfif>
	</cffunction>

	<cffunction name="statHistory">
		<cfset var stattype = "att">
		<cfif isDefined("params.key")>
			<cfset stattype = params.key>
		</cfif>
		<cfset churches = model("Handbookorganization").findAll(select="id,state,state_mail_abbrev,org_city,name,selectname", where="statusid = 1", include="Handbookstate", order="state, org_city, id")>
		<cfset churchyears = model("Handbookstatistic").findAll(order="year DESC")>
		<cfset years = "">
		<cfoutput query="churchyears" group="year">
			<cfset years = years & "," & year>
		</cfoutput>
		<cfset years = replace(years,",","","one")>
		<cfloop list="#years#" index="i">
			<cfset queryAddColumn(churches,i)>
		</cfloop>
		<cfloop query="churches">
			<cfloop list="#years#" index="ii">
				<cfset thisstat = getStat(stattype,id,ii)>
				<cfset QuerySetCell(churches,ii,thisstat,churches.currentrow)>
			</cfloop>
		</cfloop>
		<cfif isDefined("params.download")>
			<cfset renderPage(layout="/layout_download.cfm")>
		</cfif>
	</cffunction>

	<cffunction name="getStat">
	<cfargument name="fieldname" required="true" type="string">
	<cfargument name="churchid" required="true" type="numeric">
	<cfargument name="year" required="true" type="string">
	<cfset var selectString = "att,ss,conversions,baptisms,members">
		<cfset stat = model("Handbookstatistics").findOne(select=selectstring, where="organizationid = #arguments.churchid# AND year = '#arguments.year#'")>
		<cfif isobject(stat)>
			<cfset thisstat = stat[fieldname]>
		<cfelse>
			<cfset thisstat = "&nbsp;">
		</cfif>
		<cfreturn thisstat>
	</cffunction>

	<cffunction name="testGetStat">
		<cfset test = getStat(churchid=891,year="2007",fieldname="att")>
		<cfdump var="#test#"><cfabort>
	</cffunction>

	<cffunction name="size">
	<cfargument name="fieldname" default="att">
	<cfargument name="xxlarge" default="1000">
	<cfargument name="xlarge" default="500">
	<cfargument name="large" default="200">
	<cfargument name="medium" default="100">
	<cfargument name="small" default="50">
	<cfargument name="xsmall" default="1">
	<cfset var loc=structnew()>
	<cfset loc.arguments = arguments>
		<cfif arguments.xxlarge>
			<cfset loc.xxlarge = model("Handbookstatistic").findAll(where="year='#params.key#' AND att BETWEEN #arguments.xxlarge# AND 100000", include="Handbookorganization(Handbookstate)", select="sum(#arguments.fieldname#) as size", order="att DESC")>
		<cfelse>
			<cfset loc.xxlarge.size = "">
		</cfif>
		<cfif arguments.xlarge>
			<cfset loc.xlarge = model("Handbookstatistic").findAll(where="year='#params.key#' AND att BETWEEN #arguments.xlarge# AND #arguments.xxlarge-1#", select="sum(#arguments.fieldname#) as size", include="Handbookorganization(Handbookstate)", order="att DESC")>
		<cfelse>
			<cfset loc.xlarge.size = "">
		</cfif>
		<cfif arguments.large>
			<cfset loc.large = model("Handbookstatistic").findAll(where="year='#params.key#' AND att BETWEEN #arguments.large# AND #arguments.xlarge-1#", select="sum(#arguments.fieldname#) as size", include="Handbookorganization(Handbookstate)", order="att DESC")>
		<cfelse>
			<cfset loc.large.size = "">
		</cfif>
		<cfif arguments.large>
			<cfset loc.medium = model("Handbookstatistic").findAll(where="year='#params.key#' AND att BETWEEN #arguments.medium# AND #arguments.large-1#", select="sum(#arguments.fieldname#) as size", include="Handbookorganization(Handbookstate)", order="att DESC")>
		<cfelse>
			<cfset loc.medium.size = "">
		</cfif>
		<cfif arguments.small>
			<cfset loc.small = model("Handbookstatistic").findAll(where="year='#params.key#' AND att BETWEEN #arguments.small# AND #arguments.medium-1#", select="sum(#arguments.fieldname#) as size", include="Handbookorganization(Handbookstate)", order="att DESC")>
		<cfelse>
			<cfset loc.small.size = "">
		</cfif>
		<cfif arguments.xsmall>
			<cfset loc.xsmall = model("Handbookstatistic").findAll(where="year='#params.key#' AND att BETWEEN #arguments.xsmall# AND #arguments.small-1#", select="sum(#arguments.fieldname#) as size", include="Handbookorganization(Handbookstate)", order="att DESC")>
		<cfelse>
			<cfset loc.xsmall.size = "">
		</cfif>
		<cfset loc.all = model("Handbookstatistic").findAll(where="year='#params.key#'", select="sum(#arguments.fieldname#) as size", include="Handbookorganization(Handbookstate)", order="att DESC")>
		<cfdump var='#loc#'><cfabort>
	</cffunction>

	<cffunction name="sizeByPercent">
	<cfargument name="fieldname" default="att">
	<cfargument name="xxlarge" default="90">
	<cfargument name="xlarge" default="80">
	<cfargument name="large" default="50">
	<cfargument name="medium" default="25">
	<cfset var loc=structNew()>

		<cfset loc.count = model("Handbookstatistic").findAll(where="year='#params.key#'", select="count(*) AS count")>

		<cfset loc.xxlarge.count = round(loc.count.count*((100-arguments.xxlarge)/100))>
		<cfset loc.xxlarge.startrow = 1>
		<cfset loc.xxlarge.maxrows = loc.xxlarge.count>
		<cfset loc.xxlarge.endrow = loc.xxlarge.startrow + loc.xxlarge.maxrows>

		<cfset loc.xlarge.count = round(loc.count.count*((100-arguments.xlarge)/100))>
		<cfset loc.xlarge.startrow = loc.xxlarge.maxrows+1>
		<cfset loc.xlarge.maxrows = loc.xlarge.count - loc.xlarge.startrow>
		<cfset loc.xlarge.endrow = loc.xlarge.startrow + loc.xlarge.maxrows>

		<cfset loc.large.count = round(loc.count.count*((100-arguments.large)/100))>
		<cfset loc.large.startrow = loc.xlarge.endrow+1>
		<cfset loc.large.maxrows = loc.large.count - loc.large.startrow>
		<cfset loc.large.endrow = loc.large.startrow + loc.large.maxrows>

		<cfset loc.medium.count = round(loc.count.count*((100-arguments.medium)/100))>
		<cfset loc.medium.startrow = loc.large.endrow+1>
		<cfset loc.medium.maxrows = loc.medium.count - loc.medium.startrow>
		<cfset loc.medium.endrow = loc.medium.startrow + loc.medium.maxrows>

		<cfset loc.small.startrow = loc.medium.endrow+1>
		<cfset loc.small.maxrows = 10000>
		<cfset loc.small.endrow = loc.small.startrow + loc.small.maxrows>

		<cfset loc.all = model("Handbookstatistic").findAll(where="year='#params.key#'", include="Handbookorganization(Handbookstate)", order="attInt DESC")>
		<cfset loc.xxlarge.total = getTotal(
							fieldname=arguments.fieldname,
							thisquery=loc.all,
							startrow=loc.xxlarge.startrow,
							maxrows=loc.xxlarge.maxrows
							)>
		<cfset loc.xlarge.total = getTotal(
							fieldname=arguments.fieldname,
							thisquery=loc.all,
							startrow=loc.xlarge.startrow,
							maxrows=loc.xlarge.maxrows
							)>
		<cfset loc.large.total = getTotal(
							fieldname=arguments.fieldname,
							thisquery=loc.all,
							startrow=loc.large.startrow,
							maxrows=loc.large.maxrows
							)>
		<cfset loc.medium.total = getTotal(
							fieldname=arguments.fieldname,
							thisquery=loc.all,
							startrow=loc.medium.startrow,
							maxrows=loc.medium.maxrows
							)>
		<cfset loc.small.total = getTotal(
							fieldname=arguments.fieldname,
							thisquery=loc.all,
							startrow=loc.small.startrow,
							maxrows=100000
							)>
		<cfset attributes = loc>
	</cffunction>

	<cffunction name="getTotal" access="private">
	<cfargument name="fieldname" required="true" type="string">
	<cfargument name="thisquery" required="true" type="query">
	<cfargument name="maxrows" required="true" type="numeric">
	<cfargument name="startrow" required="true" type="numeric">
	<cfset var loc=structNew()>
	<cfset loc.return=0>
	<cfoutput query="arguments.thisquery" startRow="#arguments.startrow#" maxRows="#arguments.maxrows#">
		<cfif val(#evaluate(arguments.fieldname)#)>
			<cfset loc.return = loc.return + val(evaluate(arguments.fieldname))>
		</cfif>

	</cfoutput>
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="closedChurches">
	<cfargument name="since" default="#createDate(year(now())-1,08,01)#">
		<cfset churches = model("Handbookupdate").findAll(where="modelname='Handbookorganization' AND columnName='statusid' AND olddata = 1 AND newdata in (3,4,5,6,7,8,9) AND createdAt > '#arguments.since#'", include="Handbookorganization(Handbookstate)")>
	</cffunction>

	<cffunction name="test">
		<cfset test=model("Handbookstatistic").findMemFeePaidBy(yearsago='-3')>
		<cfdump var="#test#"><cfabort>
	</cffunction>

	<cffunction name="alterTable">
		<cfquery datasource="fgbc_main_3">
			ALTER TABLE `fgbc_main_3`.`handbookstatistics`
			ADD COLUMN `churchplanting` VARCHAR(3) NULL DEFAULT NULL AFTER `more_info_im`
		</cfquery>
		<cfquery datasource="fgbc_main_3">
			ALTER TABLE `fgbc_main_3`.`handbookstatistics`
			ADD COLUMN `churchplantingcontact` VARCHAR(255) NULL DEFAULT NULL AFTER `churchplanting`
		</cfquery>
	</cffunction>

	<cffunction name="getMemFeeDeadline">
	<cfset var date = get("memFeeDeadline")>
		<cfif isDefined('session.statistics.extendDeadline') AND session.statistics.extendDeadline>
			<cfset date = dateAdd("m",3,date)>
		</cfif>
		<cfreturn date>
	</cffunction>

	<cffunction name="getMemFee">
		<cfreturn get("MemFee")>
	</cffunction>

	<cffunction name="getMemFeeMax">
		<cfreturn get("memFeeMax")>
	</cffunction>

	<cffunction name="getLateMemFee">
		<cfreturn get("lateMemFee")>
	</cffunction>

	<cffunction name="getLateMemFeeMax">
		<cfreturn get("lateMemFeeMax")>
	</cffunction>

	<cffunction name="getOnlineMemFee">
	<cfset var memfee = getMemFee() * 1.03>
	<cfset memfee = iif(memfee mod .05,memfee+(.05-(memfee mod .05)),memfee)>
	<cfif isAfter(getMemFeeDeadline())>
		<cfset memfee = getLateMemFee()>
	</cfif>
		<cfreturn memfee>
	</cffunction>

	<cffunction name="getOnlineMemFeeMax">
	<cfset var memfee = getMemFeeMax() * 1.03>
	<cfset memfee = iif(memfee mod 5,memfee+(5-(memfee mod 5)),memfee)>
	<cfif isAfter(getMemFeeDeadline())>
		<cfset memfee = getLateMemFeeMax()>
	</cfif>
		<cfreturn memfee>
	</cffunction>

	<cffunction name="keyFromChurchid"><!---Method to use churchid for key if it is set--->
		<cfif isDefined("params.churchid")>
			<cfreturn params.churchid>
		<cfelseif isDefined("params.key")>
			<cfreturn params.key>	
		<cfelse>
			<cfreturn "">	
		</cfif>	
	</cffunction>

</cfcomponent>
