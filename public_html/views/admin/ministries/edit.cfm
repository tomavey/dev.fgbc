<div class="postbox">
<cfoutput>

<h1>Edit #ministry.name#</h1>

			#errorMessagesFor("ministry")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#		

			#includePartial("form")#
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>