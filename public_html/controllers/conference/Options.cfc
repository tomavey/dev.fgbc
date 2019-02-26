<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout("/conference/adminlayout")>
		<cfset filters(through="officeOnly", except="rssmeals,rssregs,rssccare,rssexcursions,rsspreconference,rsslabs,showoption,testisbefore,testiframe,jsonmeals,jsonregs,jsonexcursions,list")>
		<cfset filters(through="setRssEnvironment", only="rssregs,rssmeals,rssccare,rsspreconference")>
		<cfset filters(through="setreturn", only="index,show,list,delete")>
		<cfset filters(through="setKeyToKeyy")>
	</cffunction>

	<cffunction name="testmodel">
			<cfset option = model("Conferenceoption").findByKey(13)>
			<cfdump var="#option#"><cfabort>
	</cffunction>

<!---Filters--->

	<cffunction name="setRssEnvironment">
		<cfif application.wheels.environment is not "production">
			<cfset set(environment="production")>
		</cfif>
	</cffunction>

<!---CCRUD methods--->

	<!--- options/index --->
	<cffunction name="index">
		<cfset var whereString = "event = '#getEvent()#'">

		<cfif isdefined("params.event")>
			<cfset whereString = "event = '#params.event#'">
		</cfif>
		<cfif isDefined("params.key")>
			<cfset whereString = whereString & " AND type = '#params.key#'">
		</cfif>
		<cfif isDefined("params.type")>
			<cfset whereString = whereString & " AND type = '#params.type#'">
		</cfif>

		<cfset options = model("Conferenceoption").findAll(where=whereString, order="type,sortorder")>

	</cffunction>

	<!--- options/show/key --->
	<cffunction name="show">
		<cfif isdefined("params.key")>
			<cfset option = model("Conferenceoption").findAll(where="id=#params.key#", parameterize=true)>
		<cfelse>
			<cfset option = model("Conferenceoption").findAll(where="event = '#getEvent()#'", order="type,sortorder")>
		</cfif>
	</cffunction>

	<cffunction name="list">
		<cfif isdefined("params.type")>
			<cfset options = model("Conferenceoption").findAll(where="type = '#params.type#' AND event = '#getEvent()#'", order="type,sortorder")>
		<cfelse>
			<cfset options = model("Conferenceoption").findAll(where="event = '#getEvent()#'", order="type,sortorder")>
		</cfif>
		<cfset renderPage(layout="/layout_naked")>
	</cffunction>

	<cffunction name="showDescription">
			<cfset option = model("Conferenceoption").findAll(where="id=#params.key#")>
			<cfset renderText(option.description)>
	</cffunction>

	<!--- options/showoption/key --->
	<cffunction name="showoption">
		<cfset option = model("Conferenceoption").findAll(where="id=#params.key#", parameterize=true)>
		<cfset renderPage(layout="/conference/layout")>
	</cffunction>

	<!--- options/add --->
	<cffunction name="new">
		<cfset option = model("Conferenceoption").new()>
		<cfset option.event = getEvent()>
	</cffunction>

	<!--- options/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset option = model("Conferenceoption").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(option)>
	        <cfset flashInsert(error="option #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- options/create --->
	<cffunction name="create">
		<cfset option = model("Conferenceoption").new(params.option)>

		<!--- Verify that the option creates successfully --->
		<cfif option.save()>
			<cfset flashInsert(success="The option was created successfully.")>
			<cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the option.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<!--- options/update --->
	<cffunction name="update">
		<cfset option = model("Conferenceoption").findByKey(params.key)>

		<!--- Verify that the option updates successfully --->
		<cfif option.update(params.option)>
			<cfset flashInsert(success="The option was updated successfully.")>
			<cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the option.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- options/delete/key --->
	<cffunction name="delete">
		<cfset option = model("Conferenceoption").findByKey(params.key)>

		<!--- Verify that the option deletes successfully --->
		<cfif option.delete()>
			<cfset flashInsert(success="The option was deleted successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the option.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="copy">
				<!--- Find the record --->
    	<cfset option = model("Conferenceoption").findByKey(params.key)>
		<cfset option.event = getEvent()>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(option)>
	        <cfset flashInsert(error="option #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

<!---End of CCRUD methods--->


<!---RSS Creations actions--->

	<cffunction name="rssmeals">
		<cfset options = model("Conferenceoption").findAll(where="type='meal' AND event = '#getEvent()#'", order="sortorder")>

		<cfset title = "#getEventAsText()# Meal Options">

		<cfset description= "#getEventAsText()# will include a number of meals sponsored by FGBC ministries. These are great times of fellowship and celebration of what God is doing through our movement.">

		<cfif application.wheels.environment is not "production">
			<cfset set(environment="production")>
		</cfif>

		<cfset renderPage(template="rss.cfm", layout="rsslayout")>
	</cffunction>

	<cffunction name="jsonmeals">
		<cfset data = model("Conferenceoption").findMealsAsJson(params)>
		<cfset data=queryToJson(data)>
		<cfset renderJson()>
	</cffunction>

	<cffunction name="rssccare">
		<cfset options = model("Conferenceoption").findAll(where="event = '#getEvent()#' AND (type = 'childcare' OR type like 'kidskonference%')", order="sortorder")>
		<cfset title = "Vision2020 Leadership Child Care and Kids Konference Options">
		<cfset description= '<p><h1>Global Kingdom Kids</h1>This is an exciting year for the Kids Konference and Child-care programs!  We will be "visiting" countries around the world by means of our missionaries.  Each day we will meet at least one missionary supported by Encompass World Partners. We will learn about the culture, the climate, the people, the kids, the food, and much more about each country.  We will also discuss ways that we as kids can help support our missionaries and world evangelism.</p>
		</p>Prices include meals (where noted below), supplies, snacks and staff. Kids Konference excursions cost extra to cover part of the cost of the entry fee and tranportation.</p>
		<p>Child Care is infant through Kindergarten and is totally onsite.  Kids Konference is 1st - 8th grade and will be offsite and onsite.  Select excursions when you register: includes a modest extra charge for entry tickets, transportation and lunch.
		<p>Childcare and Kids Konference will be provided:
		<ul>
		<li>Friday:</li>
			<ul>
				<li>5:00 pm - 6:45 pm (only if parents are attending the Grace Schools reception)</li>
				<li>6:45 pm - end of evening celebration</li>
			</ul>
		<li>Saturday:
			<ul>
				<li>7:45 am - 8:45 am (only if parents are attending the Encompass Breakfast, feed your children before dropping them off)
					<ul>
						<li>Kids Konference travels to Legoland</li>
					</ul>
				</li>

				<li>8:45 am - 3:30 pm (during Mobile Learning Labs</li>
			</ul>
		<li>Sunday:
			<ul>
				<li>7:45 am - 9:00 am (only if parents are attending the Go2 Breakfast, feed your children before dropping them off)</li>
				<li>5:00 pm - 6:45 pm (only if parents are attending the Pastors and Wives Dinner, we will feed them)</li>
				<li>6:45 pm - end of evening celebration</li>
			</ul>
			</li>
		<li>Monday:
			<ul>
				<li>7:45 am - 8:45 am (only if parents are attending the Emcompass Breakfast, feed your children before dropping them off)
				<li>8:45 am - 3:30 pm (during Mobile Learning Labs
					<ul>
						<li>Kids Konference travels to Marketplace</li>
					</ul>
					</li>
				<li>5:00 pm - 6:45 pm (only if parents are attending the Chaplains Dinner, we will feed them)</li>
				<li>6:45 pm - end of evening celebration</li>
			</ul>
			</li>
		<li>Tuesday:
			<ul>
				<li>7:45 am - 8:45 am (only if parents are attending the Emcompass Breakfast, feed your children before dropping them off)
				<li>8:45 am - 3:30 pm (during Mobile Learning Labs)
					<ul>
						<li>Kids Konference travels to the Aquarium</li>
					</ul>
				</li>
				<li>5:00 pm - 6:45 pm (only if parents are attending the BMH Dinner, we will feed them)</li>
				<li>6:45 pm - end of evening celebration</li>
			</ul>
			</li>
		<li>Wednesday:
			<ul>
				<li>7:45 am - 2:00 pm (we will feed them lunch)
					<ul>
						<li>Kids Konference - Swimming</li>
					</ul>
				</li>
			</ul>
		</li>
		</ul>
</p>'>
		<cfif application.wheels.environment is not "production">
			<cfset set(environment="production")>
		</cfif>
		<cfset renderPage(template="rss.cfm", layout="rsslayout")>
	</cffunction>

	<cffunction name="rssexcursions">
		<cfset options = model("Conferenceoption").findAll(where="type='excursionx' OR type='touristoptionX'", order="sortorder")>
		<cfset title = "Vision2020 Leadership Excursion Options">
		<cfset showIfZero = "Call">
		<cfif options.recordcount>
			<cfset description= "There's lots to do around in the Palm Springs Valley.  Stay tuned as we develop options!">
		<cfelse>
			<cfset description= "There's lots to do around in the Palm Springs Valley.  Stay tuned as we develop options!">
		</cfif>
		<cfset renderPage(template="rss.cfm", layout="rsslayout")>
	</cffunction>

	<cffunction name="rssregs">
		<cfset options = model("Conferenceoption").findAll(where="event = '#getEvent()#' AND (type='registration' OR type = 'preconference')", order="type desc,sortorder")>
		<cfset title = "Vision2020 South Leadership Registration Options">
		<cfset dlink = "http://fgbc.org/vision2020/index.cfm?controller=register&action=welcome">

		<cfif isbefore("4-2-13")>
			<cfset description= "<h1><a href='#dlink#'>Register HERE!</a></h1>
							<p>Registration increases $30 after April 1 so register today!</p>">
		<cfelseif isbefore("5-5-13")>
			<cfset description= "<h1><a href='#dlink#'>Register HERE!</a></h1>
							<p>Registration increases $30 after May 4 so register today!</p>">
		<cfelseif isbefore("6-2-13")>
			<cfset description= "<h1><a href='#dlink#'>Register HERE!</a></h1>
							<p>Registration increases $10 after June 1 so register today!</p>">

		<cfelseif isbefore("7-19-13")>
			<cfset description= "<h1><a href='#dlink#'>Register HERE!</a></h1>">
		<cfelseif isbefore("7-22-13")>
			<cfset description= "<h1><a href='#dlink#'>Register HERE!</a></h1>
							<p>Childcare Registration and Meal and Mobile Learning Lab online ticket sales are closed. When you arrive at the conference, go directly to the hospitality center to purchase tickets if available.</p>
							<p>Online registration closes after tomorrow (7/23) however, you can register at the conference.</p>">
		<cfelseif isbefore("7-23-13")>
			<cfset description= "<h1><a href='#dlink#'>Register HERE!</a></h1>
							<p>Online registration closes after today!</p>
							<p>Meal and Mobile Learning Lab online ticket sales are closed. When you arrive at the conference, go directly to the hospitality center to purchase tickets if available.</p>">
		<cfelse>
			<cfset description= "<h1>Online Registration is closed.</h1>
							<p>When you arrive at the conference, go directly to the hospitality center to register.</h1>">
		</cfif>

		<cfif application.wheels.environment is not "production">
			<cfset set(environment="production")>
		</cfif>

		<cfset renderPage(template="rss.cfm", layout="rsslayout")>

	</cffunction>

	<cffunction name="rsspreconference">
		<cfset options = model("Conferenceoption").findAll(where="type='preconferenceX'", order="sortorder")>
		<cfset title = "Vision2020 Pre-Conference Options">
		<cfset description= "Vision2020 includes some pre-conference options that will help your ministry. Classes are July 27 and 28. Stay tunes for more information.">
		<cfset renderPage(template="rss.cfm", layout="rsslayout")>
	</cffunction>

	<cffunction name="rsslabs">
		<cfset options = model("Conferenceoption").findAll(where="type='MobileLearningLab'", order="sortorder")>

		<cfset title = "Vision2020 Mobile Learning Lab Experiences">

		<cfset description= "Mobile Learning Lab Experiences are designed to provide multi-cultural and effective church training. Participants will recieve advance orientation and post-debriefing around a visit to local multi-cultural and world class church ministries.  Mobile Learning Labs are on Saturday, Monday and Tuesday and begin at 9:30 AM each day, ending by 3:30 PM and will include motor coach transportation, lunches and expert trainers and guides. Pastors are encouraged to bring their staff, elders and or ministry leaders to join them on these experiences.">

		<cfif application.wheels.environment is not "production">
			<cfset set(environment="production")>
		</cfif>

		<cfset renderPage(template="rss.cfm", layout="rsslayout")>
	</cffunction>

<!---End of RSS Actions--->


<!---Misc Methods--->

	<cffunction name="clearsession">
		<cfset structDelete(session,"vision2020admin")>
		<cfset structDelete(session,"auth")>
		<cfabort>
	</cffunction>

	<cffunction name="resetSortOrder">
		<cfset options = model("Conferenceoption").findAll(where="event = '#getEvent()#'", order="type,sortorder")>
		<cfloop query = "options">
			<cfquery datasource = "fgbc_main_3">
				UPDATE equip_options
				SET sortorder = #options.currentrow#
				WHERE id = #options.id#
			</cfquery>
		</cfloop>
		<cfset redirectTo(action="index")>
	</cffunction>

	<cffunction name="getPreviousItem">
	<cfargument name="id" required="true" type="numeric">
		<cfset mySortOrder = model("ConferenceOptions").findOne(arguments.id).sortorder>
		<cfloop from="#mySortOrder#-1" to="1" step="-1" index="i">
			<cfset findSortOrder = model("ConferenceOption").findOne(where="sortorder = #i#")>
			<cfif isobject(findSortOrder)>
				<cfset previousItemId = findSortOrder.id>
				<cfbreak>
			</cfif>
		</cfloop>
	<cfdump var="#previousItemId#"><cfabort>
	<cfreturn previousItemId>
	</cffunction>

	<cffunction name="testIsBefore">
		<cfif isbefore("2-1-12")>
			Yes<cfabort>
		<cfelse>
			False<cfabort>
		</cfif>
	</cffunction>

	<cffunction name="testiframe">
	<cfset renderPage(layout="/layout_ajax")>
	</cffunction>

</cfcomponent>
