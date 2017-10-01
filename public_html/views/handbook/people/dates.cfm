<cfparam name="datesSorted" type="query">
<cfparam name="datesThisWeek" type="query">
<cfparam name="useDayOfWeek" default="false">
<cfparam name="params.isSubscribed" default="false">
<cfset count = 1>
<cfset emailall = "">
<cfoutput>
<h1>#capitalize(pluralize(params.dateType))#</h1>

<div class="well">
<cfif params.isSubscribed>
<p>You are subscribed to birthday and anniversary notifications.</p>
<cfelse>
<p>Would you like to subscribe to birthday and anniversary notifications?</p>
</cfif>
<cfoutput>
<cfif params.isSubscribed>
		#linkTo(
				text="Un-Subscribe me",
				route="handbookUnSubscribeMe", 
				key="dates", 
				title="Stop receiving notices of updates via email.", 
				class="btn tooltip2"
				)#
<cfelse>				
		#linkTo(
				text="Subscribe me",
				route="handbookSubscribeMe",
				title="Receive daily notices of birthdays and anniversaries to #session.auth.email#.", 
				class="btn tooltip2"
				)#
</cfif>				
</cfoutput>
</div>
<cfif gotRights("office")>
#linkto(text="LIST BY AGE", action="datesByYear", key="birthday", class="btn")#
</cfif>
</cfoutput>
  <h3>Soon...</h3>

<cfset useDayOfWeek = "true">
<cfoutput query="datesthisweek" group="fullname">
<cfif isInHandbook(personid)>
	#includePartial("dates")#
     <cfset count = count + 1>
</cfif>    
</cfoutput>

<cfoutput query="datesSorted" group="#params.dateType#monthnumber">
<cfif isInHandbook(personid)>

<cfset dateInfo.month = '#params.dateType#monthnumber'>
<cfset dateInfo.month = evaluate(dateInfo.month)>

  <h3>#monthAsString(dateInfo.month)#</h3>

<cfset useDayOfWeek = "false">
  <cfoutput group="fullname">
  	#includePartial("dates")#
  	<cfset count = count + 1>
	<cfset emailall = emailall & "; " & handbookpersonemail>
  </cfoutput>
</cfif>
</cfoutput>  

<cfoutput>
  <p>
  Count = #count#</p>
</cfoutput>

<cfif gotRights("superadmin")>
<cfset emailall = replace(emailall,"; ","","one")>
<p><cfoutput>#emailall#</cfoutput></p>
</cfif>