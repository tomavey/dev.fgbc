<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout(template="/handbook/layout_handbook1", except="download,show,search")>
		<cfset filters(through="gotBasicHandbookRights")>
		<cfset provides("html,xml,json")>
		<cfset filters(through="logview")>
		<cfset filters(through="setreturn", only="index,show")>
	</cffunction>

	<!--- handbook-tags/index --->
	<cffunction name="index">
		<cfset people = model("Handbookperson").findAll(where="p_sortorder < 900", include="Handbookstate,Handbookpositions", order="lname,fname,city")>
		<cfset organizations = model("Handbookorganization").findAll(where="statusid IN (1,8,2)", include="Handbookstate", order="org_city,state,name")>
		<cfset handbooktags = model("Handbooktag").findMyTags(session.auth)>
		<cfset renderPage(layout="/handbook/layout_handbook1")>
	</cffunction>

	<!--- handbook-tags/show/key --->
	<cffunction name="show">
		<cfset usesLayout(template="/handbook/layout_handbook", except="download")>
		<cfset people = model("Handbookperson").findAll(where="p_sortorder < 900", include="Handbookstate,Handbookpositions", order="lname,fname,city", group ="id")>
		<cfset organizations = model("Handbookorganization").findAll(where="statusid IN (1,8)", include="Handbookstate", order="org_city,state,name")>

		<!--- Find the record --->
		<cfif isdefined("session.auth.username")>
	    	<cfset handbookTaggedPeople = model("Handbooktag").findAll(where="(username = '#session.auth.email#' OR username = '#session.auth.username#') AND tag='#params.key#' AND type='person'", include="Handbookperson(Handbookstate)", order="lname,fname")>
	    	<cfset handbookTaggedOrganizations = model("Handbooktag").findAll(where="(username = '#session.auth.email#' OR username = '#session.auth.username#') AND tag='#params.key#' AND type='organization'", include="Handbookorganization(Handbookstate)", order="name")>
		<cfelse>
	    	<cfset handbookTaggedPeople = model("Handbooktag").findAll(where="username = '#session.auth.email#' AND tag='#params.key#' AND type='person'", include="Handbookperson(Handbookstate)", order="lname,fname")>
	    	<cfset handbookTaggedOrganizations = model("Handbooktag").findAll(where="username = '#session.auth.email#' AND tag='#params.key#' AND type='organization'", include="Handbookorganization(Handbookstate)", order="name")>
		</cfif>
		<cfif isdefined("params.ajax")>
			<cfset renderPartial("show")>
		</cfif>

		<cfset renderPage(layout="/handbook/layout_handbook")>

	</cffunction>

	<cffunction name="download">

			<cfset showtitles = false>

		<cfif isdefined("session.auth.username")>
			<cfset TaggedPeople = model("Handbookperson").findAll(where="(username = '#session.auth.email#' OR username='#session.auth.username#') AND tag='#params.key#' AND type='person'", include="Handbooktags,Handbookstate,Handbookpositions(Handbookorganization)", order="lname,fname")>
			<cfset TaggedOrganizations = model("Handbookorganization").findAll(where="(username = '#session.auth.email#' OR username='#session.auth.username#') AND tag='#params.key#' AND type='organization' AND p_sortorder='1'", include="Handbooktags,Handbookstate,Handbookpositions(Handbookperson)", order="state_mail_abbrev,org_city,name")>
		<cfelse>
			<cfset TaggedPeople = model("Handbookperson").findAll(where="username = '#session.auth.email#' AND tag='#params.key#' AND type='person'", include="Handbooktags,Handbookstate,Handbookpositions(Handbookorganization)", order="lname,fname")>
			<cfset TaggedOrganizations = model("Handbookorganization").findAll(where="username = '#session.auth.email#' AND tag='#params.key#' AND type='organization' AND p_sortorder='1'", include="Handbooktags,Handbookstate,Handbookpositions(Handbookperson)", order="state_mail_abbrev,org_city,name")>
		</cfif>

		<cfif TaggedPeople.recordcount AND TaggedOrganizations.recordcount>
			<cfset showtitles = true>
		</cfif>

		<cfif isdefined("params.format") AND params.format is "excel">
			<cfset renderPage(template="download", layout="/layout_download")>
		<cfelse>
			<cfset renderPage(template="download", layout="/layout_naked")>
		</cfif>

	</cffunction>

	<!--- handbook-tags/new --->
	<cffunction name="new">
		<cfset handbooktag = model("Handbooktag").new()>
	</cffunction>

	<!--- handbook-tags/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset handbooktag = model("Handbooktag").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbooktag)>
	        <cfset flashInsert(error="Tag #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<cffunction name="search">
	<cfset var loc=structNew()>

		<cfif !isDefined("params.search") || !len(trim(params.search))>
	        <cfset flashInsert(error="Enter your search text in the space provided above")>
		  	<cfset returnBack()>
		</cfif>

		<cfset loc.peopleSearchString = "p_sortorder <= #getNonStaffSortOrder()# AND #getSearchString('lname,fname,city,email,position,prefix,suffix')#">
		<cfset loc.orgSearchString = "show_in_handbook = 1 AND #getSearchString('name,org_city,email,fein')#">
		<cfset loc.tagSearchString = "(username = '#session.auth.email#' OR username = '#session.auth.username#') AND tag LIKE '#params.search#%'">

		<cfif params.search contains "=">
		   <cfset loc.peopleSearchString = params.search>
		   <cfset loc.orgSearchString = params.search>
		   <cfset loc.tagSearchString = params.search>
		</cfif>

		<cftry>

		<cfset People = model("Handbookperson").findAll(
			   		where=loc.peopleSearchString,
					order="alpha",
					include="Handbookstate,Handbookpositions")>

		<cfif isDefined("params.tags")>
			  <cfloop query="people">
			  		  <cfset params.itemid = id>
					  <cfset setTags()>
			  </cfloop>
		</cfif>

		<cfcatch></cfcatch></cftry>

		<cftry>
		<cfset Organizations = model("Handbookorganization").findAll(
			   		where=loc.orgSearchString,
					include="Handbookstatus,Handbookstate",
					order="State")>
		<cfif isDefined("params.tags")>
			  <cfloop query="Organizations">
			  		  <cfset params.itemid = id>
					  <cfset setTags()>
			  </cfloop>
		</cfif>
		<cfcatch></cfcatch></cftry>

		<cftry>
		<cfset Tags = model("Handbooktag").findAll(
					where=loc.tagsearchstring,
					order="tag")>
		<cfcatch></cfcatch></cftry>

		<cfset renderPage(layout="/handbook/layout_handbook")>
	</cffunction>

	<cffunction name="getSearchString">
	<cfargument name="fieldlist">
	<cfset var loc=structNew()>
	<cfset loc.searchstring = "">

		<cfloop list = '#arguments.fieldlist#' index="i">
			<cfset loc.searchstring = loc.searchstring & " OR " & i & " like '" & "%" & params.search & "%" & "'">
		</cfloop>
		<cfset loc.searchstring = replace(loc.searchstring," OR ","","one")>

	<cfreturn loc.searchstring>

	</cffunction>

	<!--- handbook-tags/create --->
	<cffunction name="create">
		<cfset setTags()>
        <cfset returnBack()>
	</cffunction>

	<cffunction name="setTags">
	<cfargument name="itemid" default=#params.itemid#>
	<cfargument name="username" default='#params.username#'>
	<cfargument name="tags" default='#params.tags#'>
	<cfargument name="type" default='#params.type#'>
	<cfset var loc=structNew()>
	<cfset loc = arguments>

		<cfloop list="#loc.tags#" index="i">
			<cfset loc.tag = i>
			<cfset loc.check = model("Handbooktag").findOne(where="itemid = #loc.itemid# AND username = '#loc.username#' AND tag = '#loc.tag#'")>
			<cfif not isObject(loc.check)>
				<cfset loc.handbooktag = model("Handbooktag").new(loc)>
				<cfset loc.check =  loc.handbooktag.save()>
			</cfif>
		</cfloop>

	</cffunction>

	<cffunction name="shareTag">
	<cfargument name="tag" default="#params.tag#">
	<cfargument name="username" default="#params.username#">
	<cfargument name="newuserId" default="#params.newuserId#">
	<cfargument name="type" default="person">
	<cfset var loc=arguments>
	<cfset var args=structNew()>

	<cfset loc.newusername = model("Handbookperson").findOne(where="id=#loc.newuserId#", select="email").email>
	<cfif loc.newusername is "">
		<cfset flashInsert(success="This tag was NOT shared. This person does not have an email address in the handbook.")>
		<cfset returnBack()>
	</cfif>
	<cfset loc.tags =model("Handbooktag").findall(where="tag='#loc.tag#' AND username='#loc.username#'")>
		<cfloop query="loc.tags">
			<cfset args.itemid = itemid>
			<cfset args.tags = "#loc.tag#_from_#loc.username#">
			<cfset args.username = loc.newusername>
			<cfset setTags(argumentcollection=args)>
		</cfloop>

	<cfset flashInsert(success="This tag was shared with #loc.newusername#.")>

	<cfset returnBack()>
	</cffunction>

	<cffunction name="duplicateTag">
	<cfargument name="tag" default="#params.key#">
	<cfargument name="username" default="#session.auth.username#">
	<cfargument name="newuserId" default="#session.auth.userid#">
	<cfargument name="type" default="person">
	<cfset var loc=arguments>
	<cfset var args=structNew()>

	<cfset loc.newtag = loc.tag & "(copy)">

	<cfset loc.tags =model("Handbooktag").findall(where="tag='#loc.tag#' AND username='#loc.username#'")>

		<cfloop query="loc.tags">
			<cfset args.itemid = itemid>
			<cfset args.tags = loc.newtag>
			<cfset args.username = loc.username>
			<cfset args.type = loc.type>
			<cfset setTags(argumentcollection=args)>
		</cfloop>

	<cfset flashInsert(success="This tag was copied")>

	<cfset redirectTo(controller="handbook.tags", action="show", key=loc.newtag)>

	</cffunction>

	<!--- handbook-tags/update --->
	<cffunction name="update">
		<cfset handbooktag = model("Handbooktag").findByKey(params.key)>

		<!--- Verify that the handbooktag updates successfully --->
		<cfif handbooktag.update(params.handbooktag)>
			<cfset flashInsert(success="The handbooktag was updated successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbooktag.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- handbook-tags/delete/key --->
	<cffunction name="delete">
		<cfset handbooktag = model("Handbooktag").findByKey(params.key)>

		<!--- Verify that the handbooktag deletes successfully --->
		<cfif handbooktag.delete()>
			<cfset flashInsert(success="The handbooktag was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbooktag.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="removeFromTag">
		<cfif isdefined("session.auth.username")>
			<cfset removeFromTag = model("handbooktag").deleteAll(where="tag='#params.tag#' AND itemid = '#params.itemid#' AND (username = '#session.auth.email#' OR username = '#session.auth.username#')", class="tooltip2", title="Receive notices of updates via email.")>
		<cfelse>
			<cfset removeFromTag = model("handbooktag").deleteAll(where="tag='#params.key#' AND itemid = '#params.itemid#' AND username = '#session.auth.email#'", class="tooltip2", title="Receive notices of updates via email.")>
		</cfif>
		<cfset redirectTo(back=true)>
	</cffunction>

	<cffunction name="removeTag">
		<cfif isdefined("session.auth.username")>
			<cfset removeTag = model("handbooktag").deleteAll(where="tag='#params.key#' AND (username = '#session.auth.email#' OR username = '#session.auth.username#')", class="tooltip2", title="Receive notices of updates via email.")>
		<cfelse>
			<cfset removeTag = model("handbooktag").deleteAll(where="tag='#params.key#' AND username = '#session.auth.email#'", class="tooltip2", title="Receive notices of updates via email.")>
		</cfif>
		<cfset returnBack()>
	</cffunction>

	<cffunction name="changeTag">
		<cfif isdefined("session.auth.username")>
			<cfset newTag = model("handbooktag").updateAll(tag='#params.newtag#', where="tag='#params.key#' AND (username = '#session.auth.email#' OR username = '#session.auth.username#')")>
		<cfelse>
			<cfset newTag = model("handbooktag").updateAll(tag='#params.newtag#', where="tag='#params.key#' AND username = '#session.auth.email#'")>
		</cfif>
		<cfset redirectTo(action="show", key=params.newtag)>
	</cffunction>

</cfcomponent>
