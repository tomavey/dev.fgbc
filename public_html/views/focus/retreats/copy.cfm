<h1>Copying retreat</h1>

<cfoutput>

			#errorMessagesFor("retreat")#
	
			#startFormTag(action="create", key=params.key, multipart="true")#
		
			#includePartial('form')#					
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
