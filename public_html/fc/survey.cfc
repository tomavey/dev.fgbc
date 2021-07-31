<cfcomponent output="no">
<cfset dsn = "mysqlcf_fgbc_main">

<cffunction name="put_cel_survey" output="no">
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
<cfargument name="childcare" type="numeric">
<cfargument name="childcarecomments" type="string">
<cfargument name="kidskonf" type="numeric">
<cfargument name="kidskonfcomments" type="string">
<cfargument name="delegates" type="numeric">
<cfargument name="delegatescomments" type="string">
<cfargument name="gospel" type="string">
<cfargument name="spiritual" type="string">
<cfargument name="apply" type="string">
<cfargument name="commentsapply" type="string">
<cfargument name="suggestions" type="string">

      <cfquery datasource="#dsn#">
            INSERT INTO cel_survey
                  ( AGE0,AGE10,AGE20,AGE30,AGE40,AGE50,AGE60,ATTEND,PAID,COST,CELEBRATIONS,SPONSOREDLUNCHEONS,THEME,THEMECOMMENTS,LOCATION,LOCATIONCOMMENTS,SPEAKERS,SPEAKERSCOMMENTS,MUSIC,MUSICCOMMENTS,SCHEDULE,SCHEDULECOMMENTS,LUNCHEONS,LUNCHEONSCOMMENTS,BUDDHIST,BUDDHISTCOMMENTS,HINDU,HINDUCOMMENTS,BASEBALL,BASEBALLCOMMENTS,CHILDCARE,CHILDCARECOMMENTS,KIDSKONF,KIDSKONFCOMMENTS,DELEGATES,DELEGATESCOMMENTS,GOSPEL,SPIRITUAL,APPLY,COMMENTSAPPLY,SUGGESTIONS )
            VALUES (
                  <cfqueryparam value='#arguments.age0#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.age10#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.age20#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.age30#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.age40#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.age50#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.age60#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.attend#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.paid#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.cost#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.celebrations#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.sponsoredluncheons#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.theme#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.themecomments#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.location#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.locationcomments#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.speakers#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.speakerscomments#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.music#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.musiccomments#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.schedule#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.schedulecomments#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.luncheons#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.luncheonscomments#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.buddhist#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.buddhistcomments#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.hindu#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.hinducomments#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.baseball#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.baseballcomments#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.childcare#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.childcarecomments#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.kidskonf#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.kidskonfcomments#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.delegates#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#arguments.delegatescomments#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.gospel#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.spiritual#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.apply#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.commentsapply#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#arguments.suggestions#' CFSQLType="CF_SQL_CHAR">
                  )
      </cfquery>
      <cfquery datasource="#dsn#" name="data">
            SELECT max(id) as id
            FROM cel_survey
      </cfquery>
<cfreturn data.id>
</cffunction>

