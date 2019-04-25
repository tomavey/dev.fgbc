<h1>Nominations for Fellowship Council for <cfoutput>#getSetting("nominateyear")#</cfoutput>:</h1>

<cfoutput>

			#errorMessagesFor("nominations")#
	
			#startFormTag(action="create")#
		
			#includePartial("form")#					
			
			#submitTag()#
				
			#endFormTag()#
			

</cfoutput>
