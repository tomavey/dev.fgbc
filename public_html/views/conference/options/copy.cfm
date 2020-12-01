<div class="eachItemShown">
<cfoutput>
<p>
#linkTo(text="Return to the listing", action="index")#
</p>
			#errorMessagesFor("option")#
	
			#startFormTag(action="create")#
		
				#includePartial(partial="form")#
			
				#submitTag()#
				
			#endFormTag()#
			

</cfoutput>
</div>