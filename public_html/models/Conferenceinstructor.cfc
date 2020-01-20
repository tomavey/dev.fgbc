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

<cfscript>

    function findSpeakersAsJson(struct params, tags="speaker") {
        var loc=structNew()
        loc = arguments.params
        if ( isDefined("params.event") ) { loc.event = params.event } else { loc.event = getEvent() }
        loc.selectString = "ID, lname, fname, bioWeb,picBig,picThumb,pic120x120,event,tags";
        loc.whereString = "id > 0 AND tags LIKE '%#tags#%'";
        if ( isDefined("loc.id") ) {
            loc.whereString = loc.whereString & " AND ID = #loc.id#";
        } else {
            loc.whereString = loc.whereString & " AND event='#loc.EVENT#'";
        }

        loc.speakers = findall(where=loc.whereString, select=loc.selectString, order="lname,fname");
        loc.speakers = queryToJson(loc.speakers);
        return loc.speakers;
    }


    function findStaffAsJson (struct params) {
        var staff = findSpeakersAsJson(params=params, tags='Staff');
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
