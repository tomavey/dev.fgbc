<div class="container card card-charis">

<cfoutput>

			#errorMessagesFor("job")#

			#putFormTag()#
	
			#startFormTag(action="update", key=params.key)#
		
			#includePartial('form')#	
								
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>
