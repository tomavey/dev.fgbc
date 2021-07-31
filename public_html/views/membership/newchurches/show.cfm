<h1>Showing new church</h1>

<cfoutput>

#includePartial(partial="showFlash")#

#includePartial(partial="show")#

<cfif isOffice()>				
#linkTo(text="Return to the listing", action="index")# 
| 
</cfif>
#linkTo(text="Edit this new church", action="edit", key="#newchurch.uuid#")#
</cfoutput>
