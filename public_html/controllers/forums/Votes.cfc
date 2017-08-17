<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset usesLayout("/forums/layout")>
	</cffunction>

	<!--- forum-vote-types/index --->
	<cffunction name="index">
		<cfset forumVotes = model("Forumvote").findAll(include="Forumvotetype,Forumpost", order="postid,createdAt")>
		<cfset usesLayout("/forumlayouts/layout")>
	</cffunction>
	
	<cffunction name="list">
		<cfif isdefined('params.key')>
			<cfset forumVotes = model("Forumvote").findAll(where="forumid=#params.key#", include="Forumvotetype,Forumpost", order="postid,votetypeid,createdby")>
		<cfelse>
			<cfset forumVotes = model("Forumvote").findAll(include="Forumvotetype,Forumpost", order="postid,votetypeid,createdby")>
		</cfif>
		<cfset usesLayout("/forumlayouts/layout")>
	</cffunction>

	<!--- forum-vote-types/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset forumvote = model("Forumvote").findAll(where="postId=#params.key#", order="VoteTypeId", include="Forumvotetype,Forumpost")>

	</cffunction>
	
	<!--- forum-vote-types/show/key --->
	<cffunction name="showall">
		
		<!--- Find the record --->
    	<cfset forumvotes = model("Forumvote").findAll(where="forumid=#session.auth.forumid# AND parentid IS NULL",order="postid,VoteTypeId", include="Forumvotetype,Forumpost(Forumforum)")>
	</cffunction>

	<!--- forum-vote-types/new --->
	<cffunction name="new">
		<cfset forumvote = model("Forumvote").new()>
	</cffunction>
	
	<!--- forum-vote-types/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset forumvote = model("Forumvote").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(forumvote)>
	        <cfset flashInsert(error="Forumvote #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- forum-vote-types/create --->
	<cffunction name="create">
		<cfset forumvote = model("Forumvote").new(params)>

		<!---check to see if this person has already voted--->
		<cfset check = model("Forumvote").findall(where="postid='#params.postid#' AND createdBy='#params.createdby#'")>
		<cfif check.recordcount>
			<cfset flashInsert(vote="Caughtya!  You have already voted.")>
			<cfif isDefined("params.ajax")>
				<cfset result = flash("vote")>
				<cfset counttext = getCounts(	key=params.postid,
												action=params.paction,
												controller=params.pcont,
												email=params.createdBy
											)
					>
				<cfset result = result & counttext>
			<cfelse>
            	<cfset redirectTo(back=true)>
			</cfif>
		<!--- Verify that the forumvote creates successfully --->
		<cfelseif forumvote.save()>
			<cfset flashInsert(vote="Your Vote was recorded!")>
			<cfif isDefined("params.ajax")>
				<cfset result = flash("vote")>
			<cfelse>
            	<cfset redirectTo(back=true)>
			</cfif>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(vote="There was an error creating the vote.  Reload the page and try again.")>
			<cfif isDefined("params.ajax")>
				<cfset result = flash("vote")>
			<cfelse>
            	<cfset redirectTo(back=true)>
			</cfif>
		</cfif>
		<cfset renderText(result)>
	</cffunction>

	<cffunction name="showvotes">
		<cfdump var="#params#"><cfabort>
		<cfset voteCounts = model("Forumvote").findAll(where="postid = #arguments.key#")>
	
		<cfset viewCount = model('Forumuserview').findAll(where="email = '#arguments.email#' AND controller = '#arguments.controller#' AND action = '#arguments.action#' AND paramskey = '#arguments.key#'")>
	
		<cfset commentCount = model("Forumpost").findall(where="parentid = #arguments.key#")>
	
		<cfsavecontent variable="showcount">
			<cfoutput>
			Views:#viewcount.recordcount# Comments:#commentCount.recordcount# Votes:#votecounts.recordcount#
			</cfoutput>
		</cfsavecontent>
		<cfset renderText("showvotes")>		
	</cffunction>
	
	<!--- forum-vote-types/update --->
	<cffunction name="update">
		<cfset forumvote = model("Forumvote").findByKey(params.key)>
		
		<!--- Verify that the forumvote updates successfully --->
		<cfif forumvote.update(params.forumvote)>
			<cfset flashInsert(success="The forumvote was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the forumvote.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- forum-vote-types/delete/key --->
	<cffunction name="delete">
		<cfset forumvote = model("Forumvote").findByKey(params.key)>
		
		<!--- Verify that the forumvote deletes successfully --->
		<cfif forumvote.delete()>
			<cfset flashInsert(success="The forumvote was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the forumvote.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
