<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset filters(through="isSuperadmin", only="adminindex,edit,new,delete")>
		<cfset usesLayout("/layoutadmin")>
	</cffunction>

	<!--- announcements/index --->
	<cffunction name="adminindex">
		<cfset announcements = model("Mainannouncement").findAll(order="position,startAt desc")>
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

	<!--- announcements/replicate --->
	<cffunction name="replicate">
		<cfset announcement = model("Mainannouncement").new(params.announcement)>
		
		<!--- Verify that the announcement creates successfully --->
		<cfif announcement.save()>
			<cfset flashInsert(success="The announcement was copied successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error copying the announcement.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- announcements/create --->
	<cffunction name="create">
		<cfset announcement = model("Mainannouncement").new(params.announcement)>
		
		<!--- Verify that the announcement creates successfully --->
		<cfif announcement.save()>
			<cfset flashInsert(success="The announcement was created successfully.")>
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
			<cfset flashInsert(success="The announcement was updated successfully.")>	
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
	
	<cffunction name="index">
		<cfparam name="params.page" default="1">
		<cfparam name="params.perpage" default="10">
		<cfif isDefined("params.showall")>
			<cfset params.whereString = "">
		<cfelse>					
			<cfset params.whereString = "endAt > now() AND onhold = 'N'">
		</cfif>	
		<cfif isDefined("params.search") and len(params.search)>
			  <cfset params.whereString = params.whereString & " AND (title LIKE '%#params.search#%' OR content LIKE '%#params.search#%')">
		</cfif>
		<cfset announcements = model("Mainannouncement").findall(where=params.whereString, order="startAt desc", page=params.page, perpage=params.perpage)>
	</cffunction>

	<cffunction name="rss">
		<cfset announcements = model("Mainannouncement").findAll(where="startat < now() AND onhold = 'N'", order="createdAt desc")>
		
		<cfset title = "FGBC Announcements">
		<cfset description= "Official Communication of the FGBC National Office">
		<cfset renderPage(template="rss.cfm", layout="rsslayout")>
	</cffunction>

	<cffunction name="uploadImage">
		<cfimage action="resize" width="250" height="" name="thumb" source="#expandpath('.')#/images/announcements/#params.image#" destination="#expandpath('.')#/images/announcements/thumb_#params.image#" overwrite="true">		
        <cfset returnback()>
	</cffunction>

</cfcomponent>
