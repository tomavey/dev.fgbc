<cfif isdefined("params.key")>
	<h1>Create new stat for <br/><cfoutput>#thisOrg.selectName#</cfoutput></h1>
<cfelse>
	<h1>Create new stat:</h1>
</cfif>

<cfoutput>

			#errorMessagesFor("handbookstatistic")#
	
			#startFormTag(action="create")#
		
			#includePartial("form")#	
					
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
