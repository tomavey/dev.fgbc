<cfcomponent extends="Controller" output="false">

<cfscript>
	public function config(){
		usesLayout("/forums/layout");
		filters(through="forumCheckin", except="login,authorize,logmein,about,index");
	}

	private function authorize(){
		if (isdefined("params.email") AND isdefined("params.groupcode")){
			redirectTo(controller="forums.posts", action="logmein", params="email=#params.email#&groupcode=#params.groupcode#");
		} 
		elseif (isdefined("params.key") and params.key is "constitution") {
			redirectTo(controller="forums.posts", action="login", params="groupcode=constitution");
		} 
		elseif (!isdefined("session.auth.email") or len(session.auth.email) is 0){
			redirectTo(controller="forums.posts", action="login");
		}
		elseif (isdefined("params.key") and params.key is "constitution"){
			redirectTo(controller="forums.posts", action="login", params="groupcode=constitution");
		}		
		elseif (!isdefined("session.auth.email") or len(session.auth.email) is 0){
			redirectTo(controller="forums.posts", action="login");
		}			
		elseif (!isdefined("session.auth.forumid") or len(session.auth.forumid) is 0){
			redirectTo(controller="forums.posts", action="login");	
		}		
		else {	
			session.auth.forum = 1
		}			
	}
</cfscript>	

	<cffunction name="Xauthorize">

		<cfif isdefined("params.email") AND isdefined("params.groupcode")>
			<cfset redirectTo(controller="forums.posts", action="logmein", params="email=#params.email#&groupcode=#params.groupcode#")>		
		<cfelseif isdefined("params.key") and params.key is "constitution">
			<cfset redirectTo(controller="forums.posts", action="login", params="groupcode=constitution")>		
		<cfelseif not isdefined("session.auth.email") or len(session.auth.email) is 0>
			<cfset redirectTo(controller="forums.posts", action="login")>		
		<cfelseif not isdefined("session.auth.forumid") or len(session.auth.forumid) is 0>
			<cfset redirectTo(controller="forums.posts", action="login")>		
		<cfelse>	
			<cfset session.auth.forum = 1>		
		</cfif>	

	</cffunction>	
		
	<cffunction name="ForumLog">
	<cfset usercount = 0>
	<cfset viewcount = 0>
		<cfset users = model("Userview").findAll(where="controller LIKE 'forum%'", order="email,createdat")>
		<cfset renderView(controller="forums.users", action="log")>
	</cffunction>
	
	<!--- forum-forums/index --->
	<cffunction name="index">
		<cfset forumforums = model("Forumforum").findAll()>
	</cffunction>
	
	<!--- forum-forums/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset forumforum = model("Forumforum").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(forumforum)>
	        <cfset flashInsert(error="ForumForum #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- forum-forums/new --->
	<cffunction name="new">
		<cfset forumforum = model("Forumforum").new()>
		<cfset forumforum.createdby = session.auth.email>
	</cffunction>
	
	<!--- forum-forums/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset forumforum = model("Forumforum").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(forumforum)>
	        <cfset flashInsert(error="ForumForum #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- forum-forums/create --->
	<cffunction name="create">
		<cfset forumforum = model("Forumforum").new(params.forumforum)>
		
		<!--- Verify that the forumforum creates successfully --->
		<cfif forumforum.save()>
			<cfset flashInsert(success="The forumforum was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the forumforum.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>
	
	<!--- forum-forums/update --->
	<cffunction name="update">
		<cfset forumforum = model("Forumforum").findByKey(params.key)>
		
		<!--- Verify that the forumforum updates successfully --->
		<cfif forumforum.update(params.forumforum)>
			<cfset flashInsert(success="The forumforum was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the forumforum.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- forum-forums/delete/key --->
	<cffunction name="delete">
		<cfset forumforum = model("Forumforum").findByKey(params.key)>
		
		<!--- Verify that the forumforum deletes successfully --->
		<cfif forumforum.delete()>
			<cfset flashInsert(success="The forumforum was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the forumforum.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
	<cffunction name="about">
	<cfset var loc=structNew()>	
		<cfif isdefined("params.key")>
			<cfset loc.forumid = params.key>
		<cfelseif isdefined("session.auth.forumid")>	
			<cfset loc.forumid = session.auth.forumid>
		<cfelse>
			<cfset redirectTo(controller="forums.posts", action="login")>	
		</cfif>	

		<cfset about = model("Forumforum").findOne(where="id=#loc.forumid#").description>

	</cffunction>
	
</cfcomponent>
