<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
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
	
	<cffunction name="index">
		<cfparam name="params.page" default="1">
		<cfparam name="params.perpage" default="10">
		<cfparam name="params.whereString" default="startAt < now() AND onhold = 'N'">
		<cfif isDefined("params.search") and len(params.search)>
			  <cfset params.whereString = params.whereString & " AND (title LIKE '%#params.search#%' OR content LIKE '%#params.search#%')">
		</cfif>
		<cfset announcements = model("Mainannouncement").findall(where=params.whereString, order="startAt desc", page=params.page, perpage=params.perpage)>
	</cffunction>

	<cffunction name="rss">
		<cfset announcements = model("Mainannouncement").findAll(where="startat < now() AND onhold = 'N' AND type <> 'Announcement Only'", order="createdAt desc")>
		
		<cfset title = "FGBC Announcements">
		<cfset description= "Official Communication of the FGBC National Office">
		<cfset renderPage(template="rss.cfm", layout="rsslayout")>
	</cffunction>

</cfcomponent>
