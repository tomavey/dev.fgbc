<h1>Editing nominations</h1>

<div class="row">

<cfoutput>

			#errorMessagesFor("nominations")#
	
			#startFormTag(action="update", key=params.key, class="form-vertical span6")#

			#putFormTag()#		
				
				#includePartial("form")#					
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>

</div>