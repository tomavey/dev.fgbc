<cfcomponent extends="Controller" output="false">
	
	<cffunction name="config">
		<cfset usesLayout("/forums/layout")>
	</cffunction>
	
	<!--- forum-vote-types/index --->
	<cffunction name="index">
		<cfset forumvotetypes = model("Forumvotetype").findAll()>

	</cffunction>
	
	<!--- forum-vote-types/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset forumvotetype = model("ForumVoteType").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(forumvotetype)>
	        <cfset flashInsert(error="ForumVoteType #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- forum-vote-types/new --->
	<cffunction name="new">
		<cfset forumvotetype = model("ForumVoteType").new()>
	</cffunction>
	
	<!--- forum-vote-types/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset forumvotetype = model("ForumVoteType").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(forumvotetype)>
	        <cfset flashInsert(error="ForumVoteType #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- forum-vote-types/create --->
	<cffunction name="create">
		<cfset forumvotetype = model("ForumVoteType").new(params.forumvotetype)>
		
		<!--- Verify that the forumvotetype creates successfully --->
		<cfif forumvotetype.save()>
			<cfset flashInsert(success="The forumvotetype was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the forumvotetype.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>
	
	<!--- forum-vote-types/update --->
	<cffunction name="update">
		<cfset forumvotetype = model("ForumVoteType").findByKey(params.key)>
		
		<!--- Verify that the forumvotetype updates successfully --->
		<cfif forumvotetype.update(params.forumvotetype)>
			<cfset flashInsert(success="The forumvotetype was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the forumvotetype.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- forum-vote-types/delete/key --->
	<cffunction name="delete">
		<cfset forumvotetype = model("ForumVoteType").findByKey(params.key)>
		
		<!--- Verify that the forumvotetype deletes successfully --->
		<cfif forumvotetype.delete()>
			<cfset flashInsert(success="The forumvotetype was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the forumvotetype.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
