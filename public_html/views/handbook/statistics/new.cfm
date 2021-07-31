<div class="span10">
	<cfif isdefined("params.key")>
		<h1>Create new statistical record for <br/><cfoutput>#thisOrg.selectName#</cfoutput></h1>
	<cfelse>
		<h1>Create new statistical record:</h1>
	</cfif>
	
	<cfoutput>
	
				#errorMessagesFor("handbookstatistic")#
		
				#startFormTag(action="create")#
			
				#includePartial(partial="form")#	
						
				#submitTag()#
					
				#endFormTag()#
				
	
	#linkTo(text="Return to the listing", action="index")#
	</cfoutput>
</div>
