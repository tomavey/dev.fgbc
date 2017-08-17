<cfoutput>
<div class="row-fluid well contentStart contentBg">
#ckeditor()#
<div class="span12">
<h1>Editing content</h1>


			#errorMessagesFor("content")#
	
			#startFormTag(action="update", key=params.key)#
		
			#putFormTag()#		

			#includePartial("form")#

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</div>
</div>
</cfoutput>
