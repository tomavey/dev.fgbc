<!--- <cfdump var="#invoice.properties()#"><cfabort> --->

<h1>Your Registrations</h1>

<cfoutput>
#includePartial('invoice')#				
<cfif gotRights("office")>
  #linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this invoice", action="edit", key=invoice.id)# | #linkto(text="Pay this invoice", controller="focus.invoices", action="payonline", key=params.key, params="sendNotice=false")#
  <cfif isValid('email',invoice.agent)>
    <cftry>
      | 
      <cfset paylink="https://charisfellowship.us/focus/payonline/#params.key#?sendNotice=false">
      <a href="mailto:#invoice.agent#?subject=Pay%20for%20your%20registration%20online.&body=#paylink#" title="Send Pay Link to #invoice.agent#" class="text-center">
        Send Pay Link to #invoice.agent#
      </a>
    <cfcatch></cfcatch>
    </cftry>
  </cfif>
</cfif>
</cfoutput>
