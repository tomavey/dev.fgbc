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
        <cfif isDefined('tags')>
        </cfif>
        <cfif isDefined("loc.courseid")>
            <cfset loc.whereString = loc.whereString & " AND courseid = #loc.courseid#">
        </cfif>
        <cfset loc.instructors = findAll(where=loc.whereString, include="Courses")>
    <cfset loc.instructors = queryToJson(loc.instructors)>
    <cfreturn loc.instructors>
    </cffunction>

    <cffunction name="findSpeakersAsJson">
    <cfargument name="params" required="false" type="struct">
    <cfargument name="tags" default = "Speaker">
        <cfset var loc=structNew()>
        <cfset loc = arguments.params>
        <cfset loc.selectString = "ID, lname, fname, bioWeb,picBig,picThumb,pic120x120,event">
        <cfset loc.whereString = 'id > 0 AND tags IN (#commaListToQuoteList(arguments.tags)#)'>

        <cfif isDefined("loc.id")>
                <cfset loc.whereString = loc.whereString & " AND ID = #loc.id# AND event='#getEvent()#'">
        </cfif>

        <cfset loc.speakers = findall(where=loc.whereString, select=loc.selectString)>
        <cfset loc.speakers = queryToJson(loc.speakers)>

    <cfreturn loc.speakers>
    </cffunction>


<cfscript>

    function findStaffAsJson () {
        var staff = findSpeakersAsJson(tags='Staff');
        return staff;
    }

    function commaListToQuoteList (list) {
        var newList = "";
        newlist = listMap(list, function (e) {
            return '"'&e&'"';
        })
        return newList;
    }
</cfscript>    

</cfcomponent>
