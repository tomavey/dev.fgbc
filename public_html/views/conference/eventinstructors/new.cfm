<h1>Create a New Event/Instructor Link:</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>



			#errorMessagesFor("eventinstructor")#

			#startFormTag(action="create")#

			#includePartial("form")#

			#submitTag()#

			#endFormTag()#



#linkTo(text="Return to the listing", action="index")#
</cfoutput>
