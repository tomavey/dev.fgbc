<div class="container">
	<cfoutput>	
		<h1>Create a New #typesOfCourses()#</h1>
		
		#includePartial("showFlash")#
		
					
					#errorMessagesFor("course")#
			
					#startFormTag(action="create")#
				
					#includePartial("form")#	
						
		
						#submitTag()#
						
					#endFormTag()#
					
				
		
		#linkTo(text="Return to the listing", action="index")#
		</cfoutput>
</div>
