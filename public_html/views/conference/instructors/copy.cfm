<h1>Copying Instructor</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>


			#errorMessagesFor("instructor")#

			#startFormTag(action="create")#

			#putFormTag()#

			#includePartial("form")#


				#submitTag()#

			#endFormTag()#



#linkTo(text="Return to the listing", action="index")#
</cfoutput>