<cffunction name="update_cel_survey" output="no">
<cfargument name="id" type="numeric">
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
<cfargument name="childcare" type="numeric">
<cfargument name="childcarecomments" type="string">
<cfargument name="kidskonf" type="numeric">
<cfargument name="kidskonfcomments" type="string">
<cfargument name="delegates" type="numeric">
<cfargument name="delegatescomments" type="string">
<cfargument name="gospel" type="string">
<cfargument name="spiritual" type="string">
<cfargument name="apply" type="string">
<cfargument name="commentsapply" type="string">
<cfargument name="suggestions" type="string">

      <cfquery datasource="#dsn#">
            UPDATE cel_survey
            SET
                  age0 = <cfqueryparam value='#arguments.age0#' CFSQLType="CF_SQL_INTEGER">,
                  age10 = <cfqueryparam value='#arguments.age10#' CFSQLType="CF_SQL_INTEGER">,
                  age20 = <cfqueryparam value='#arguments.age20#' CFSQLType="CF_SQL_INTEGER">,
                  age30 = <cfqueryparam value='#arguments.age30#' CFSQLType="CF_SQL_INTEGER">,
                  age40 = <cfqueryparam value='#arguments.age40#' CFSQLType="CF_SQL_INTEGER">,
                  age50 = <cfqueryparam value='#arguments.age50#' CFSQLType="CF_SQL_INTEGER">,
                  age60 = <cfqueryparam value='#arguments.age60#' CFSQLType="CF_SQL_INTEGER">,
                  attend = <cfqueryparam value='#arguments.attend#' CFSQLType="CF_SQL_CHAR">,
                  paid = <cfqueryparam value='#arguments.paid#' CFSQLType="CF_SQL_CHAR">,
                  cost = <cfqueryparam value='#arguments.cost#' CFSQLType="CF_SQL_CHAR">,
                  celebrations = <cfqueryparam value='#arguments.celebrations#' CFSQLType="CF_SQL_INTEGER">,
                  sponsoredluncheons = <cfqueryparam value='#arguments.sponsoredluncheons#' CFSQLType="CF_SQL_INTEGER">,
                  theme = <cfqueryparam value='#arguments.theme#' CFSQLType="CF_SQL_INTEGER">,
                  themecomments = <cfqueryparam value='#arguments.themecomments#' CFSQLType="CF_SQL_CHAR">,
                  location = <cfqueryparam value='#arguments.location#' CFSQLType="CF_SQL_INTEGER">,
                  locationcomments = <cfqueryparam value='#arguments.locationcomments#' CFSQLType="CF_SQL_CHAR">,
                  speakers = <cfqueryparam value='#arguments.speakers#' CFSQLType="CF_SQL_INTEGER">,
                  speakerscomments = <cfqueryparam value='#arguments.speakerscomments#' CFSQLType="CF_SQL_CHAR">,
                  music = <cfqueryparam value='#arguments.music#' CFSQLType="CF_SQL_INTEGER">,
                  musiccomments = <cfqueryparam value='#arguments.musiccomments#' CFSQLType="CF_SQL_CHAR">,
                  schedule = <cfqueryparam value='#arguments.schedule#' CFSQLType="CF_SQL_INTEGER">,
                  schedulecomments = <cfqueryparam value='#arguments.schedulecomments#' CFSQLType="CF_SQL_CHAR">,
                  luncheons = <cfqueryparam value='#arguments.luncheons#' CFSQLType="CF_SQL_INTEGER">,
                  luncheonscomments = <cfqueryparam value='#arguments.luncheonscomments#' CFSQLType="CF_SQL_CHAR">,
                  buddhist = <cfqueryparam value='#arguments.buddhist#' CFSQLType="CF_SQL_INTEGER">,
                  buddhistcomments = <cfqueryparam value='#arguments.buddhistcomments#' CFSQLType="CF_SQL_CHAR">,
                  hindu = <cfqueryparam value='#arguments.hindu#' CFSQLType="CF_SQL_INTEGER">,
                  hinducomments = <cfqueryparam value='#arguments.hinducomments#' CFSQLType="CF_SQL_CHAR">,
                  baseball = <cfqueryparam value='#arguments.baseball#' CFSQLType="CF_SQL_INTEGER">,
                  baseballcomments = <cfqueryparam value='#arguments.baseballcomments#' CFSQLType="CF_SQL_CHAR">,
                  childcare = <cfqueryparam value='#arguments.childcare#' CFSQLType="CF_SQL_INTEGER">,
                  childcarecomments = <cfqueryparam value='#arguments.childcarecomments#' CFSQLType="CF_SQL_CHAR">,
                  kidskonf = <cfqueryparam value='#arguments.kidskonf#' CFSQLType="CF_SQL_INTEGER">,
                  kidskonfcomments = <cfqueryparam value='#arguments.kidskonfcomments#' CFSQLType="CF_SQL_CHAR">,
                  delegates = <cfqueryparam value='#arguments.delegates#' CFSQLType="CF_SQL_INTEGER">,
                  delegatescomments = <cfqueryparam value='#arguments.delegatescomments#' CFSQLType="CF_SQL_CHAR">,
                  gospel = <cfqueryparam value='#arguments.gospel#' CFSQLType="CF_SQL_CHAR">,
                  spiritual = <cfqueryparam value='#arguments.spiritual#' CFSQLType="CF_SQL_CHAR">,
                  apply = <cfqueryparam value='#arguments.apply#' CFSQLType="CF_SQL_CHAR">,
                  commentsapply = <cfqueryparam value='#arguments.commentsapply#' CFSQLType="CF_SQL_CHAR">,
                  suggestions = <cfqueryparam value='#arguments.suggestions#' CFSQLType="CF_SQL_CHAR">
            WHERE id = <cfqueryparam value='#form.id#' CFSQLType="CF_SQL_INTEGER">
      </cfquery>
