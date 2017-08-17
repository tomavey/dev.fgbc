<h1>Your Registrations</h1>

<cfoutput>
#includePartial('invoice')#				
<cfif gotRights("office")>
#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this invoice", action="edit", key=invoice.id)#
</cfif>
</cfoutput>
