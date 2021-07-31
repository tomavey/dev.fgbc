<div class="container">
<h1>Editing Message</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>


			#errorMessagesFor("sendemails")#

			#startFormTag(action="update", key=params.key)#


			#includePartial(partial="form")#



				#submitTag()#

			#endFormTag()#



#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>