<h1>Nomination for <cfoutput>#nominations.nomineeName#</cfoutput></h1>

<cfoutput>

#includePartial(partial="show")#				
#linkTo(text="Return to the listing", action="index")# 
<cfif isOffice()>
	| #linkTo(text="Edit this nominations", action="edit", key=nominations.id)#
</cfif>
</cfoutput>
