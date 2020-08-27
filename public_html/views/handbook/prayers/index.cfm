<cfparam name="prayForOrganizations" type="query">
<cfparam name="prayForPeople" type="query">
<cfparam name="params.issubscribed" default="false">
<cfset body = urlEncodedFormat('"I thank my God every time I remember you.
In all my prayers for all of you, I always pray with joy
because of your partnership in the gospel from the first day until now,
being confident of this, that he who began a good work in you will carry it on to completion until the day of Christ Jesus.
Phil 1:3-6
')>

<cfif params.action is "thisweek">
  <cfset request.reference = "this week">
<cfelse>
  <cfset request.reference = "today">
</cfif>  

<h1>Welcome to the FGBC Prayer Page</h1>
<cfoutput>
<p>
Thanks so much for your commitment to pray for the churches, ministries and minsters in the Fellowship of Grace Brethren.  We encourage you to take some time to pray for these people #request.reference#.
</p>

<cfif params.action is "thisweek">
	<cfset praykey = "prayweekly">
	<cfset timeframe = "weekly">
<cfelse>
	<cfset praykey = "praydaily">
	<cfset timeframe = "daily">
</cfif>

<div class="well">

<cfif params.isSubscribed>
<p>You are subscribed to #timeframe# prayer reminders.</p>
<cfelse>
<p>Would you like to subscribe to #timeframe# prayer reminders?</p>
</cfif>
</cfoutput>
<cfoutput>
<cfif params.isSubscribed>
		#linkTo(
				text="Un-Subscribe me", 
				controller="handbookSubscribes", 
				action="unsubscribe", 
				key=praykey, 
				title="Stop receiving prayer reminders via email.", 
				class="btn tooltip2"
				)#
<cfelse>				
		#linkTo(
				text="Subscribe me",
				controller="handbookSubscribes", 
				action=praykey, 
				title="Receive prayer reminders to #session.auth.email#.", 
				class="btn tooltip2"
				)#
</cfif>				
</cfoutput>
</div>

<div class="postbox" id="maininfo">

<cfif gotRights("superadmin,office") and params.action is "index">
  <cfoutput>
    #linkTo(text="Reset prayer dates", action="setPrayerDates", class="btn")#
    <p>Last reset was #dateformat(prayForOrganizations.updatedat)#</p>
  </cfoutput>
</cfif>

<h2>Churches and Ministries</h2>


<ul>
  <cfoutput query="prayForOrganizations" group="week">
  	<cfset subject = urlEncodedFormat("I am praying for #name# today!")>
    <li>Week No: #week#
      <ul>
        <cfoutput>
        <li>
          <cftry>
            <span class="dayofweek">#dayOfWeekAsString(dayofweek)#</span>
			<cfcatch>#dayofweek#</cfcatch>
          </cftry> - 
		  #linkTo(
				text=left("#name#: #org_city# #state_mail_abbrev#",50), 
				controller="handbook.organizations",
				action="show", 
				key=itemid, 
				class="ajaxclickable tooltip2", 
				title="Click to show #name# in the center panel.", 
				onlyPath=false
				)#
	     #mailTo(
     		emailaddress='#email#?subject=#subject#&body=#body#',
     		name='<i class="icon-envelope"></i>',
			class="tooltip2",
			title="Send a greeting to #name#"
     		)#

			 </li>
        </cfoutput>
      </ul>
    </li>
  </cfoutput>
</ul>

<h2>Ministers</h2>
<ul>
  <cfoutput query="prayForPeople" group="week">
    <li>Week No: #week#
      <ul>
        <cfoutput group="itemid">
		<cfset subject = urlEncodedFormat("#fname#... praying for you today!")>
        <li>
          <cftry>
            <span class="dayofweek">#dayOfWeekAsString(dayofweek)#</span>
			<cfcatch>#dayofweek#</cfcatch>
          </cftry>
		  - 
		  #linkTo(
				text=left("#fullname#; #city#, #state_mail_abbrev#",50), 
				controller="handbook.people",
				action="show", 
				key=itemid, 
				class="ajaxclickable tooltip2", 
				title="Click to show #fullname# in the center panel.", 
				onlyPath=false
				)#
	     #mailTo(
     		emailaddress='#email#?subject=#subject#&body=#body#',
     		name='<i class="icon-envelope"></i>',
			class="tooltip2",
			title="Send a greeting to #fname#"
     		)#
		 </li>
        </cfoutput>
      </ul>
    </li>
  </cfoutput>
</ul>
</div>