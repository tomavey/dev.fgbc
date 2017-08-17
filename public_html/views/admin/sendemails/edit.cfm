<div class="row-fluid well contentStart contentBg">
<h1>Editing Message</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>


			#errorMessagesFor("sendemails")#

			#startFormTag(action="update", key=params.key)#


			#includePartial("form")#



				#submitTag()#

			#endFormTag()#



#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>