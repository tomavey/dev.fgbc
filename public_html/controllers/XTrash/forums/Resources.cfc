<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset filters("getForums")>
		<cfset usesLayout("/forums/layout")>
		<cfset filters(through="forumCheckin", except="login,authorize,logmein")>
	</cffunction>
	
	<cffunction name="getForums">
		<cfset forums = model("Forumforum").findall()>
	</cffunction>
	
	<cffunction name="forumCheckin">
		<cftry>
		<cfif not session.auth.forum>
			<cfset authorize()>
		</cfif>	
		<cfcatch>
			<cfset authorize()>
		</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="authorize">
		<cfif not isdefined("session.auth.email") or len(session.auth.email) is 0>
			<cfset redirectTo(controller="forumPosts", action="login")>		
		<cfelseif not isdefined("session.auth.forumid") or len(session.auth.forumid) is 0>
			<cfset redirectTo(controller="forumPosts", action="login")>		
		<cfelse>	
			<cfset session.auth.forum = 1>		
		</cfif>	
	</cffunction>		
	
	<cffunction name="logmein">

		<cfset forum = model("Forumforum").findOneByGroupCode(params.groupcode)>
		<cfif isvalid("email",params.email) AND isobject(forum)>
			<cfset session.auth.email = params.email>
			<cfset session.auth.forumid = forum.id>
			
			<cfset check = model("Forumuser").findAll(where="email = '#params.email#' AND groupcode = '#params.groupcode#'")>

			<cfif not check.recordcount>
				<cfset model("Forumuser").new(params).save()>
			</cfif>	
	
			<cfset redirectTo(controller="forumPosts", action="list")>
		<cfelse>
			<cfset flashInsert(login="Please provide a valid email address and the correct group code:")>
			<cfset redirectTo(back=true)>
		</cfif>	
	</cffunction>
	
	<cffunction name="login">
	
	</cffunction>

	
	<!--- forumresources/index --->
	<cffunction name="index">
		<cfset forumresources = model("Forumresource").findAll(include="Forumforum")>

	</cffunction>
	
	<!--- forumresources/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset forumresource = model("Forumresource").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(forumresource)>
	        <cfset flashInsert(error="Forumresource #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- forumresources/new --->
	<cffunction name="new">
		<cfset forumresource = model("Forumresource").new()>
	</cffunction>
	
	<!--- forumresources/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset forumresource = model("Forumresource").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(forumresource)>
	        <cfset flashInsert(error="Forumresource #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- forumresources/create --->
	<cffunction name="create">
		<cfset forumresource = model("Forumresource").new(params.forumresource)>

		<!--- Verify that the forumresource creates successfully --->
		<cfif forumresource.save()>
			<cfset flashInsert(success="The forumresource was created successfully.")>
			<cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the forumresource.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- forumresources/update --->
	<cffunction name="update">
		<cfset forumresource = model("Forumresource").findByKey(params.key)>
		
		<!--- Verify that the forumresource updates successfully --->
		<cfif forumresource.update(params.forumresource)>
			<cfset flashInsert(success="The forumresource was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the forumresource.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- forumresources/delete/key --->
	<cffunction name="delete">
		<cfset forumresource = model("Forumresource").findByKey(params.key)>
		
		<!--- Verify that the forumresource deletes successfully --->
		<cfif forumresource.delete()>
			<cfset flashInsert(success="The forumresource was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the forumresource.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
