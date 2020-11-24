<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset table("equip_instructors_courses")>
		<cfset belongsTo(name="InstructorInfo", modelName="Conferenceinstructor", foreignKey="instructorID")>
		<cfset belongsTo(name="CourseInfo", modelName="Conferencecourse", foreignKey="courseID")>
		<cfset belongsTo(name="Instructor", modelName="Conferenceinstructor", foreignKey="instructorId")>

		<cfset property(name = "courseId", column="equip_coursesId")>
		<cfset property(name = "instructorId", column="equip_instructorsId")>

	</cffunction>

	<cffunction name="delete">
	<cfargument name="courseId" required="true" type="numeric">
	<cfargument name="instructorId" required="true" type="numeric">
		<cfquery datasource="fgbc_main_3">
			DELETE from equip_instructors_courses
			WHERE equip_instructorsId = #arguments.instructorid#
			AND equip_coursesId = #arguments.courseid#
		</cfquery>
	<cfreturn true>	
	</cffunction>

</cfcomponent>
