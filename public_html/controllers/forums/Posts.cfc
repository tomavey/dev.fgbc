<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset filters("getForums")>
		<cfset usesLayout("/forums/layout")>
		<cfset filters(through="forumCheckin", except="login,authorize,logmein")>
		<cfset filters(through="logview", type="after")>
	</cffunction>
	
	<cffunction name="logmein">
		<cfset params.groupcode = replace(params.groupcode,'"','','All')>
		<cfset forum = model("Forumforum").findOneByGroupCode(params.groupcode)>

		<cfif isvalid("email",params.email) AND isobject(forum)>

			<cfset session.auth.email = params.email>
			<cfset session.auth.forumid = forum.id>
			
			<cfset check = model("Forumuser").findAll(where="email = '#params.email#' AND groupcode = '#params.groupcode#'")>

			<cfif not check.recordcount>
				<cfset model("Forumuser").new(params).save()>
			</cfif>	
	
			<cfset redirectTo(controller="forums.posts", action="list")>
		<cfelse>
			<cfset flashInsert(login="Please provide a valid email address and the correct group code:")>
			<cfset redirectTo(action="login")>
		</cfif>	
	</cffunction>
	
	<cffunction name="login">
	<cfset formaction = "logmein">

	</cffunction>
	
	<!--- forum-posts/index --->
	<cffunction name="index">
		<cfset setReturn()>
	
		<cfif isdefined("session.auth.forumid") and session.auth.forumid>
			<cfset forumposts = model("Forumpost").findAll(where="parentId IS NULL AND forumid = #session.auth.forumid#", include="forumForum")>
		<cfelse>
			<cfset forumposts = model("Forumpost").findAll(where="parentId IS NULL", include="forumForum")>
		</cfif>
	</cffunction>
	
	<cffunction name="getForums">
		<cfset forums = model("Forumforum").findall()>
	</cffunction>
	
	<!--- forum-posts/show/key --->
	<cffunction name="show">
		<cfif not isdefined("params.ajax")>
			<cfset setReturn()>
		</cfif>
		
		<!--- Find the record --->
    	<cfset forumpost = model("Forumpost").findByKey(key=params.key, include="forumForum")>
		<cfset comments = model("Forumpost").findall(where="parentid=#params.key#", order="createdAt DESC")>
		<cfset voteTypes = model("Forumvotetype").findall()>
		<cfset navLinks = getNextPrevPost(forumpost.id)>
		
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(forumpost)>
	        <cfset flashInsert(error="ForumPost #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
	    
	    <cfif isdefined("params.ajax")>
		    <cfset rendertext(forumpost.post)>
	    </cfif>
			
	</cffunction>

	<cffunction name="getNextPrevPost">
	<cfargument name="id" required="true" type="numeric">
	<cfset var NextPrevPost = structNew()>
		<cfset posts = model("Forumpost").findAll(where="parentid IS NULL AND forumid = #session.auth.forumid#", include="Forumforum", order="sortorder")>
		<cfset postlist = valueList(posts.id)>	

		<cfset index = listFind(postlist,arguments.id)>

		<cfif index is 1>
			<cfset nextPrevPost.previous = 0>
		<cfelse>	
			<cfset nextPrevPost.previous = listGetAt(postlist,index-1)>
		</cfif>	
		<cfif index is listLen(postlist)>
			<cfset nextPrevPost.next = 0>
		<cfelse>	
			<cfset nextPrevPost.next = listGetAt(postlist,index+1)>
		</cfif>	

		<cfreturn nextPrevPost>
	</cffunction>
	
	<!--- forum-posts/new --->
	<cffunction name="new">
		<cfset showsubjectfield = 0>

		<cfif gotrights("superadmin")>
			<cfset showsubjectfield = 1>
		</cfif>
		
		<cfif isdefined("session.auth.forumid")>
			<cfset params.forumid = session.auth.forumid>
		</cfif>

		<cfset forumpost = model("Forumpost").new()>
		<cfset forumpost.createdby = session.auth.email>

		<cfif isdefined("params.forumid") AND isdefined("params.parentid")>
			<cfset subject = model("Forumpost").findByKey(params.parentid).subject>
			<cfset forumpost.subject = subject>
		</cfif>	
	</cffunction>
	
	<!--- forum-posts/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset forumpost = model("Forumpost").findByKey(params.key)>

		<cfset showsubjectfield = 0>
			<cfif not params.action is "copy" AND (isdefined("params.forumid") OR isdefined("forumpost.parentid"))>
				<cfset showsubjectfield = 1>
			</cfif>				
			<cfif gotrights("superadmin")>
				<cfset showsubjectfield = 1>
			</cfif>
			<cfif session.auth.email is "tomavey@fgbc.org">
				<cfset showsubjectfield = 1>
			</cfif>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(forumpost)>
	        <cfset flashInsert(error="ForumPost #params.key# was not found")>
			<cfset redirectTo(action="show", key=params.key)>
	    </cfif>
		
	</cffunction>
	
	<cffunction name="copy">
    	<cfset forumpost = model("Forumpost").findByKey(params.key)>

		<cfset showsubjectfield = 0>
			<cfif not params.action is "copy" AND (isdefined("params.forumid") OR isdefined("forumpost.parentid"))>
				<cfset showsubjectfield = 1>
			</cfif>				
			<cfif gotrights("superadmin")>
				<cfset showsubjectfield = 1>
			</cfif>
			<cfif session.auth.email is "tomavey@fgbc.org">
				<cfset showsubjectfield = 1>
			</cfif>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(forumpost)>
	        <cfset flashInsert(error="ForumPost #params.key# was not found")>
			<cfset redirectTo(action="show", key=params.key)>
	    </cfif>
	</cffunction>
	
	<!--- forum-posts/create --->
	<cffunction name="create">
		<cfset forumpost = model("Forumpost").new(params.forumpost)>

		<!--- Verify that the forumpost creates successfully --->
		<cfif forumpost.save()>
			<cfset flashInsert(success="The forumpost was created successfully.")>
			<cfif isSendPostOn()>
				<cfset sendEmailsNotifications(forumpost.id)>
			</cfif>
			<cfif isdefined("params.replyto")>
				<cfset sendEmailReply(id=forumpost.id,replyto=params.replyto)>
			</cfif>
			<cfif structKeyExists(params.forumpost,"parentid")>
            	<cfset redirectTo(action="show", key=params.forumpost.parentid)>
			<cfelse>
            	<cfset redirectTo(action="index")>
			</cfif>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the forumpost.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- forum-posts/update --->
	<cffunction name="update">
		<cfset forumpost = model("Forumpost").findByKey(params.key)>
		
		<!--- Verify that the forumpost updates successfully --->
		<cfif forumpost.update(params.forumpost)>
			<cfset flashInsert(success="The forumpost was updated successfully.")>	
			<cfif len(forumpost.parentid)>
	            <cfset redirectTo(action="show", key=forumpost.parentid)>
	        <cfelse>    
	            <cfset returnBack()>
	        </cfif>    
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the forumpost.")>
			<cfset renderPage(action="edit", key=forumpost.parentid)>
		</cfif>
	</cffunction>
	
	<!--- forum-posts/delete/key --->
	<cffunction name="delete">
		<cfset forumpost = model("Forumpost").findByKey(params.key)>
		
		<!--- Verify that the forumpost deletes successfully --->
		<cfif forumpost.delete()>
			<cfset flashInsert(success="The forumpost was deleted successfully.")>	
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the forumpost.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="list">
		<cfset setreturn()>
		<cfif !isDefined("params.key")>
			<cftry>
				<cfset params.key = session.auth.forumid>
			<cfcatch>
				<cfset redirectTo(action="login")>
			</cfcatch>	
			</cftry>
		</cfif>	
		<cfset posts = model("Forumpost").findAll(where="forumid='#params.key#' AND parentid IS NULL", include="Forumforum", order="sortorder")>
		<cfset allposts = model("Forumpost").findAll(where="forumid='#params.key#' AND parentid IS NOT NULL", include="Forumforum", order="createdAt DESC")>
		<cfset user = model("Forumuser").findOne(where="email = '#session.auth.email#' AND groupcode = '#getGroupCode(session.auth.forumid)#'")>
		<cfset files = model("forumresource").findAll(where="forumid='#params.key#'", order="id DESC")>
		<cfset forumresource = model("Forumresource").new()>

	</cffunction>
	
	<cffunction name="getGroupCode">
	<cfargument name="forumid" required="yes" type="numeric">
		<cfset var loc = structNew()>
		<cfset loc.groupcode = model("Forumforum").findByKey(arguments.forumid).groupcode>
	<cfreturn loc.groupcode>
	</cffunction>
	
	<cffunction name="subscribe">
	<cfargument name="forumid" required="true" default="#session.auth.forumid#">
	<cfargument name="email" required="true" default="#session.auth.email#">
	<cfargument name="subscribed" default=#params.key#>
	<cfset var loc = structNew()>

		<cfset loc.groupcode = getGroupCode(arguments.forumid)>
		<cfset loc.email = arguments.email>
		<cfset loc.subscribed = arguments.subscribed>

		<cfset user = model("Forumuser").findOne(where="email = '#loc.email#' AND groupcode = '#loc.groupcode#'")>
		<cfset user.update(loc)>
		<cfset redirectTo(back=true)>
	</cffunction>

	<cffunction name="sendEmailsNotifications">
	<cfargument name="id" required="true" type="numeric">
	<cfset post = model("Forumpost").findByKey(key=arguments.id, include="Forumforum")>
	<cfset users = model("Forumusers").findAll(where="subscribed = 1 AND groupcode = '#post.forumforum.groupcode#'")>
	
	<cfloop query="users">
		<cfif users.email is "tomavey@fgbc.org">
			<cfset users.email = "tomavey@comcast.net">
		</cfif>
		<cfset sendEmail(template="notify", from="tomavey@fgbc.org", to=users.email, subject="New post on the Charis Fellowhip Forum", layout="/layout_naked")>
	</cfloop>
	</cffunction>
	
	<cffunction name="sendEmailReply">
	<cfargument name="id" required="true" type="numeric">
	<cfargument name="replyto" required="true" type="string">

	<cfset post = model("Forumpost").findByKey(key=arguments.id, include="Forumforum")>

		<cfif arguments.replyto is "tomavey@fgbc.org">
			<cfset arguments.replyto = "tomavey@comcast.net">
		</cfif>
	
		<cfset sendEmail(template="reply", from=session.auth.email, to=arguments.replyto, subject="Reply to your post on the FGBC Forum", layout="/layout_naked")>
	<cfset flashInsert(success="Your post was saved and reply sent.")>
	</cffunction>

	<cffunction name="changesubjects">
		<cfset posts = model("Forumpost").findall(where="parentid is not null")>
		<cfloop query="posts">
			<cfset newsubject = model("Forumpost").findAll(where="id = #parentid#").subject>
			<cfset comment = model("Forumpost").findByKey(id)>
			<cfset comment.subject = newsubject>
	
			<cfset test = comment.update(comment)>
			<cfdump var="#test#">
		</cfloop><cfabort>
	</cffunction>

	<cffunction name="search">
	<cfset var searchString = "forumid = #session.auth.forumid# AND ">	
	<cfset var searchString2 = "">	
	<cfset var searchString3 = "">	
	
		<cfset searchString = searchString & "(createdBy like '%#params.key#%' OR ">
		<cfloop list="#params.key#" delimiters="-" index="i">
	 		<cfset searchString2 = searchString2 & " AND post like '%#i#%'">
		</cfloop>
		<cfset searchString2 = replace(searchString2," AND ","","one")>
	
		<cfloop list="#params.key#" delimiters="-" index="i">
	 		<cfset searchString3 = searchString3 & " AND subject like '%#i#%'">
		</cfloop>
		<cfset searchString3 = replace(searchString3," AND ","","one")>
		
		<cfset searchstring = searchstring & "(" & searchString2 & ") OR ("& searchstring3 & "))">
	
		<cfset posts = model("Forumpost").findAll(where="#searchstring#")>

	</cffunction>	
	
	<cffunction name="showDescription">
		<cfset description = model("Forumpost").findOne(where="id=#params.key#").description>
		<cfset rendertext(description)>
	</cffunction>

	<cffunction name="isSendPostOn">
		<cfreturn false>
	</cffunction>
	
</cfcomponent>
