<cfparam name="formaction" default="create">
<div class="container">

<h1>Create a New home</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
			
			#errorMessagesFor("home")#
	
			#startFormTag(action=formaction)#
		
			#includePartial("form")#				
																
			#submitTag(class="btn btn-primary btn-lg btn-block")#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>

</div>
