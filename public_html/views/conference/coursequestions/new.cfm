<div class="container">
<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("Coursequestion")#
	
	<div class="well addcoursequestion">
			#startFormTag(action="create")#
		
			#includePartial("form")#				

			#submitTag()#
				
			#endFormTag()#
			
	</div>		
		
<cfif gotRights("office")>
	#linkTo(text="Return to the listing", action="index")#
</cfif>
</cfoutput>
</div>