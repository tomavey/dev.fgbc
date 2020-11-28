<cfoutput>
<div class="container">
#ckeditor()#
<div class="span12">
<h1>Create new content</h1>


			#errorMessagesFor("content")#
	
			#startFormTag(action="create")#
		
			#includePartial(partial="form")#

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#

</div>
</div>

</cfoutput>
