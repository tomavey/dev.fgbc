<h1>Editing retreat</h1>

<cfoutput>

			#errorMessagesFor("retreat")#
	
			#startFormTag(action="update", key=params.key, multipart="true")#

			#putFormTag()#		
			
			#includePartial('form')#					
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
