<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset usesLayout("/handbooklayouts/layout_handbook")>
		<cfset filters(through="gotAgbmRights", only="index,delete")>
		<cfset filters(through="gotBasicHandbookRights", except="create,update")>
		<cfset filters(through="setreturn", only="index,show")>
		<cfset filters(through="logview")>
	</cffunction>
	
	<!--- handbookprofiles/index --->
	<cffunction name="index">
		<cfset setReturn()>
		<cfset handbookprofiles = model("Handbookprofile").findAll(include="Handbookperson(Handbookstate,Handbookpictures)", order="lname")>
	</cffunction>
	
	<!--- handbookprofiles/show/key --->
	<cffunction name="show">
	<cfset var loc=structNew()>

		<cfset isMe = 0>
		
		<!---If type is set to profile, use the profile id in the where string--->
		<cfif isDefined("params.type") and params.type is "profile">
			  <cfset profileWhereString = "id = #params.key#">
			  <cfset picturesWhereString = "personid = '#params.key#'">
		<!---If type is NOT set to profile, use the personid in the where string--->
		<cfelse>
			  <cfset profileWhereString = "personid = '#params.key#'">
			  <cfset picturesWhereString = "personid = '#params.key#'">
			  <cfset person = model("Handbookperson").findOne(where="id='#params.key#'", include="Handbookstate")>
		</cfif>

		<!--- Find the record using the where string sent above--->
	    	<cfset handbookprofile = model("Handbookprofile").findOne(where="#profileWhereString#")>
			<cfset handbookpictures = model("Handbookpicture").findAll(where="#picturesWhereString#")>
			<cfset handbookpicture = model("Handbookpicture").new()>
			<cfset handbookpicture.personid = params.key>	   		

		<!--- if the person based on the key has the same email as the logged in email, let me edit this--->
		<cftry>
			<cfif trim(person.email) is trim(session.auth.email)>
				<cfset isMe = 1>
			<cfelse>	
				<cfset isMe = 0>
			</cfif>
		<cfcatch></cfcatch></cftry>	

		<!---If the profile has not been linked to a person record, let me edit--->
		<cfif isObject(handbookprofile) AND handbookprofile.personid is 0>
			<cfset isMe = 1>
		</cfif>
		
		<!--- if we have been able to find a profile based on the params.key--->
		<cfif isObject(handbookprofile) AND isDefined("params.key")>

			<cftry>
     			<cfset handbookpicture.createdby = session.auth.email>
			<cfcatch>
		    	<cfset handbookpicture.createdby = "Unknown">
			</cfcatch>
			</cftry>
		
		<!---If I cannot find the profile, show a blank form--->
		<cfelseif isDefined("params.key")>	

	        <cfset flashInsert(error="This profile was not not found, please create a new one.")>
	        <cfset redirectTo(action="new", key=params.key)>
	    
		</cfif>
    	
		<cfset renderPage(layout="/handbooklayouts/layout_handbook1")>	
			
	</cffunction>
	
	<!--- handbookprofiles/new --->
	<cffunction name="new">
		<cfset handbookprofile = model("Handbookprofile").new()>

		<!---Set up default values if a personid is provided by params.key--->
		<cfif isDefined("params.key")>
			<cfset person = model("Handbookperson").findOne(where="id=#params.key#", include="Handbookstate")>	
			<cfset handbookprofile.personid = params.key>
			<cfset handbookprofile.email = session.auth.email>
			<cfset handbookprofile.createdBy = session.auth.email>
			<cfset handbookprofile.name = person.fname & " " & person.lname>
			<cfset handbookprofile.phone = person.phone>
			<cfset handbookprofile.wife = person.spouse>
		<cfelseif isDefined("params.admin")>
			<cfset handbookprofile.personid = 0>
			<cfset handbookprofile.createdby = "admin">
			<cfset people = model("Handbookperson").findAll(where="sortorder < 900", include="Handbookstate", order="selectname")>
		<cfelse>
			<cfset handbookprofile.personid = 0>
			<cfset handbookprofile.createdby = "temp">
		</cfif>

	</cffunction>

	<!--- handbookprofiles/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset handbookprofile = model("Handbookprofile").findByKey(params.key)>

		<cfif isDefined("params.admin")>
			<cfset people = model("Handbookperson").findAll(where="p_sortorder < 900", include="Handbookstate,Handbookpositions", order="selectname")>
		</cfif>
		
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookprofile)>
	        <cfset flashInsert(error="Handbookprofile #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- handbookprofiles/create --->
	<cffunction name="create">
		<cfif params.handbookprofile.createdBy is NOT "admin">
			<cfset params.handbookprofile.createdBy = params.handbookprofile.email>
		</cfif>
		
		<cfif isDefined("params.handbookprofile.personid")>
			  <cfset params.handbookprofile.personid = val(params.handbookprofile.personid)>
		</cfif>	  

		<cfset handbookprofile = model("Handbookprofile").new(params.handbookprofile)>
		
		<!--- Verify that the handbookprofile creates successfully --->
		<cfif handbookprofile.save()>
   				<cfset sendEmailNotice(handbookprofile.id)>
			    <cfset redirectTo(action="show",key=handbookprofile.id, params="type=profile")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbookprofile.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- handbookprofiles/update --->
	<cffunction name="update">
		<cfset handbookprofile = model("Handbookprofile").findByKey(params.key)>
		
		<cfif isDefined("params.handbookprofile.personid")>
			  <cfset params.handbookprofile.personid = val(params.handbookprofile.personid)>
		</cfif>	  

		<!--- Verify that the handbookprofile updates successfully --->
		<cfif handbookprofile.update(params.handbookprofile)>
   				<cfset sendEmailNotice(handbookprofile.id)>
			    <cfset redirectTo(action="show",key=handbookprofile.id, params="type=profile")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbookprofile.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- handbookprofiles/delete/key --->
	<cffunction name="delete">
		<cfset handbookprofile = model("Handbookprofile").findByKey(params.key)>
		
		<!--- Verify that the handbookprofile deletes successfully --->
		<cfif handbookprofile.delete()>
			<cfset flashInsert(success="The handbookprofile was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbookprofile.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
	<cffunction name="testdate">
		<cfset test = model("Test").new()>
		<cfdump var="#test#"><cfabort>
		Done!
		<cfabort>

	</cffunction>

	<cffunction name="sendEmailNotice">
		<cfset sendEmail(to=application.wheels.handbookProfileSecretary, subject="Handbook Profile Completion Notice", from="tomavey@fgbc.org", template="notice", layout="/layout_naked")>
	</cffunction>

<cfscript>

public function updateDateNumbers(){
	var profiles = model("Handbookprofile").findAll(where="(birthday IS NOT NULL AND birthdayDayNumber IS NULL) OR (anniversary IS NOT NULL AND anniversaryDayNumber IS NULL) OR (wifesBirthday IS NOT NULL AND wifesBirthdayDayNumber IS NULL)");
	var i = 0;
	var thisRecord = {};
	var ending = profiles.recordCount;
	var count = 0;
	for (i=1;i LTE ending;i=i+1){
		thisRecord = model("Handbookprofile").findByKey(profiles.id[i]);
		if (!isDefined("profiles.birthdayDayNumber[i]") && isDefined("profiles.birthday[i]")){
			thisRecord.birthdayDayNumber = day(profiles.birthday[i]);
			thisRecord.birthdayMonthNumber = month(profiles.birthday[i]);
			thisRecord.birthdayYear = year(profiles.birthday[i]);
			count = count +1;
		};
		if (!isDefined("profiles.wifesBirthdayDayNumber[i]") && isDefined("profiles.wifesBirthday[i]")){
			thisRecord.wifesBirthdayDayNumber = day(profiles.wifesBirthday[i]);
			thisRecord.wifesBirthdayMonthNumber = month(profiles.wifesBirthday[i]);
			thisRecord.wifesBirthdayYear = year(profiles.wifesBirthday[i]);
			count = count +1;
		};
		if (!isDefined("profiles.anniversaryDayNumber[i]") && isDefined("profiles.anniversary[i]")){
			thisRecord.anniversaryDayNumber = day(profiles.anniversary[i]);
			thisRecord.anniversaryMonthNumber = month(profiles.anniversary[i]);
			thisRecord.anniversaryYear = year(profiles.anniversary[i]);
			count = count +1;
		}
			thisRecord.update();			

	};
	writeDump(profiles.recordcount);writeDump(count);abort;
}

</cfscript>
</cfcomponent>
