<div class="colorbox container">

<cfoutput>

			#errorMessagesFor("job")#
	
			#startFormTag(action="update", key=params.key)#
		
			#putFormTag()#		

			#includePartial('form')#	
								
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>
