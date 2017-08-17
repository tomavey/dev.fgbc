<h1>Create new event</h1>
<cfoutput>
<div class="eachItemShown new">

			#errorMessagesFor("event")#
			<cfif NOT flashIsEmpty()>
			<p id='flasherror'>#flash("error")#</p>
			</cfif>		
			#startFormTag(action="create")#
				
				#includePartial("form")#
	
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</div>
</cfoutput>
