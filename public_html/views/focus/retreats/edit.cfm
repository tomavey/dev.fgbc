<cfoutput>

<h1>Editing #retreat.regid#</h1>


			#errorMessagesFor("retreat")#
	
			#startFormTag(action="update", key=params.key, multipart="true")#

			#putFormTag()#		
			
			#includePartial('form')#					
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
