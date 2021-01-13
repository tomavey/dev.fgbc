//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset table("equip_surveys")>
	</cffunction>

	<cfset dsn = "fgbc_main_3">

	<cffunction name="getsum" output="no">
	<cfargument name="question" required="yes" type="string">
	<cfargument name="event" required="yes" type="string">
	<cfquery datasource="fgbc_main_3" name="data">
		SELECT sum(#arguments.question#) as count
	    FROM equip_surveys
	    WHERE 0 = 0
	    AND event = "#arguments.event#"
	    AND #arguments.question# <> "" 
	    AND #arguments.question# <> 0
	</cfquery>    
	<cfreturn val(data.count)>
	</cffunction>

	<cffunction name="getcount" output="no">
	<cfargument name="question" required="yes" type="string">
	<cfargument name="answer" required="yes" type="string">
	<cfargument name="event" required="yes" type="string">
	<cfset var results=structnew()>
	<cfquery datasource="fgbc_main_3" name="data">
		SELECT #arguments.question#
	    FROM equip_surveys
	    WHERE 0 = 0
	    AND event = "#arguments.event#"
	    AND #arguments.question# LIKE '%#arguments.answer#%'
	</cfquery>    

	<cfset results.count = data.recordcount>

	<cfquery datasource="fgbc_main_3" name="total">
		SELECT *
	    FROM equip_surveys
	    WHERE 0 = 0
	    AND event = "#arguments.event#"
	</cfquery>    

	<cfset results.total = total.recordcount>

	<cftry>
	<cfset results.percent = (results.count/results.total)*100>
	<cfcatch><cfset results.percent = 0></cfcatch></cftry>

	<cfreturn results>
	</cffunction>

	<cffunction name="getavg" output="no">
	<cfargument name="question" required="yes" type="string">
	<cfargument name="event" required="yes" type="string">
	<cfquery datasource="#dsn#" name="data">
		SELECT avg(#arguments.question#) as average
	    FROM equip_surveys
	    WHERE 0 = 0
	    AND event = "#arguments.event#"
	    AND #arguments.question# <> "" 
	    AND #arguments.question# <> 0
	</cfquery>    
	<cfreturn data.average>
	</cffunction>

	<cffunction name="getcomments" output="no">
	<cfargument name="question" required="yes" type="string">
	<cfargument name="event" required="yes" type="string">
	<cfquery datasource="#dsn#" name="comments">
		SELECT #arguments.question#, id
	    FROM equip_surveys
	    WHERE 0 = 0
	    AND event = "#arguments.event#"
	    AND #arguments.question# <> ""
	</cfquery>
	<cfreturn comments>
	</cffunction>

	<cffunction name="getAllSurveys" output="no">
	<cfargument name="id" type="numeric">
	<cfargument name="event" required="true">
	<cfargument name="age0" type="numeric">
	<cfargument name="age10" type="numeric">
	<cfargument name="age20" type="numeric">
	<cfargument name="age30" type="numeric">
	<cfargument name="age40" type="numeric">
	<cfargument name="age50" type="numeric">
	<cfargument name="age60" type="numeric">
	<cfargument name="attend" type="string">
	<cfargument name="paid" type="string">
	<cfargument name="cost" type="string">
	<cfargument name="celebrations" type="numeric">
	<cfargument name="sponsoredluncheons" type="numeric">
	<cfargument name="theme" type="numeric">
	<cfargument name="themecomments" type="string">
	<cfargument name="location" type="numeric">
	<cfargument name="locationcomments" type="string">
	<cfargument name="speakers" type="numeric">
	<cfargument name="speakerscomments" type="string">
	<cfargument name="music" type="numeric">
	<cfargument name="musiccomments" type="string">
	<cfargument name="schedule" type="numeric">
	<cfargument name="schedulecomments" type="string">
	<cfargument name="luncheons" type="numeric">
	<cfargument name="luncheonscomments" type="string">
	<cfargument name="buddhist" type="numeric">
	<cfargument name="buddhistcomments" type="string">
	<cfargument name="hindu" type="numeric">
	<cfargument name="hinducomments" type="string">
	<cfargument name="baseball" type="numeric">
	<cfargument name="baseballcomments" type="string">
	<cfargument name="rea" type="numeric">
	<cfargument name="reacomments" type="string">
	<cfargument name="wecaremiamivalley" type="numeric">
	<cfargument name="wecaremiamivalleycomments" type="string">
	<cfargument name="townhall" type="numeric">
	<cfargument name="townhallcomments" type="string">
	<cfargument name="childcare" type="numeric">
	<cfargument name="childcarecomments" type="string">
	<cfargument name="kidskonf" type="numeric">
	<cfargument name="kidskonfcomments" type="string">
	<cfargument name="delegates" type="numeric">
	<cfargument name="delegatescomments" type="string">
	<cfargument name="gospel" type="string">
	<cfargument name="spiritual" type="string">
	<cfargument name="apply" type="string">
	<cfargument name="applycomments" type="string">
	<cfargument name="suggestions" type="string">
	<cfargument name="author" type="string">
	<cfargument name="datetime" type="date">
	<cfargument name="orderby" default="id">
	<cfargument name="direction" default="asc">

      <cfquery datasource="#dsn#" name="data">
            SELECT *
            FROM equip_surveys
            WHERE 0=0
            <cfif isdefined("arguments.id")>
                  AND id = <cfqueryparam value='#arguments.id#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.event")>
                  AND event = <cfqueryparam value='#arguments.event#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.age0")>
                  AND age0 = <cfqueryparam value='#arguments.age0#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.age10")>
                  AND age10 = <cfqueryparam value='#arguments.age10#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.age20")>
                  AND age20 = <cfqueryparam value='#arguments.age20#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.age30")>
                  AND age30 = <cfqueryparam value='#arguments.age30#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.age40")>
                  AND age40 = <cfqueryparam value='#arguments.age40#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.age50")>
                  AND age50 = <cfqueryparam value='#arguments.age50#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.age60")>
                  AND age60 = <cfqueryparam value='#arguments.age60#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.attend")>
                  AND attend = <cfqueryparam value='#arguments.attend#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.paid")>
                  AND paid = <cfqueryparam value='#arguments.paid#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.cost")>
                  AND cost = <cfqueryparam value='#arguments.cost#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.celebrations")>
                  AND celebrations = <cfqueryparam value='#arguments.celebrations#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.sponsoredluncheons")>
                  AND sponsoredluncheons = <cfqueryparam value='#arguments.sponsoredluncheons#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.theme")>
                  AND theme = <cfqueryparam value='#arguments.theme#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.themecomments")>
                  AND themecomments = <cfqueryparam value='#arguments.themecomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.location")>
                  AND location = <cfqueryparam value='#arguments.location#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.locationcomments")>
                  AND locationcomments = <cfqueryparam value='#arguments.locationcomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.speakers")>
                  AND speakers = <cfqueryparam value='#arguments.speakers#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.speakerscomments")>
                  AND speakerscomments = <cfqueryparam value='#arguments.speakerscomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.music")>
                  AND music = <cfqueryparam value='#arguments.music#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.musiccomments")>
                  AND musiccomments = <cfqueryparam value='#arguments.musiccomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.schedule")>
                  AND schedule = <cfqueryparam value='#arguments.schedule#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.schedulecomments")>
                  AND schedulecomments = <cfqueryparam value='#arguments.schedulecomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.luncheons")>
                  AND luncheons = <cfqueryparam value='#arguments.luncheons#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.luncheonscomments")>
                  AND luncheonscomments = <cfqueryparam value='#arguments.luncheonscomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.buddhist")>
                  AND buddhist = <cfqueryparam value='#arguments.buddhist#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.buddhistcomments")>
                  AND buddhistcomments = <cfqueryparam value='#arguments.buddhistcomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.hindu")>
                  AND hindu = <cfqueryparam value='#arguments.hindu#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.hinducomments")>
                  AND hinducomments = <cfqueryparam value='#arguments.hinducomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.baseball")>
                  AND baseball = <cfqueryparam value='#arguments.baseball#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.baseballcomments")>
                  AND baseballcomments = <cfqueryparam value='#arguments.baseballcomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.rea")>
                  AND rea = <cfqueryparam value='#arguments.rea#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.reacomments")>
                  AND reacomments = <cfqueryparam value='#arguments.reacomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.wecaremiamivalley")>
                  AND wecaremiamivalley = <cfqueryparam value='#arguments.wecaremiamivalley#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.wecaremiamivalleycomments")>
                  AND wecaremiamivalleycomments = <cfqueryparam value='#arguments.wecaremiamivalleycomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.townhall")>
                  AND townhall = <cfqueryparam value='#arguments.townhall#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.townhallcomments")>
                  AND townhallcomments = <cfqueryparam value='#arguments.townhallcomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.childcare")>
                  AND childcare = <cfqueryparam value='#arguments.childcare#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.childcarecomments")>
                  AND childcarecomments = <cfqueryparam value='#arguments.childcarecomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.kidskonf")>
                  AND kidskonf = <cfqueryparam value='#arguments.kidskonf#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.kidskonfcomments")>
                  AND kidskonfcomments = <cfqueryparam value='#arguments.kidskonfcomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.delegates")>
                  AND delegates = <cfqueryparam value='#arguments.delegates#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.delegatescomments")>
                  AND delegatescomments = <cfqueryparam value='#arguments.delegatescomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.gospel")>
                  AND gospel = <cfqueryparam value='#arguments.gospel#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.spiritual")>
                  AND spiritual = <cfqueryparam value='#arguments.spiritual#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.apply")>
                  AND apply = <cfqueryparam value='#arguments.apply#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.applycomments")>
                  AND applycomments = <cfqueryparam value='#arguments.applycomments#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.suggestions")>
                  AND suggestions = <cfqueryparam value='#arguments.suggestions#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.author")>
                  AND author = <cfqueryparam value='#arguments.author#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.datetime")>
                  AND datetime = <cfqueryparam value='#arguments.datetime#' CFSQLType='CF_SQL_DATE'>
            </cfif>
            ORDER BY #arguments.orderby# #arguments.direction#
      </cfquery>
<cfreturn data>
</cffunction>

<cffunction name="getAvgAge">
<cfargument name="event" required="yes">

	<cfset thiscount20 = getSum(question="AGE20",event=arguments.event)>
	<cfset thiscount30 = getSum(question="AGE30",event=arguments.event)>
	<cfset thiscount40 = getSum(question="AGE40",event=arguments.event)>
	<cfset thiscount50 = getSum(question="AGE50",event=arguments.event)>
	<cfset thiscount60 = getSum(question="AGE60",event=arguments.event)>

    <cfset totalcount = thiscount20 + thiscount30 + thiscount40 + thiscount50 + thiscount60>
    <cfset totalage = thiscount20*25 + thiscount30*35 + thiscount40*45 + thiscount50*55 + thiscount60*65>
    <cfset average = totalage/totalcount>

<cfreturn average>
</cffunction>

<cffunction name="getspread">
<cfargument name="question" required="yes" type="string">
<cfargument name="event" required="yes" type="string">
<cfquery datasource="#dsn#" name="data">
	SELECT *
    FROM equip_surveys
    WHERE 0 = 0
    AND event = "#arguments.event#"
    AND #arguments.question# <> "" 
    AND #arguments.question# <> 0
	ORDER BY #arguments.question# desc
</cfquery>    
<cfreturn data>
</cffunction>


</cfcomponent>
