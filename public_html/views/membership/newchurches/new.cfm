<h1>We have a new church!</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

			#errorMessagesFor("newchurch")#
	
			#startFormTag(action="create")#

			#includePartial(partial="form")#	
																
			#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")# | 
#linkto(text="View old form", action="newchurch", params="old")#


</cfoutput>
