<cfparam name="churches" type="query">
<cfparam name="churchesPerWeek" type="numeric">
<cfset count = 1>
<cfset countEachWeek = 1>

<h3>Week #1</h3>
<cfoutput query="churches">
<cfif NOT currentrow MOD churchesPerWeek>
<h3>Week ###currentrow/churchesPerWeek+1#</h3>
</cfif>
<cfset city = unrepeatCity(org_city,name)>
#gbcIt(name)#; #city#<cfif len(city)>, </cfif>#state_mail_abbrev#<br/>
</cfoutput>
<br/>