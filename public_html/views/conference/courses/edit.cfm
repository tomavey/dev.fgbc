<h1>Editing Course/Workshop</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>
			
			#errorMessagesFor("course")#
	
			#startFormTag(action="update", key=params.key)#

			#hiddenField(objectName="course", property='id')#
		
			#putFormTag()#		

			#hiddenTagForKeyy()#

			#includePartial(partial="form")#														
				
			#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
