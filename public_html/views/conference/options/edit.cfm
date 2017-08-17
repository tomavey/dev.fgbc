<div class="eachItemShown">
<cfoutput>
<p>
#linkTo(text="Return to the listing", action="index")#
</p>
			#errorMessagesFor("option")#
	
			#startFormTag(action="update", key=params.key)#
				
				#putFormTag()#

				#includePartial("form")#
			
				#submitTag()#
				
			#endFormTag()#
			
</cfoutput>
</div>