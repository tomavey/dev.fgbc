<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<cfset filters(through="setRssEnvironment", only="rss")>
	</cffunction>

	<!---Filters--->

	<cffunction name="setRssEnvironment">
		<cfif application.wheels.environment NEQ "production">
			<cfset set(environment="production")>
		</cfif>
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
		<cfset announcements = model("Mainannouncement").findall(where=params.whereString, order="startAt DESC", page=params.page, perpage=params.perpage)>
	</cffunction>

	<cffunction name="rss">
		<cfset whereString = "startat < now() AND onhold = 'N' AND type <> 'Announcement Only'">
		<cfif isDefined("params.id")>
			<cfset whereString = whereString & " AND id=#params.id#">
		</cfif>
		<cfset announcements = model("Mainannouncement").findAll(where=whereString, order="createdAt DESC")>
		<cfset title = "Charis Fellowship Announcements">
		<cfset description= "Official Communication of the Charis Fellowship National Office">
		<cfset renderView(template="rss.cfm", layout="rsslayout", showDebugInformation=false)>
	</cffunction>

</cfcomponent>
