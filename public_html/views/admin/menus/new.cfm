<cfoutput>

<div class="container">

<h1>Create new menu</h1>


			#errorMessagesFor("menu")#
	
			#startFormTag(action="create")#
		
			#includePartial(partial="form")#	

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#

</div>
</cfoutput>
