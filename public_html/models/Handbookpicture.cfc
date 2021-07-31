//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset uploadableFile(property="file", destination="#expandpath('.')#/images/handbookpictures/", nameConflict="MakeUnique")>
		<cfset belongsTo(name="Handbookprofile", foreignKey="profileid")>
		<cfset belongsTo(name="Handbookperson", foreignKey="personid")>
	</cffunction>
	
	<cffunction name="setAsDefault">
	<cfargument name="pictureId" required="true" type="numeric">
	<cfset var loc = structNew()>
	<cfset loc.picture = findByKey(arguments.pictureId)>
			  <cfquery datasource="#get('dataSourceName')#">
			  	UPDATE handbookpictures
				SET usefor = ""
				WHERE personid = #loc.picture.personid#
			  </cfquery>	
			  <cfquery datasource="#get('dataSourceName')#">
			  	UPDATE handbookpictures
				SET usefor = "default"
				WHERE id = #arguments.pictureid#
			  </cfquery>	
	<cfreturn true>
	</cffunction>

	<cffunction name="findAllPicturesSorted">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc=structNew()>
	<cfset loc.params = arguments.params>

    	<cfif isDefined("loc.params.date")>
    		<cfset loc.orderString = "createdAt DESC">
    	<cfelse>	
    		<cfset loc.orderString = "lname, fname">
    	</cfif>	

		<cfset loc.whereString = "">
    	<cfif isDefined("loc.params.personid") and val(loc.params.personid)>
    		<cfset loc.whereString = "personid = #loc.params.personid#">
    	</cfif>
		
		<cfset loc.includeString="Handbookperson(Handbookstate)">

		<cfset loc.handbookpictures = model("Handbookpicture").findAll(where=loc.whereString, include=loc.includeString, order=loc.orderString)>
		
		<cfreturn loc.handbookpictures>

	</cffunction>			 
</cfcomponent>
