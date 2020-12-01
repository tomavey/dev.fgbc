<h1>Copying Instructor</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>


			#errorMessagesFor("instructor")#

			#startFormTag(action="create")#

			#putFormTag()#

			#includePartial(partial="form")#


				#submitTag()#

			#endFormTag()#



#linkTo(text="Return to the listing", action="index")#
</cfoutput>
