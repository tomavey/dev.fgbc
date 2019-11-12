<div class="postbox">
<h1>Editing fgbc_ministry</h1>

<cfoutput>

			#errorMessagesFor("ministry")#
	
			#startFormTag(action="update", key=params.key)#

			#includePartial("form")#
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>