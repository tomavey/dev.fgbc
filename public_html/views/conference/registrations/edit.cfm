<div class="eachItemShown">
<h1>Editing Registration.</h1>

<cfoutput>

#linkTo(text="Return to the listing", action="index")#

			#errorMessagesFor("registration")#

			#startFormTag(action="#formaction#")#

			#putFormTag()#

			#includePartial("form")#

			#submitTag()#

			#endFormTag()#


</cfoutput>
</div>
