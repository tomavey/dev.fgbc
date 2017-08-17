
<h1>Editing event</h1>
<div class="eachItemShown new">
<cfoutput>

			#errorMessagesFor("event")#
	
			#startFormTag(action="update", key=params.key)#
			
			#hiddenField(objectName="event", property='id')#
					
			#putFormTag()#		

			#includePartial("form")#
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>