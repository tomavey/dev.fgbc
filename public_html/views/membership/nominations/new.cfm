<h1>Nominations for <a href="https://charisfellowship.us/page/fellowshipcouncil" target="_new">Fellowship Council</a> for <cfoutput>#getSetting("nominateyear")#</cfoutput>:</h1>

<cfoutput>

			#errorMessagesFor("nominations")#
	
			#startFormTag(action="create")#
		
			#includePartial(partial="form")#					
			
			#submitTag()#
				
			#endFormTag()#
			

</cfoutput>
