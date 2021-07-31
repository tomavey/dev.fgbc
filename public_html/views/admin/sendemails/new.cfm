<div class="container">
<h1>Create a New Message</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

			#errorMessagesFor("sendemails")#

			#startFormTag(action="create")#

			#includePartial(partial="form")#

			#submitTag()#

			#endFormTag()#



#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>