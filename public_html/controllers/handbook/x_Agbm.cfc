year = application.wheels.delegateyear<cfcomponent output="false" extends="Controller">

<!---
AGBM list actions start here. 
Most of the actions use the handbookperson model 
that includes handbookagbminfo model information. 
The only exception is the "new" action which 
uses the handbookagbminfo model directly
--->
	
	<cffunction name="init">
		<cfset usesLayout(template="/handbook/layout_agbm")>
		<cfset filters(through="gotAgbmRights", except="rssfeed")>
		<cfset filters(through="setreturn", only="index,show")>
		<cfset filters(through="getCurrentMembershipYear")>
	</cffunction>

	<cffunction name="getCurrentMembershipYear">
		<cfset currentmembershipyear = model("Handbookperson").currentMembershipYear(params)>
	</cffunction>
	

	<cffunction name="index">
		<!---Set up a type of report variable in the session--->		
		<cfparam name="session.params.key" default="members">
		<cfif isDefined("params.key")>
			<cfset session.params.key = params.key>
		</cfif>

		<!---Set up pagination parameters--->
		<cfset params.Maxpage =30>
		<cfset params.showpagination = 1><!---used in view to decide--->
		
		<cfif isDefined("params.download") OR isDefined("params.excel") or isDefined("params.showall") or (isDefined("session.params.key") AND session.params.key is "mail")>
			<cfset params.maxpage = "1000000">
			<cfset params.showpagination = 0>	   
		</cfif>
		
		<!---get AGBM people based on params--->
		<cfset peopleAndParams = model("Handbookperson").findAGBM(params)>
		<cfset people = peopleAndParams.people>
		<cfset structAppend(params,peopleAndParams.params)>
		
		<!---Variables needed for pagination links--->
		<cfset params.lastpage = pagination().totalpages>

		<cfif isdefined("params.page") AND params.page GT 1>
			<cfset params.previousPage = params.page - 1>
		<cfelse>
			<cfset params.previousPage = 0>
		</cfif>

		<cfif isdefined("params.page") AND params.page lt params.lastpage>
			<cfset params.nextPage = params.page + 1>
		<cfelse>
			<cfset params.nextPage = 0>
		</cfif>

		<!---Set the layout for normal, download view, or download excel--->
		<cfif isdefined("params.download")>
			<cfset renderPage(template="download", layout="/layout_naked")>
		<cfelseif isdefined("params.excel")>	
			<cfset renderPage(template="download", layout="/layout_download")>
		<cfelse>
			<cfset renderPage(layout="/handbook/layout_agbm")>
		</cfif>

	</cffunction>
	
	<cffunction name="handbookMembershipReport">

		<cfset currentMembershipYear = model("Handbookperson").currentMembershipYear(params)>

		<cfset cat1Ordained = model("Handbookperson").findAllAGBMcat1Ordained(params).people>

		<cfset cat1Licensed = model("Handbookperson").findAllAGBMcat1Licensed(params).people>

		<cfset cat2Ordained = model("Handbookperson").findAllAGBMcat2Ordained(params).people>

		<cfset cat2Licensed = model("Handbookperson").findAllAgbmCat2Licensed(params).people>

		<cfset cat3 = model("Handbookperson").findAllAgbmCat3(params).people>

	</cffunction>
	
	<cffunction name="show">
		<cfset setReturn()>
		<cfset payments = model("Handbookagbminfo").findAll(where="personid = #params.key#", include="Handbookperson(Handbookstate)", order="membershipfeeyear DESC")>
	</cffunction>
	
	<cffunction name="getGroupsAgbm">
	<cfargument name="personid" require="true" type="string">
	<cfset var loc=structNew()>
	<cfset loc.agbmGroupIds = "8,16">
		<cfset loc.agbmgroups = model("Handbookgroup").findAll(where="personid = #arguments.personid# AND groupTypeid IN (#loc.agbmGroupIds#)", include="Handbookgrouptype")>
		<cfsavecontent variable="loc.groups">
			<cfoutput query="loc.agbmgroups">
				#title# 
				<cfif gotRights("superadmin,agbmadmin")>
					#linkto(text="x", controller="handbook-groups", action="delete", params="groupTypeId=#loc.agbmgroups.handbookgrouptypeid#&personid=#personid#", title="Remove From #title#", class="tooltipside")#<br/>
				</cfif>
			</cfoutput>
		</cfsavecontent>

		<cfsavecontent variable="loc.notgroups">
			<cfoutput>
			<cfloop list="#loc.agbmGroupIds#" index="i">
				<cfset loc.check = model("Handbookgroup").findOne(where="personid = #arguments.personid# AND groupTypeid = #i#", include="Handbookgrouptype")>
				<cfif not isObject(loc.check)>
					<cfset loc.notGroup = model("Handbookgrouptype").findByKey(i)>
					#loc.notGroup.title# 
					<cfif gotRights("superadmin,agbmadmin")>
						#linkto(text="+", controller="handbook-groups", action="create", params="groupTypeId=#loc.notgroup.id#&personid=#arguments.personid#", title="Add To #loc.notGroup.title#", class="tooltipside")#<br/>
					</cfif>
				</cfif>
			</cfloop>
			</cfoutput>	
		</cfsavecontent>
		<cfreturn loc>
	</cffunction>
	
	<cffunction name="getLastPayment">
	<cfargument name="personid" required="true" type="numeric">
	<cfset var loc=structNew()>

	<cfset loc.currentMembershipYear = model("Handbookperson").currentMembershipYear(params)>
	
	<cfset loc.fontcolor = "black">

		<cfset loc.lastPayment = model("Handbookagbminfo").findAll(where="personid = #arguments.personid#", order="membershipfeeyear DESC")>

		<cfif loc.lastPayment.recordcount>

		<cfif loc.lastPayment.membershipfeeyear NEQ loc.currentMembershipYear>
			  <cfset loc.fontcolor = "red">
		</cfif>

		<cfif loc.lastPayment.category EQ 1>
			  <cfset loc.check = loc.lastpayment.licensed + loc.lastpayment.ordained>
			  <cfif NOT loc.check>	
			  		<cfset loc.fontcolor = "red">
			  </cfif>
		</cfif>
		
			<cfsavecontent variable="loc.return">
					<cfoutput>
					  <p style="color:#loc.fontcolor#">
						#dollarFormat(loc.lastPayment.membershipfee)# for #loc.lastPayment.membershipfeeyear#<br/>
						Cat. #loc.lastPayment.category#<cfif loc.lastPayment.ordained>; Ordained<cfelseif loc.lastpayment.licensed>; Licensed</cfif>
					  </p>
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
						<p>#dollarFormat(loc.Payments.membershipfee)# for #loc.Payments.membershipfeeyear#<br/>
						Cat. #loc.Payments.category#<cfif loc.Payments.ordained>; Ordained<cfelseif loc.Payments.licensed>; Licensed</cfif></p>
					</cfoutput> 		
			</cfsavecontent>	
		<cfelse>
			<cfset loc.return = "na">
		</cfif>

	<cfreturn loc.return>	
	</cffunction>
	
	<cffunction name="rssFeed">

		<cfset ministerium = model("Handbookperson").findAGBM(params).people>

		<cfxml variable="rssFeed">
		  <rss version="2.0">
		     <channel>
		        <title>Association of Grace Brethren Ministers Membership List</title>
		        <link>http://www.fgbc.org/handbook</link>
		        <description>Association of Grace Brethren Ministers Membership List <cfoutput>(#ministerium.recordcount# members)</cfoutput></description>
		        <pubDate><cfoutput>#dateformat(now())#</cfoutput></pubDate>
		        <cfoutput query="ministerium" group="id">
		           <cfset desc = "#position#: #name#, #org_city#, #state_mail_abbrev#" /> 
		           <item>
		              <title>#lname#, #fname#</title>
		              <description>   <![CDATA["#Desc#"]]> </description>
		              <link>http://www.fgbc.org/handbook-people/show/#id#</link>
		              <guid>#id#</guid>
		           </item>
		        </cfoutput>
		           <item>
		              <title>Member Count:</title>
		              <description><cfoutput>#ministerium.recordcount# members</cfoutput></description>
		              <link></link>
		              <guid></guid>
		           </item>
		     </channel>
		  </rss>
		</cfxml>
		
		<cfset rssFeed = toString(rssfeed)>
		<cfset rssFeed = trim(rssfeed)>
		
		<cfset renderText(rssfeed)>

	</cffunction>

	<cffunction name="snycCheck">
		<cfset members = model("Handbookagbminfo").findAll(where="membershipfee > 0 AND membershipfeeyear = #year(now())#", include="Handbookperson(Handbookstate)", order="lname,fname")>
	</cffunction>	
	
	<cffunction name="snyc">

		<cfset newmembers = model("Handbookagbminfo").findAll(where="membershipfee > 0 AND membershipfeeyear = #year(now())#", include="Handbookperson(Handbookstate)", order="lname,fname")>
		<cfset oldmembers = model("Handbookperson").findAll(where="grouptypeid = 8", include="Handbookstate,Handbookgroup", order="lname,fname")>
		
		<!---Make sure all old members are on the mailing list--->
		<cfloop query="oldmembers">
			<cfset checkMailList = model("Handbookperson").findAll(where="grouptypeid = 16", include="Handbookstate,Handbookgroup", order="lname,fname")>
			<cfif not checkMailList.recordcount>
				<cfset new = model("Handbookgroup").new()>
				<cfset new.personid = id>
				<cfset new.groupTypeId = 16>
				<cfset new.save()>
			</cfif>
		</cfloop>

		<!---Delete everyone from group 8--->
		<cfset model("Handbookgroup").deleteAll(where="grouptypeid = 8")>
		
		<!---Put all new members in group 8--->
		<cfloop query="newmembers">
				<cfset new = model("Handbookgroup").new()>
				<cfset new.personid = personid>
				<cfset new.groupTypeId = 8>
				<cfset new.save()>
		</cfloop>
		
		<cfset redirectTo(action="index")>

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
	
	<cffunction name="dashboard">
	<cfset var loc=structNew()>
	<cfset loc.currentMembershipYear = model("Handbookperson").currentMembershipYear(params)>
	<cfset params.currentmembershipyear = loc.currentMembershipYear>  
		  <cfset dataThisYear = model("Handbookperson").getDashboardInfo(params)>
		  <cfset dataThisYear.Year = params.currentMembershipYear>
	<cfset params.currentmembershipyear = loc.currentMembershipYear - 1>  
		  <cfset dataPreviousYear = model("Handbookperson").getDashboardInfo(params)>
		  <cfset dataPreviousYear.Year = params.currentMembershipYear>
	<cfset params.currentmembershipyear = loc.currentMembershipYear - 2>  
		  <cfset dataPreviousPreviousYear = model("Handbookperson").getDashboardInfo(params)>
		  <cfset dataPreviousPreviousYear.Year = params.currentMembershipYear>
	</cffunction>
	
<!---Refactoring started 11/27 with 284 lines--->

<!---
Need to go ahead and change this so that membership is
directly based on payments and not on group membership.

Then do the refactoring.

Also, there are two many method calls in each row of the
index view slowing down the report greatly.  Somehow
I need to provide more of the needed information in
the struct provided by the controller.  May need some
custom (not ORM) queries
--->

</cfcomponent>