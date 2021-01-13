//TODO - Convert to cfscript
<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<cfset usesLayout("/handbook/layout_handbook1")>
		<cfset filters(through="logview", type="after")>
		<cfset filters(through="gotBasicHandbookRights", only="index,show,new,edit")>
	</cffunction>


<!---CRUD--->
<!---CRUD--->
<!---CRUD--->
	<!--- handbook-subscribes/index --->
	<cffunction name="index">
		<cfif isDefined("params.sortBy")>
			<cfset orderstring = params.sortBy>
		<cfelse>
			<cfset orderstring = "email">
		</cfif>
		<cfif isDefined("params.type")>
			<cfset whereString = "type='#params.type#'">
		<cfelse>
			<cfset wherestring = "id > 0">
		</cfif>
			<cfset handbooksubscribes = model("Handbooksubscribe").findAll(where=wherestring, order=#orderstring#)>
	</cffunction>

	<!--- handbook-subscribes/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
    	<cfset handbooksubscribe = model("Handbooksubscribe").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbooksubscribe)>
	        <cfset flashInsert(error="Handbooksubscribe #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- handbook-subscribes/new --->
	<cffunction name="new">
		<cfset handbooksubscribe = model("Handbooksubscribe").new()>
	</cffunction>

	<!--- handbook-subscribes/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset handbooksubscribe = model("Handbooksubscribe").findByKey(params.key)>
    	<cfset handbookpeople = model("Handbookperson").findall(where="p_sortorder < #getNonStaffSortOrder()+1#", include="Handbookstate,Handbookpositions", order="id", distinct=true)>
    	<cfset handbookpeople = model("Handbookperson").groupQuery(handbookpeople,"id")>
    	<cfset handbookpeople = model("Handbookperson").orderQuery(handbookpeople,"selectname")>

	   	<cfif not val(handbooksubscribe.handbookid)>
	   		<cfset thishandbookperson = model("Handbookperson").findOne(where="email='#handbooksubscribe.email#'",include="Handbookstate,Handbookpositions")>
	   		<cfif isObject(thishandbookperson)>
	   			<cfset handbooksubscribe.handbookid = thishandbookperson.id>
	   		</cfif>
    	</cfif>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbooksubscribe)>
	        <cfset flashInsert(error="Handbooksubscribe #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- handbook-subscribes/create --->
	<cffunction name="create">
		<cfset handbooksubscribe = model("Handbooksubscribe").new(params.handbooksubscribe)>

		<!--- Verify that the handbooksubscribe creates successfully --->
		<cfif handbooksubscribe.save()>
			<cfset flashInsert(success="The handbooksubscribe was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbooksubscribe.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>

	<!--- handbook-subscribes/update --->
	<cffunction name="update">

		<cfset handbooksubscribe = model("Handbooksubscribe").findByKey(params.key)>

		<!--- Verify that the handbooksubscribe updates successfully --->
		<cfif handbooksubscribe.update(params.handbooksubscribe)>
			<cfset flashInsert(success="The handbooksubscribe was updated successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbooksubscribe.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>

	<!--- handbook.subscribes/delete/key --->
	<cffunction name="delete">
		<cfset handbooksubscribe = model("Handbooksubscribe").findByKey(params.key)>

		<!--- Verify that the handbooksubscribe deletes successfully --->
		<cfif handbooksubscribe.delete()>
			<cfset flashInsert(success="The handbooksubscribe was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbooksubscribe.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

<!---Specialized Views--->
<!---Specialized Views--->
<!---Specialized Views--->

	<!--- name="subscribeMe", pattern="/subscribeme/" --->
	<cffunction name="updates">
		<cfset subscription = model("Handbooksubscribe").new()>
		<cfset subscription.type = "updates">
		<cfset subscription.email = session.auth.email>
		<cfset check = model("Handbooksubscribe").findAll(where="type='#subscription.type#' AND email='#subscription.email#'")>

		<cfif check.recordcount>
			<cfset flashInsert(update="You are already subscribed to this service")>
	            <cfset redirectTo(back=true)>
		<cfelse>
			<cfif subscription.save()>
				<cfset flashInsert(update="You will now recieve notices of data updates.")>
	            <cfset redirectTo(back=true)>
			<!--- Otherwise --->
			<cfelse>
				<cfset flashInsert(update="There was an error creating the subscription.")>
	            <cfset redirectTo(back=true)>
			</cfif>
		</cfif>

	</cffunction>

	<cffunction name="subscribeToDates">
	<cfargument name="type" default="dates">
	<cfif isDefined("params.key") AND isValid("email",params.key)>
		<cfset subscription = model("Handbooksubscribe").new()>
		<cfset subscription.type = arguments.type>
		<cfset subscription.email = params.key>
		<cfset message="You are now subscribed to daily birthday and anniversary reminders.">

		<cfset check = model("Handbooksubscribe").findOne(where="type='#subscription.type#' AND email='#subscription.email#'")>

		<cfif NOT isObject(check)>
			<cfif subscription.save()>
				<cfset message="You are now subscribed!.">
			<!--- Otherwise --->
			<cfelse>
				<cfset message="There was an error creating the subscription.">
			</cfif>
		<cfelse>
				<cfset message="You are already subscribed to daily birthday and anniversary reminders.">
		</cfif>
		<cfset renderView(action="youaresubscribed")>
	</cfif>
	</cffunction>

	<cffunction name="sendTodaysDates">
	<cfargument name="now" default="#now()#">
	<cfset countEmailsSent = 0>

		<cfif isDefined("params.today")>
			<cfset arguments.now = params.today>
		</cfif>

		<cftry>
			<cfset updateDateNumbers()>
		<cfcatch></cfcatch></cftry>

			<cfif isDefined("params.value1")>
			<!--- for use by ifttt --->
				<cfset params.go = params.value1>
			</cfif>

		<cfset var loc=structNew()>
			<cfset birthdays = model("Handbookperson").findDatesToday("birthday",arguments.now)>
			<cfset anniversaries = model("Handbookperson").findDatesToday("anniversary",arguments.now)>
			<cfset subscriptions = model("Handbooksubscribe").findAll(where="type='dates'")>

			<cfset emailall = "">

			<cfif isDefined("params.go") && params.go is "test">
				<cfif !isLocalMachine()>
					<cfset sendEMail(from="tomavey@fgbc.org", to="tomavey@fgbc.org", subject="TEST - From the Charis Fellowship Online Handbook: Todays Birthdays and Anniversaries", template="sendtodaysdates", layout="/layout_naked")>
				<cfelse>	
					<cfset flashInsert(message="Test - Email would have been sent in production")>	
				</cfif>
			<cfelse>
				<cfif isDefined("params.sendto") and len(params.sendto)>
					<cfset subscriptions = listToQuery(list=params.sendto, columnName="email")>
					<cfset lastSendAt = now()-1>
				</cfif>
				<cfloop query="subscriptions">
					<cfif sendToThisPerson(lastSendAt) || isDefined("params.reSendToAll")>
						<cfset countEmailsSent = countEmailsSent + 1>
						<cfset useThisEmail = useHandbookEmail(email,handbookemail)>
						<cfif !isLocalMachine()>
							<cfset sendEMail(from="tomavey@fgbc.org", to=scrubEmail(useThisEmail), subject="From the Charis Fellowship Online Handbook: Todays Birthdays and Anniversaries", template="sendtodaysdates", layout="/layout_for_email", type="html")>
						<cfelse>
							<cfset flashInsert(message="Email would have been sent to #countEmailsSent# in production mode.")>	
						</cfif>
						<cfset emailall = emailall & ";" & useThisEmail>
						<cfif isDefined("id")>
							<cfset setLastSendAt(id)>
						</cfif>

					</cfif>
				</cfloop>
			</cfif>
			<cfif !gotRights("office")>
				<cfoutput>Sent!</cfoutput>
				<cfabort>
			</cfif>
			<cfset emailall = replace(emailall,";","","one")>
	</cffunction>


<!---Actions--->
<!---Actions--->
<!---Actions--->
	<cffunction name="dates">
		<cfset subscription = model("Handbooksubscribe").new()>
		<cfset subscription.type = "dates">
		<cfif isDefined("params.email")>
			<cfset subscription.email = params.email>
		<cfelse>
			<cfset subscription.email = session.auth.email>
		</cfif>
		<cfif structKeyExists(session.auth,"userid") AND isDefined("session.auth.userid")>
			<cfset subscription.userid = session.auth.userid>
		</cfif>
		<cftry>
			<cfset subscription.handbookid = session.auth.handbook.people>
		<cfcatch></cfcatch></cftry>
		<cfset check = model("Handbooksubscribe").findAll(where="type='#subscription.type#' AND email='#subscription.email#'")>

		<cfif check.recordcount>
			<cfset flashInsert(update="You are already subscribed to this service")>
	            <cfset redirectTo(back=true)>
		<cfelse>
			<cfif subscription.save()>
				<cfset flashInsert(update="You will now recieve daily notices of birthdays and anniversaries.")>
	            <cfset redirectTo(back=true)>
			<!--- Otherwise --->
			<cfelse>
				<cfset flashInsert(update="There was an error creating the subscription.")>
	            <cfset redirectTo(back=true)>
			</cfif>
		</cfif>

	</cffunction>

	<cffunction name="praydaily">
		<cfset subscription = model("Handbooksubscribe").new()>
		<cfset subscription.type = "praydaily">
		<cfset subscription.email = session.auth.email>

		<cfset check = model("Handbooksubscribe").findAll(where="type='#subscription.type#' AND email='#subscription.email#'")>

		<cfif check.recordcount>
			<cfset flashInsert(update="You are already subscribed to this service")>
	            <cfset redirectTo(back=true)>
		<cfelse>
			<cfif subscription.save()>
				<cfset flashInsert(update="You will now recieve daily prayer reminders.")>
	            <cfset redirectTo(back=true)>
			<!--- Otherwise --->
			<cfelse>
				<cfset flashInsert(update="There was an error creating the subscription.")>
	            <cfset redirectTo(back=true)>
			</cfif>
		</cfif>

	</cffunction>

	<cffunction name="prayweekly">
		<cfset subscription = model("Handbooksubscribe").new()>
		<cfset subscription.type = "prayweekly">
		<cfset subscription.email = session.auth.email>

		<cfset check = model("Handbooksubscribe").findAll(where="type='#subscription.type#' AND email='#subscription.email#'")>

		<cfif check.recordcount>
			<cfset flashInsert(update="You are already subscribed to this service")>
	            <cfset redirectTo(back=true)>
		<cfelse>
			<cfif subscription.save()>
				<cfset flashInsert(update="You will now recieve daily prayer reminders.")>
	            <cfset redirectTo(back=true)>
			<!--- Otherwise --->
			<cfelse>
				<cfset flashInsert(update="There was an error creating the subscription.")>
	            <cfset redirectTo(back=true)>
			</cfif>
		</cfif>

	</cffunction>

	<!--- route="unSubscribeMe", pattern="/updates/unsubscribeme/[key] --->
	<cffunction name="unsubscribe">
		<cfset unsubscribe = model("Handbooksubscribe").deleteAll(where="email='#session.auth.email#' AND type='#params.key#'")>
		<cfset flashInsert(update="Your subscription has been removed")>
	        <cfset redirectTo(back=true)>
	</cffunction>


<!---Send Email--->
<!---Send Email--->
<!---Send Email--->
	<cffunction name="sendPrayerReminders">
		<cfargument name="timeframe" required="true" type="string">
		<cfparam name="params.thisweek" default="#week(now())#">
		<cfparam name="params.thisday" default="#dayofweek(now())#">
		<cfset loc = structNew()>

		<cfif arguments.timeframe is "today">
			  <cfset loc.wherestring = "week=#params.thisweek# AND dayofweek=#params.thisday# AND ">
			  <cfset greeting = "Today's ">
			  <cfset loc.subscribeType = 'praydaily'>
		<cfelse>
			  <cfset loc.wherestring = "week=#params.thisweek# AND ">
			  <cfset greeting = "This week's ">
			  <cfset loc.subscribeType = 'prayweekly'>
		</cfif>

		<cfset prayForOrganizations = model("Handbookprayer").findall(where="#loc.wherestring# type='organization'", order="week,dayofweek", include="Handbookorganization(Handbookstate)")>

		<cfset prayForPeople = model("Handbookprayer").findall(where="#loc.wherestring# type='person'", order="week,dayofweek", include="Handbookperson(Handbookstate,Handbookpositions)")>

		<cfset subscriptions = model("Handbooksubscribe").findAll(where="type='#loc.subscribeType#'")>
		<cfset emailall = "">

		<!--- If being sent to tomavey@fgbc.org change to tomavey@comcast.net--->
		<cfif isDefined("params.key") and params.key is "test">
			<cfset sendEMail(from="tomavey@fgbc.org", to="tomavey@comcast.net", subject="TEST - From the Charis Fellowship Online Handbook: #greeting#Prayer Reminders", template="sendprayerreminders", layout="/layout_naked")>
		<cfelse>

			<cfloop query="subscriptions">

				<!--- Check to see if email has been sent to this person today --->
				<cfif sendToThisPerson(lastSendAt)>
					<cfset useThisEmail = useHandbookEmail(email,handbookemail)>
					<cfset sendEMail(from="tomavey@fgbc.org", to=scrubEmail(useThisEmail), subject="From the Charis Fellowship Online Handbook: #greeting#Prayer Reminders", template="sendprayerreminders", layout="/layout_naked")>

					<cfset setLastSendAt(id)>

					<cfset emailall = emailall & ";" & useThisEmail>

				</cfif>
			</cfloop>
		</cfif>

		<cfset emailall = replace(emailall,";","","one")>
		<cfreturn true>
	</cffunction>

	<cffunction name="sendToThisPerson">
	<cfargument name="lastSendAt" required="true">
	<cfset var loc=structNew()>
	<cfset loc.todayAsString = dateformat(now(),"yyyy-mm-dd")>
	<cfset loc.return = true>
	<cfif isDate(arguments.lastSendAt)>
		<cfif dateCompare(lastSendAt,loc.todayasstring) EQ 0>
			<cfset loc.return=false>
		</cfif>
	</cfif>
	<cfif isDefined("params.resend")>
			<cfset loc.return=false>
	</cfif>
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="sendTodaysPrayerReminders">
		<cfset sendPrayerReminders(timeframe="today")>
		<cfset renderView(template="sendPrayerReminders")>
	</cffunction>

	<cffunction name="sendVerificationToAdmin">
		<cfset sendEmail(to="tomavey@fgbc.org", from="tomavey9173@gmail.com", subject="Did his work?", template="sendVerificationToAdmin", layout="/layout_for_email")>
	</cffunction>

	<cffunction name="sendYesterdaysUpdates">
	<cfset args = structNew()>
		<cfset args.yesterday = dateformat(dateAdd("d",-1,now()),"yyyy-mm-dd")>
		<cfset args.showOnlyYesterday = true>
		<cfset args.showOnlyToday = false>
		<cfset args.showMaxRows = 1000000>
		<cfset args.showPeopleUpdates = true>
		<cfset args.showOrganizationUpdates = true>
		<cfset args.showPeopleDeletes = true>
		<cfset args.showPeopleCreates = true>
		<cfset args.showPositionUpdates = true>

		<cfset session.handbook.isSubscriberSession = true>

		<!---people updates--->

		<cfset peopleUpdates = model("Handbookupdate").findPeopleUpdates(args)>
		<cfif !peopleUpdates.recordcount>
			<cfset args.showpeopleUpdates = false>
		</cfif>

	   	<!--- Organization Updates --->

		<cfset organizationUpdates = model("Handbookupdate").findOrganizationUpdates(args)>
		<cfif !organizationUpdates.recordcount>
			<cfset args.showorganizationUpdates = false>
		</cfif>

	   	<!--- Position Updates --->

		<cfset positionUpdates = model("Handbookupdate").findPositionUpdates(args)>
		<cfif !positionUpdates.recordcount>
			<cfset args.showPositionUpdates = false>
		</cfif>

		<!---Deletes--->

		<cfset peopledeletes = model("Handbookupdate").findPeopleDeletes(args)>
		<cfif !peopledeletes.recordcount>
			<cfset args.showPeopleDeletes = false>
		</cfif>

		<!---PeopleCreates--->

		<cfset peoplecreates = model("Handbookupdate").findpeoplecreates(args)>
		<cfif !peoplecreates.recordcount>
			<cfset args.showPeopleCreates = false>
		</cfif>

		<!---Set the email list--->
		<cfif isDefined("params.go") AND params.go is "test">
			<cfset emailTestList = "tomavey@fgbc.org">
			<cfset subscriptions = listToQuery(emailTestList,"email")>
		<cfelse>
			<cfset subscriptions = model("Handbooksubscribe").findAll(where="type='updates'")>
		</cfif>

		<!---Check to make sure there were some changed yesterday--->
		<cfif peopleUpdates.recordcount OR organizationUpdates.recordcount OR peopledeletes.recordcount OR positionUpdates.recordcount OR peopleCreates.recordcount>

			<!---Start gathering list of emails for report--->
			<cfset emailTo = "">
			<!---Send notice to the list of email addresses--->
			<cfoutput query="subscriptions">
				<cfset emailTo = emailTo & ", " & email>
				<cfset sendEmail(to=email, from="tomavey@fgbc.org", subject="Yesterdays Handbook Updates", template="/handbook/updates/index.cfm", layout="/layout_for_email")>
				<cfif isDefined("id")>
					<cftry>
						<cfset setLastSendAt(id)>
					<cfcatch></cfcatch></cftry>
				</cfif>
			</cfoutput>

			<!---Put list of emails in variable that is only used in the web page report, not the email notification--->
			<cfset emailedTo = replace(emailTo,", ","","one")>

		<cfelse>
		       <!---If there are no updates yesterday, don't send anything, show a flash message--->
		        <cfset flashInsert(error="No Updates Yesterday!")>
		</cfif>

		<cfset renderView(template="/handbook/updates/index.cfm")>
	</cffunction>

f`	<cffunction name="xsendTodaysDates">
		<cfset sendPrayerReminders(timeframe="week")>
		<cfset renderView(template="sendPrayerReminders")>
	</cffunction>

	<cffunction name="testscheduledemailsend">
			<cfset sendEMail(from="tomavey@fgbc.org", to="tomavey@comcast.net", subject="Test of send mail", template="testscheduledemailsend", layout="/layout_naked")>
	</cffunction>

	<cffunction name="plugLastSendAt">
		<cfset subscriptions = model("Handbooksubscribe").findAll(where="type='#params.key#'")>
		<cfloop query = "subscriptions">
			<cfset thissubscription = model("Handbooksubscribe").findOne(where="id=#id#")>
			<cfset thissubscription.lastSendAt = dateformat(now(),"yyyy-mm-dd")>
			<cfset thissubscription.lastSendAt = "2013-05-01">
			<cfset check=thissubscription.update()>
		</cfloop>
		<cfset newsubscriptions = model("Handbooksubscribe").findAll(where="type='#params.key#'", reload=true)>
		<cfdump var="#newsubscriptions#"><cfabort>
	</cffunction>

	<cffunction name="scrubEmail" access="private">
	<cfargument name="emailaddress" required="true" type="string">
	<cfset var loc=structNew()>
	<cfset loc.return = trim(arguments.emailAddress)>
		<cfif arguments.emailaddress is "tomavey@fgbc.org">
			<cfset loc.return = "tomavey@comcast.net">
		</cfif>
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="useHandbookEmail">
	<cfargument name="email" required="true" type="string">
	<cfargument name="handbookemail" required="true" type="string">
	<cfif len(arguments.handbookemail)>
		<cfreturn arguments.handbookemail>
	<cfelse>
		<cfreturn arguments.email>
	</cfif>
	</cffunction>

	<cffunction name="setLastSendAt" access="private">
	<cfargument name="subscriptionid" required="true" type="numeric">
		<cfset loc.thisSubscription = model("Handbooksubscribe").findOne(where="id=#arguments.subscriptionid#")>
		<cfset loc.thisSubscription.lastSendAt = dateformat(now(),"yyyy-mm-dd")>
		<cfset loc.return = loc.thisSubscription.update()>
		<cfreturn loc.return>
	</cffunction>

	<cffunction name='listToQuery'>
	<cfargument name="list" required="true">
	<cfargument name="columnName" default="columnName">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
	<cfset loc.return = "">
		<cfset loc.return = QueryNew(loc.columnName)>
		<cfloop index=curElement list='#loc.list#'>
		<cfset newRow = QueryAddRow(loc.return)>
		<cfset temp = QuerySetCell(loc.return, loc.columnName, curElement)>
		</cfloop>
		<cfreturn loc.return>
	</cffunction>

</cfcomponent>
