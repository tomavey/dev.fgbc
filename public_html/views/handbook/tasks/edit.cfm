<div class="span10 offset1">
<cfoutput>

<h1>Editing #handbooktask.title#</h1>

#includePartial(partial="showFlash")#


#ckeditor()#			
			
			#errorMessagesFor("handbooktask")#
	
			#startFormTag(action="update", key=params.key)#
		
			#includePartial(partial="form")#															
				
				
				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>