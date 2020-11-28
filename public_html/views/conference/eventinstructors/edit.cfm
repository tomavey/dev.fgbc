<h1>Editing Event/instructor link</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>


			#errorMessagesFor("eventinstructor")#

			#startFormTag(action="update", key=params.key)#

			#includePartial(partial="form")#

			#submitTag()#

			#endFormTag()#



#linkTo(text="Return to the listing", action="index")#
</cfoutput>
