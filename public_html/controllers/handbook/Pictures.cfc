<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset usesLayout("/handbook/layout_handbook1")>
		<cfset filters(through="setreturn", only="index,show,new")>
		<cfset filters(through="logview")>
	</cffunction>

<!---Basic CRUD--->

	<!--- handbookpictures/index --->
	<cffunction name="index">
		<cfset handbookpictures = model("Handbookpicture").findAllPicturesSorted(params)>
	</cffunction>
	
	<!--- handbookpictures/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset handbookpicture = model("Handbookpicture").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookpicture)>
	        <cfset flashInsert(error="Handbookpicture #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- handbookpictures/new --->
	<cffunction name="new">
		<cfif not isDefined("params.personid")>
			  <cfset setReturn()>
			  <cfset redirectTo(action="getperson")>
		</cfif>
		<cfset handbookpicture = model("Handbookpicture").new()>
		<cfset handbookpictures = model("Handbookpicture").findall(where="personid=#params.personid#")>
		<cfset handbookpicture.personid = params.personid>
		<cfset handbookperson = model("Handbookperson").findOne(where="id=#params.personid#", include="Handbookstate")>

		<cftry>
		<cfset handbookpicture.createdby = session.auth.email>
		<cfcatch>
		<cfset handbookpicture.createdby = "tomavey@fgbc.org">
		</cfcatch>
		</cftry>
		
		<cfset renderPage(layout="/handbook/layout_handbook")>

	</cffunction>
	
	<!--- handbookpictures/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset handbookpicture = model("Handbookpicture").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookpicture)>
	        <cfset flashInsert(error="Handbookpicture #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- handbookpictures/create --->
	<cffunction name="create">
		<cfset handbookpicture = model("Handbookpicture").new(params.handbookpicture)>

		<!--- Verify that the handbookpicture creates successfully --->
		<cfif handbookpicture.save()>
		<cfdump var='#handbookpicture.properties()#'><cfabort>
			<cfset model("Handbookpicture").setAsDefault(handbookpicture.id)>
			<cfset flashInsert(success="The handbookpicture was created successfully.")>
			<cfset thumbnail(handbookpicture.file)>
			<cfset webimage(handbookpicture.file)>
            <cfset returnback()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbookpicture.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- handbookpictures/update --->
	<cffunction name="update">

		<cfset handbookpicture = model("Handbookpicture").findByKey(params.key)>
		
		<!--- Verify that the handbookpicture updates successfully --->
		<cfif handbookpicture.update(params.handbookpicture)>
			<cfset flashInsert(success="The handbookpicture was updated successfully.")>	
			<cfset thumbnail(handbookpicture.file)>
            <cfset returnback()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbookpicture.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- handbookpictures/delete/key --->
	<cffunction name="delete">
		<cfset handbookpicture = model("Handbookpicture").findByKey(params.key)>
		
		<!--- Verify that the handbookpicture deletes successfully --->
		<cfif handbookpicture.delete()>
			<cfset flashInsert(success="The handbookpicture was deleted successfully.")>	
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbookpicture.")>
            <cfset returnBack()>
		</cfif>
	</cffunction>

<!---Image manipulation methods--->
	<cffunction name="thumbnail">
	<cfargument name="file" required="true" type="string">	
		<cfimage action="resize" width="75" height="" name="thumb" source="#expandpath('.')#/images/handbookpictures/#arguments.file#" destination="#expandpath('.')#/images/handbookpictures/thumb_#arguments.file#" overwrite="true">		
	</cffunction>
	
	<cffunction name="webimage">
	<cfargument name="file" required="true" type="string">	
		<cfimage action="resize" width="600" height="" name="thumb" source="#expandpath('.')#/images/handbookpictures/#arguments.file#" destination="#expandpath('.')#/images/handbookpictures/web_#arguments.file#" overwrite="true">		
	</cffunction>

<!---Misc Methods--->	
	<cffunction name="setpictureasdefault">
	<cfargument name="id" default="#params.key#">
		<cfset model("Handbookpicture").setAsDefault(arguments.id)>
		<cfset returnBack()>
	</cffunction>
	
	<!---Requests a user id before displaying a new form--->
	<cffunction name="getPerson">
		<cfset people = model("Handbookperson").findAll(include="Handbookstate", order="lname,fname")>
	</cffunction>
	
<!---142 lines--->	

<cfscript>
public function pictureExists(file){
	var fileToCheck = GetBaseTemplatePath();
	fileToCheck = replace(filetocheck,"index.cfm","");
	fileToCheck = replace(filetocheck,"rewrite.cfm","");
	fileToCheck = fileToCheck & "images\handbookpictures\thumb_" & file;
	return fileExists(fileToCheck);
}
</cfscript>
</cfcomponent>
