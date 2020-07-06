<div class="eachItemShown">
<h1>Create new equip registration</h1>

<cfoutput>

			#errorMessagesFor("registration")#
	
			#startFormTag(action="create")#
		
			#includePartial("form")#
			
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>