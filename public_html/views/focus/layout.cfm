<cfparam name="FocusPageBeingUpdated" default=false>
<cfif getSetting("FocusPageBeingUpdated") && !gotRights("office")>
  <cfset FocusPageBeingUpdated = true>
</cfif>

<cfinclude template="_header.cfm">
<cfif !FocusPageBeingUpdated>
  <cfinclude template="_navigation.cfm">
  <cfinclude template="_logo.cfm">
  <cfinclude template="_content.cfm">
<cfelse>
  <h1 style="text-align:center">the Focus Retreat Web Page is being updated!</h1>
  <br/>
  <h3 style="text-align:center">Check back soon.</h3>  
</cfif>
<cfinclude template="_footer.cfm">