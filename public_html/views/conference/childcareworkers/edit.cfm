<h1>Editing Child Care Worker</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

#ckeditor()#
			
			#errorMessagesFor("childcareworkers")#
	
			#startFormTag(action="update", key=params.key)#
		
			#includePartial(partial="form")#	
				
			#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