</cffunction>

<cffunction name="get_cel_survey" output="no">
<cfargument name="id" type="numeric">
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
<cfargument name="childcare" type="numeric">
<cfargument name="childcarecomments" type="string">
<cfargument name="kidskonf" type="numeric">
<cfargument name="kidskonfcomments" type="string">
<cfargument name="delegates" type="numeric">
<cfargument name="delegatescomments" type="string">
<cfargument name="gospel" type="string">
<cfargument name="spiritual" type="string">
<cfargument name="apply" type="string">
<cfargument name="commentsapply" type="string">
<cfargument name="suggestions" type="string">
<cfargument name="datetime" type="date">
<cfargument name="orderby" default="id">
<cfargument name="direction" default="asc">

      <cfquery datasource="#dsn#" name="data">
            SELECT *
            FROM cel_survey
            WHERE 0=0
            <cfif isdefined("arguments.id")>
                  AND id = <cfqueryparam value='#arguments.id#' CFSQLType='CF_SQL_INTEGER'>
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
            <cfif isdefined("arguments.commentsapply")>
                  AND commentsapply = <cfqueryparam value='#arguments.commentsapply#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.suggestions")>
                  AND suggestions = <cfqueryparam value='#arguments.suggestions#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.datetime")>
                  AND datetime = <cfqueryparam value='#arguments.datetime#' CFSQLType='CF_SQL_DATE'>
            </cfif>
            ORDER BY '#arguments.orderby#' '#arguments.direction#'
      </cfquery>
<cfreturn data>
</cffunction>

<cffunction name="delete_cel_survey" output="no">
<cfargument name="id" required="yes" type="numeric">
      <cfquery datasource="#dsn#">
            DELETE FROM cel_survey
            WHERE id = <cfqueryparam value='#arguments.id#' CFSQLType='CF_SQL_INTEGER'>
            LIMIT 1
      </cfquery>
</cffunction>

<cffunction name="getsurveycount">
<cfargument name="table" default="cel_survey">
	<cfquery datasource="#dsn#" name="data">
	SELECT id
	FROM #arguments.table#
	</cfquery>
	<cfreturn data.recordcount>
</cffunction>

<cffunction name="getthissummary">
<cfargument name="field">
<cfargument name="operator">
<cfargument name="table" default="cel_survey">
	<cfquery datasource="#dsn#" name="data">
		SELECT #arguments.operator#(#arguments.field#) as #arguments.field#
		FROM #arguments.table#
	</cfquery>	
	<cfreturn data>
</cffunction>

<cffunction name="getthisanswer">
<cfargument name="question">
<cfargument name="answer">
	<cfquery datasource="#dsn#" name="data">
		SELECT count(#arguments.question#) as answercount
		FROM cel_survey
		WHERE #arguments.question# = '#arguments.answer#'
	</cfquery>
	<cfreturn data>	
</cffunction>	

<cffunction name="getcost">
	<cfquery datasource="#dsn#" name="data">
		SELECT cost
		FROM cel_survey
		WHERE cost <> ""
	</cfquery>		
	<cfreturn data>
</cffunction>	

<cffunction name="getthiscomments">
<cfargument name="question">
	<cfquery datasource="#dsn#" name="data">
		SELECT #arguments.question#comments as comments
		FROM cel_survey
	</cfquery>
	<cfreturn data>
</cffunction>		
	
</cfcomponent>