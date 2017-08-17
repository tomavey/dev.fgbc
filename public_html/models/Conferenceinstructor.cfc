<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("equip_instructors")>
		<cfset hasMany(name="Courses", modelName="Conferencecourseinstructor", foreignKey="courseId")>
                            <cfset hasMany(name="Events", modelName="Conferenceeventinstructor", foreignKey="eventID")>

		<cfset property(
			name="selectName",
			sql="CONCAT(fname,' ',lname)"
			)>

	</cffunction>

            <cffunction name="findInstructorsAsJson">
            <cfargument name="params" required="true" type="struct">
            <cfset var loc = structNew()>
            <cfset loc = arguments.params>
            <cfset loc.whereString = "event='#getevent()#'">
            <cfif isDefined("loc.courseid")>
                <cfset loc.whereString = loc.whereString & " AND courseid = #loc.courseid#">
            </cfif>
            <cfset loc.instructors = findAll(where=loc.whereString, include="Courses")>
            <cfset loc.instructors = queryToJson(loc.instructors)>
            <cfreturn loc.instructors>
            </cffunction>

            <cffunction name="findSpeakersAsJson">
            <cfargument name="params" required="true" type="struct">
            <cfset var loc=structNew()>
            <cfset loc = arguments.params>
            <cfset loc.selectString = "ID, lname, fname, bioWeb,picBig,picThumb">
            <cfset loc.whereString = 'id > 0'>
            <cfif isDefined("loc.id")>
                  <cfset loc.whereString = loc.whereString & " AND ID = #loc.id#">
            </cfif>

                <cfset loc.speakers = findall(where=loc.whereString, select=loc.selectString)>
               <cfset loc.speakers = queryToJson(loc.speakers)>

           <cfreturn loc.speakers>
            </cffunction>

</cfcomponent>
