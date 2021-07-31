<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<cfset usesLayout("/conference/surveys/layout")>
		<cfset filters(through="getsettings")>
	</cffunction>

	<cffunction name="getSettings">
		<cfif isdefined("url.event") and url.event is "cel2008">
			<cfset conferenceName = "iGo 08">
			<cfset conferenceNameShort = "iGo08">
			<cfset location = "Tampa Florida">
			<cfset comparisonyear = "2011">
			<cfset comparisonId = "V2020">
			<cfset event=url.event>
		<cfelseif isdefined("url.event") and url.event is "cel2010">
			<cfset conferenceName = "Celebration 2010">
			<cfset conferenceNameShort = "Cel2010">
			<cfset location = "Cincinnatti, Ohio">
			<cfset comparisonyear = "2011">
			<cfset comparisonId = "v2020">
			<cfset event=url.event>
		<cfelseif isdefined("url.event") and url.event is "v2020">
			<cfset conferenceName = "the Vision2020 Leadership Conference">
			<cfset conferenceNameShort = "Vision2020">
			<cfset location = "Wooster GBC">
			<cfset comparisonyear = "2010">
			<cfset comparisonId = "Cel2010">
			<cfset event=url.event>
		<cfelseif isdefined("url.event") and url.event is "v2020w">
			<cfset conferenceName = "the Vision2020 West Leadership Conference">
			<cfset conferenceNameShort = "Vision2020West">
			<cfset location = "Indian Wells California">
			<cfset comparisonyear = "2011">
			<cfset comparisonId = "v2020">
			<cfset event="v2020w">
		<cfelseif isDefined("params.event") and params.event is "v2020s">
			<cfset conferenceName = "the Vision2020 South Leadership Conference">
			<cfset conferenceNameShort = "Vision2020South">
			<cfset location = "Atlanta, Georgia">
			<cfset comparisonyear = "2012">
			<cfset comparisonId = "v2020w">
			<cfset event="v2020s">
		<cfelseif isDefined("params.event") and params.event is "flinch">
			<cfset conferenceName = "Vision Conference: Flinch Conference">
			<cfset conferenceNameShort = "FlinchConference">
			<cfset location = "Newark, NJ">
			<cfset comparisonyear = "2014">
			<cfset comparisonId = "v2014dc">
			<cfset event="v2015nyc">
		<cfelse>
			<cfset conferenceName = "Vision Conference 2016 | Margins">
			<cfset conferenceNameShort = "Margins2016">
			<cfset location = "Toronto">
			<cfset comparisonyear = "2015">
			<cfset comparisonId = "v2015nyc">
			<cfset event="v2016tor">
		</cfif>
	</cffunction>

	<cffunction name="new">
	</cffunction>

	<cffunction name="create">
		<cfset survey = model("Conferencesurvey").new(params)>
		<cfloop collection="#survey.properties()#" item="i">
			<cfif survey[i] is "Select...">
	    		<cfset survey[i] = 0>
    		</cfif>
		</cfloop>
		<cfif survey.save()>
			<cfset redirectTo(action="thankyou")>
		<cfelse>
			<cfdump var="#errormessagesfor(objectName='survey')#">
		</cfif>
	</cffunction>

	<cffunction name="report">
		<cfif NOT isDefined("param.event")>
			<cfset params.event = event>
		</cfif>
		<cfset data = model("Conferencesurvey").findall(where="event='#params.event#'")>
	</cffunction>

	<cffunction name="getSum">
	<cfargument name="question" required="true" type="string">
	<cfargument name="event" default="#params.event#">
	<cfset var loc = structNew()>
		<cfset loc.sum = model("Conferencesurvey").getSum(arguments.question,arguments.event)>
	<cfreturn loc.sum>
	</cffunction>

	<cffunction name="getCount">
	<cfargument name="question" required="true" type="string">
	<cfargument name="answer" required="true" type="string">
	<cfargument name="event" default="#params.event#">
	<cfset var loc = structNew()>
		<cfset loc.count = model("Conferencesurvey").getCount(arguments.question,arguments.answer,arguments.event)>
	<cfreturn loc.count>
	</cffunction>

	<cffunction name="getAvg">
	<cfargument name="question" required="true" type="string">
	<cfargument name="event" default="#params.event#">
	<cfset var loc = structNew()>
		<cfset loc.sum = model("Conferencesurvey").getAvg(arguments.question,arguments.event)>
	<cfreturn loc.sum>
	</cffunction>

	<cffunction name="getComments">
	<cfargument name="question" required="true" type="string">
	<cfargument name="event" default="#params.event#">
	<cfset var loc = structNew()>
		<cfset loc.sum = model("Conferencesurvey").getComments(arguments.question,arguments.event)>
	<cfreturn loc.sum>
	</cffunction>

	<cffunction name="all">
		<cfif isDefined("params.id")>
			<cfset surveys=model("Conferencesurvey").getAllSurveys(event=params.event,id=params.id)>
		<cfelse>
			<cfset surveys=model("Conferencesurvey").getAllSurveys(event=params.event)>
		</cfif>
	</cffunction>


</cfcomponent>