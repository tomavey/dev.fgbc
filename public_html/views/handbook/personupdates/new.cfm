<h1>Create new handbookpersonupdate</h1>

<cfoutput>

			#errorMessagesFor("handbookperson")#
	
			#startFormTag(action="create")#
		
			#includePartial(partial="/handbookpeople/form")#	

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
