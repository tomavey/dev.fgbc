<div class="container">
<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("Coursequestion")#
	
	<div class="well addcoursequestion">
			#startFormTag(action="create")#
		
			#includePartial(partial="form")#				

			#submitTag(value="Post your question", class="btn btn-block btn-primary btn-large")#
				
			#endFormTag()#
			
	</div>		
		
<cfif gotRights("office")>
	#linkTo(text="Return to the listing", action="index")#
</cfif>
</cfoutput>
</div>

