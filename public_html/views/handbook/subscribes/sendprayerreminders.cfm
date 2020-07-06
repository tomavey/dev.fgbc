<cfparam name="prayForOrganizations" type="query">
<cfparam name="prayForPeople" type="query">
<cfparam name="subject" default="Prayed for you today!">
<cfparam name="message" default="Praying for you.">

<cfif isDefined("params.key") and params.key is "test">
<cfoutput>#linkto(text="Send to subscribers", key="go", class="btn")#</cfoutput>
</cfif>

<cfif params.action contains "today">
	 <cfset params.timeframe = "today">
<cfelse>
	 <cfset params.timeframe = "this week">
</cfif>	 

<cfoutput>
<h3>Pray for these ministries #params.timeframe#...</h3>
</cfoutput>

<ul>
  <cfif prayForOrganizations.recordcount>
		<cfset message = urlEncodedFormat('"being confident of this, that he who began a good work in you will carry it on to completion until the day of Christ Jesus." Phil 1:6')>
    <cfoutput query="prayForOrganizations">
     	<cfset subject = urlEncodedFormat("Praying for #name# today...")>
	    <li>#name#; #org_city#, #state_mail_abbrev# - #phone# - #mailTo(name="Send a note", emailAddress="#email#?subject=#subject#&body=#message#")# </li>
    </cfoutput>
  <cfelse>
  		  No prayer reminders for ministries today!
  </cfif>
</ul>

<p>&nbsp;</p>

<cfoutput>
<h3>Pray for these ministers #params.timeframe#...</h3>
</cfoutput>

<ul>
  <cfif prayForPeople.recordcount>
	<cfset message = urlEncodedFormat('"being confident of this, that he who began a good work in you will carry it on to completion until the day of Christ Jesus." Phil 1:6')>

    <cfoutput query="prayForPeople" group="itemid">
   	<cfset subject = urlEncodedFormat("#fname# - I am praying for you today!")>
	    <li>#fullname# 
				#phone#
				#mailTo(
					   name="Send a note", 
					   emailAddress="#email#?subject=#subject#&body=#message#"
							)# 
			<ul>
				<li class="positioninfo">#getpositions(itemid)#</li>
			</ul>					
						
		</li>
    </cfoutput>
  <cfelse>
  		  No prayer reminders for ministers today!
  </cfif>
</ul>

