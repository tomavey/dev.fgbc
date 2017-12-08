<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset filters(through="isSuperadmin", only="adminindex,edit,new,delete")>
		<cfset filters(through="setReturn", only="index,show")>
	</cffunction>

	<!---------->
	<!---CRUD--->
	<!---------->

	<!---announcements/index--->
	<cffunction name="index">
		<cfparam name="params.page" default="1">
		<cfparam name="params.perpage" default="20">
		<cfif isDefined("params.showall")>
			<cfset params.whereString = "">
			<cfset params.perpage = 10000000000000000>
		<cfelseif isDefined("params.announcements")>	
			<cfset params.whereString = "endAt > now() AND onhold = 'N' AND (type = 'Announcement Only' OR type = 'Both' OR type = '')">
			<cfset params.perpage = 10000000000000000>
		<cfelseif isDefined("params.feeds")>	
			<cfset params.whereString = "(type = 'News Feed Only' OR type = 'Both' OR type = '')">
			<cfset params.perpage = 10000000000000000>
		<cfelse>					
			<cfset params.whereString = "endAt > now() AND onhold = 'N'">
		</cfif>	
		<cfif isDefined("params.search") and len(params.search)>
			  <cfset params.whereString = params.whereString & " AND (title LIKE '%#params.search#%' OR content LIKE '%#params.search#%')">
		</cfif>
		<cfset announcements = model("Mainannouncement").findall(where=params.whereString, order="startAt desc", page=params.page, perpage=params.perpage)>
	</cffunction>
	
	<!--- announcements/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset announcement = model("Mainannouncement").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(announcement)>
	        <cfset flashInsert(error="Announcement #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- announcements/new --->
	<cffunction name="new">
		<cfset announcement = model("Mainannouncement").new()>
	</cffunction>
	
	<!--- announcements/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset announcement = model("Mainannouncement").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(announcement)>
	        <cfset flashInsert(error="Announcement #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- announcements/copy/key --->
	<cffunction name="copy">
	
		<!--- Find the record --->
    	<cfset announcement = model("Mainannouncement").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(announcement)>
	        <cfset flashInsert(error="Announcement #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	    <cfset renderPage(action="new")>
		
	</cffunction>

	<!--- announcements/create --->
	<cffunction name="create">
		<cfset announcement = model("Mainannouncement").new(params.announcement)>
		<!---cfdump var='#announcement.properties()#'><cfabort--->
		
		<!--- Verify that the announcement creates successfully --->
		<cfif announcement.save()>
			<!---cfset $uploadImage(params.announcement.image)--->
			<cfset flashInsert(success="The announcement was created successfully.")>
			<cfset returnBack()>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the announcement.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- announcements/update --->
	<cffunction name="update">
		<cfset announcement = model("Mainannouncement").findByKey(params.key)>
		
		<!--- Verify that the announcement updates successfully --->
		<cfif announcement.update(params.announcement)>

			<!---cfset $uploadImage(params.announcement.image)--->
			<cfset flashInsert(success="The announcement was updated successfully.")>	
			<cfset returnBack()>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the announcement.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- announcements/delete/key --->
	<cffunction name="delete">
		<cfset announcement = model("Mainannouncement").findByKey(params.key)>
		
		<!--- Verify that the announcement deletes successfully --->
		<cfif announcement.delete()>
			<cfset flashInsert(success="The announcement was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the announcement.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<!---End of Crud--->

<!---Not Used Needs work--->
	<cffunction name="$uploadImage" access="private">
	<cfargument name="image" required="true" type="string">
	<cfset var loc = arguments>
	<cfset loc.destination = "#expandpath('.')#/images/announcements/">
	<cfdump var="#loc#"><cfabort>
	<cffile action = "upload"
          fileField = loc.image
          destination = loc.destination
          accept = "image/jpeg, text/html, application/msword,  application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/pdf, application/vnd.msword, application/vnd.ms-excel, application/msexcel, application/unknown, application/x-octet-stream,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
          nameconflict="overwrite">
	<!---
		<cfimage action="resize" width="300" height="" name="thumb" source="#expandpath('.')#/images/announcements/#arguments.image#" destination="#expandpath('.')#/images/announcements/thumb_#arguments.image#" overwrite="true">		
	--->	
	</cffunction>

</cfcomponent>
