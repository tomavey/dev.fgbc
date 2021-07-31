<div class="span10 offset1">
<h1>Create a new task</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

#ckeditor()#			
			
			#errorMessagesFor("handbooktask")#
	
			#startFormTag(action="create")#

			<div>#includePartial(partial="form")#</div>
		
			#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>