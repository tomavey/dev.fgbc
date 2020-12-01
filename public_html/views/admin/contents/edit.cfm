<cfoutput>
<div class="container">
	#ckeditor()#
	<h1>Editing content</h1>


		#errorMessagesFor("content")#

		#startFormTag(action="update", key=params.key)#

		#putFormTag()#		

		#includePartial(partial="form")#

		#submitTag()#
			
		#endFormTag()#
				

	#linkTo(text="Return to the listing", action="index")#
</div>
</cfoutput>
