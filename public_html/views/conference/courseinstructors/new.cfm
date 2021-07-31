<cfif newCourse>
	<h1>Create a New Course for this Instructor</h1>
</cfif>

<cfif newInstructor>
	<h1>Create a New Instructor for this Course</h1>
</cfif>

<cfoutput>

			
			
			#errorMessagesFor("courseInstructor")#
	
			#startFormTag(action="create")#

			<cfif newCourse>

				#hiddenField(objectName='courseInstructor', property='instructorId')#
			
				#select(objectName='courseInstructor', property='courseId', label='Course:', options=courses, textfield="title")#

			<cfelseif newInstructor>

				#hiddenField(objectName='courseInstructor', property='courseId')#
			
				#select(objectName='courseInstructor', property='instructorId', label='Instructor:', options=instructors, textfield="selectname")#

			</cfif>

			#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
