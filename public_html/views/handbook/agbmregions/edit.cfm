<cfoutput><h1>Editing Region: #handbookagbmregion.name#</h1>

#includePartial("showFlash")#

			
			#errorMessagesFor("handbookagbmregion")#
	
			#startFormTag(action="update", key=params.key)#
		
			#includePartial("form")#				

			#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
