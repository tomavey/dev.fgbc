<h1>Create new retreat</h1>

<cfoutput>

			#errorMessagesFor("retreat")#
	
			#startFormTag(action="create", multipart="true")#
		
			#includePartial('form')#				

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
