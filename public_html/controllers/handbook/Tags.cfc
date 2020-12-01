component extends="Controller" output="true" {

		function config() {
		usesLayout(template="/handbook/layout_handbook1", except="download,show,search");
		filters(through="gotBasicHandbookRights");
		provides("html,xml,json");
		filters(through="logview", type="after");
		filters(through="setreturn", only="index,show");
		filters(through="setFlashTagUsername");
	}
	

//-------------------------->
//--------FILTERS----------->
//-------------------------->

	function setFlashTagUsername(userName){
		try {
			flashInsert(username=session.auth.username)
		} catch (any e) {}
	}



<!-------------------------->
<!--------CRUD-------------->
<!-------------------------->

	//  handbook-tags/index 
	function index() {
		setCoUserName(params);
		people = model("Handbookperson").findAll(where="p_sortorder < 900", include="Handbookstate,Handbookpositions", order="lname,fname,city");
		organizations = model("Handbookorganization").findAll(where="statusid IN (1,8,2)", include="Handbookstate", order="org_city,state,name");
		handbooktags = model("Handbooktag").findMyTags(session.auth);
		renderView(layout="/handbook/layout_handbook1");
	}

	//  handbook-tags/show/key 
	function show() {
		var whereString = "";
		setCoUserName(params);
		usesLayout(template="/handbook/layout_handbook", except="download");
		people = model("Handbookperson").findAll(select="id, lname, fname, selectName, email", where="p_sortorder < 900", include="Handbookstate,Handbookpositions", order="selectname", group ="id");
		organizations = model("Handbookorganization").findAll(select="id, name, selectNameCity, email", where="statusid IN (1,8)", include="Handbookstate", order="selectNameCity");
		//  Find the record 
		if ( isdefined("session.auth.username") ) {
			whereString = "(
						username LIKE '%#session.auth.email#%' 
						OR username LIKE '%#session.auth.username#%'
						OR username IN (#commaListToSingleQuoteList(session.auth.rightslist)#)
						) 
						AND tag='#params.key#'";
			handbookTaggedPeople = model("Handbooktag").findAll(where=whereString & " AND type='person'", include="Handbookperson(Handbookstate)", order="lname,fname");
			handbookTaggedOrganizations = model("Handbooktag").findAll(where=whereString & " AND type='organization'", include="Handbookorganization(Handbookstate)", order="name");
		} else {
			whereString = "username LIKE '%#session.auth.email#%' AND tag='#params.key#'";
			handbookTaggedPeople = model("Handbooktag").findAll(where=whereString & " AND type='person'", include="Handbookperson(Handbookstate)", order="lname,fname");
			handbookTaggedOrganizations = model("Handbooktag").findAll(where=whereString & " AND type='organization'", include="Handbookorganization(Handbookstate)", order="name");
		}
		session.tags.tagids = valueList(handbookTaggedPeople.id) & ',' & valueList(handbookTaggedOrganizations.id)
		if ( isDefined("handbookTaggedPeople.username") ) {
			session.tags.usernames = handbookTaggedPeople.username
		} else {
			session.tags.usernames = handbookTaggedOrganizations.username
		}


		var tagUserName = ""
		if ( isDefined("handbookTaggedPeople.userName") ) {
			tagUserName = handbookTaggedPeople.username[1]
		} else if ( isDefined("handbookTaggedOrganizations.userName") ) {
			tagUserName = handbookTaggedOrganizations.username[1]
		}

		if ( isDefined("cookie.HANDBOOKEMAILDELIMITER") ) {
			emailDelimiter = cookie.HANDBOOKEMAILDELIMITER;
		}
		if ( isDefined("params.emailDelimiter") ) {
			emailDelimiter = params.emailDelimiter;
			cfcookie( expires="never", name="HANDBOOKEMAILDELIMITER", value=params.emailDelimiter );
		}
		if ( !isDefined("params.key") && isDefined("params.tag") ) {
			params.key = params.tag;
		}
		

		if ( isdefined("params.ajax") ) {
			renderPartial("show");
		}
		renderView(layout="/handbook/layout_handbook");
	}

	//  handbook-tags/new 
	function new() {
		handbooktag = model("Handbooktag").new();
	}

	//  handbook-tags/edit/key 
	function edit() {
		//  Find the record 
		handbooktag = model("Handbooktag").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(handbooktag) ) {
			flashInsert(error="Tag #params.key# was !found");
			redirectTo(action="index");
		}
	}

	// handbook-tags/create
	function create(){
		setTags(params.itemid,params.username,params.tags,params.type)
		if (params.type == "person") {
			flashInsert(success="A person was added to this tag")
		} else {
			flashInsert(success="An organization was added to this tag")
		}
		returnBack()
	}

	//  handbook-tags/update 
	function update() {
		handbooktag = model("Handbooktag").findByKey(params.key);
		//  Verify that the handbooktag updates successfully 
		if ( handbooktag.update(params.handbooktag) ) {
			flashInsert(success="The handbooktag was updated successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the handbooktag.");
			renderView(action="edit");
		}
	}

	//  handbook-tags/delete/key 
	function delete() {
		handbooktag = model("Handbooktag").findByKey(params.key);
		//  Verify that the handbooktag deletes successfully 
		if ( handbooktag.delete() ) {
			flashInsert(success="The handbooktag was deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the handbooktag.");
			redirectTo(action="index");
		}
	}

<!------------------------------>
<!-----------END OF CRUD-------->
<!------------------------------>







<!------------------------------------------->
<!---------SHARING AND MANIPULATING---------->
<!------------------------------------------->

	//Used in tags.show to change the name of a tag
	function changeTag(tagIds = session.tags.tagids, newtag=params.newtag) {
		tagIds = listToArray(tagids)
		arrayEach(tagIds,function(item){
			model("handbooktag").updateAll(where="id=#val(item)#", tag='#newtag#')
		})
		redirectTo(action="show", key=params.newtag);
	}

	//Used in tags.show to create a copy of a tag for the same username		
	public function duplicateTag(
		tag=params.key,
		userName=session.auth.userName,
		tagIds=session.tags.tagids,
		newuserId=session.auth.userid,
		type="person"
	){
		var loc = arguments
		var args = {}
		loc.newTag = tag & " (copy)"
		listEach(loc.tagIds,function(item){
			loc.tag = model("Handbooktag").findOne(where="id=#item#")
			if ( isObject(loc.tag) ){
				args.itemid = loc.tag.itemid
				args.tags = loc.newtag
				args.type = loc.type
				args.username = loc.username
				setTags(argumentCollection=args)
			}
		})
		if ( isDefined("loc.tag.tag") ) { flashInsert(success="This is a copy of #loc.tag.tag#. Rename if needed.") }
		redirectTo(controller="handbook.tags", action="show", key=loc.newtag)
		}	
		
	//Used in tags.show to send a copy of a tag to another user
	void function copyTags(tag=params.tag, username=params.username, newuserName = params.newUserName)	{
		var loc = arguments
		var tags = model("Handbooktag").findAll(where="tag = '#params.tag#' AND username LIKE '%#params.username#%'")
		var tag
		var newTag = {}
		if (find("@",username)){
			username = left(username,find("@",username)-1)
		}
		queryEach(tags, function(el){
			newTag.username = loc.newUserName
			newTag.tag = loc.tag & " sent from #username#"
			newTag.itemid = el.itemid
			newTag.type = el.type
			model("Handbooktag").new(newTag).save()
		} )
		flashInsert(success="A copy of this tag was sent to #loc.newusername#.")
		redirectTo(action="show", key=params.tag)
	}
	
	//User in tags.show to share a tag with another user by username or email	
	void function shareTag(tag=params.tag, username=params.username, newuserName = params.newUserName) {
		var loc = arguments
		//find all tags for this username/type and tag
		loc.tagIds = listToArray(session.tags.tagids)
		// dd(loc)
		arrayEach(loc.tagIds,function(el){
			loc.tag = model("Handbooktag").findOne(where="id=#el#")
			//add newusername to username string
			loc.tag.username = loc.tag.username & "," & loc.newusername
			loc.tag.username = removeDuplicatesFromList(loc.tag.username)
			loc.tag.save()
		})
		flashInsert(success="This tag is now shared with #loc.newusername#.")
		redirectTo(action="show", key=params.tag)
		// dd(loc)
	}
	
	//Used on tags.show to share a tag with all users with the same rights in their session.auth.rightslist
	function shareTagWithGroup(params) {
		var loc = params
		var tags = model("Handbooktag").findall(where="tag='#loc.tag#' AND username='#loc.username#'")
		for ( tag in tags ) {
			var thisTag = model("Handbooktag").findOne(where="id=#tag.id#")
			thisTag.username = loc.usergroup
			thisTag.update()
		}
		flashInsert(success="This tag was shared with #loc.usergroup#.")
		redirectTo(action="show", key=params.tag)
	}
	
	//Removes a person or organization from a tag
	function removeFromTag(){
		var whereString = "tag='#params.tag#' AND itemid = '#params.itemid#'"
		if ( isDefined("params.username") ) {
			whereString = whereString & " AND username LIKE '%#params.username#%'"
		} else if ( isDefined("session.auth.username") ) {
			whereString = whereString & " AND (username LIKE '%#session.auth.email#%' OR username LIKE '%#session.auth.username#%')"
		} else {
			whereString = "tag='#params.key#' AND itemid = '#params.itemid#' AND username LIKE '%#session.auth.email#%'"
		}
		var removeFromTag = model("handbooktag").deleteAll(where=whereString, title="Receive notices of updates via email.")
		redirectTo(back=true)
	}

	//Removed a string of tags on tagids
	function remove(
		tagids = session.tags.tagids,
		tag = params.tag
		) {
			var whereString = ""
			tagIds = listToArray(tagids)
			for (id in tagids) {
				// dd(id)
				whereString = "id=#val(id)#" 				
				thisTag = model("handbooktag").deleteAll(where=whereString)
			}
			flashInsert(success="#tag# was removed")
			redirectTo(action="index")
	}
		
<!------------------------------->
<!---------END OF SHARING-------->
<!------------------------------->







<!------------------------------->
<!---------REPORTS--------------->
<!------------------------------->

	function download() {
		showtitles = false;
		var whereString = "(
				username LIKE '%#session.auth.email#%' 
				OR username LIKE '%#session.auth.username#%'
				OR username IN (#commaListToSingleQuoteList(session.auth.rightslist)#)
				) 
				AND tag='#params.key#'";
		if ( isdefined("session.auth.username") ) {
			TaggedPeople = model("Handbookperson").findAll(where=whereString & " AND type='person'", include="Handbooktags,Handbookstate,Handbookpositions(Handbookorganization)", order="lname,fname");
			TaggedOrganizations = model("Handbookorganization").findAll(where=whereString & " AND type='organization' AND p_sortorder='1'", include="Handbooktags,Handbookstate,Handbookpositions(Handbookperson)", order="state_mail_abbrev,org_city,name");
		} else {
			whereString = "username LIKE '%#session.auth.email#%' AND tag='#params.key#'";
			TaggedPeople = model("Handbooktag").findAll(where=whereString & " AND type='person'", include="Handbookperson(Handbookstate)", order="lname,fname");
			TaggedOrganizations = model("Handbooktag").findAll(where=whereString & " AND type='organization'", include="Handbookorganization(Handbookstate)", order="name");
		}
		if ( TaggedPeople.recordcount && TaggedOrganizations.recordcount ) {
			showtitles = true;
		}
		if ( isdefined("params.format") && params.format == "excel" ) {
			renderView(template="download", layout="/layout_download");
		} else {
			renderView(template="download", layout="/layout_naked");
		}
	}

	
	function search() {
		var loc=structNew();
		// Check to make sure a search string has been provided
		if ( !isDefined("params.search") || !len(trim(params.search)) ) {
			flashInsert(error="Enter your search text in the space provided above");
			returnBack();
		}
		// Set whereStrings for people, organizations and tags
		loc.peopleSearchString = "p_sortorder <= #getNonStaffSortOrder()# AND #getSearchString('lname,fname,city,email,position,prefix,suffix')#";
		loc.orgSearchString = "show_in_handbook = 1 AND #getSearchString('name,org_city,email,fein')#";
		loc.tagSearchString = "(username = '#session.auth.email#' OR username = '#session.auth.username#') AND tag LIKE '#params.search#%'";
		// If the search string contains = , the use the string for the whereString
		if ( params.search contains "=" ) {
			loc.peopleSearchString = params.search;
			loc.orgSearchString = params.search;
			loc.tagSearchString = params.search;
		}
		// Try to Get People
		try {
			People = model("Handbookperson").findAll(
			where=loc.peopleSearchString,
			order="alpha",
			include="Handbookstate,Handbookpositions");
		} catch (any cfcatch) {
		}
		// Try to Get Organizations
		try {
			Organizations = model("Handbookorganization").findAll(
						where=loc.orgSearchString,
					include="Handbookstatus,Handbookstate",
					order="State");
		} catch (any cfcatch) {
		}
		// Try to Get Tags
		try {
			Tags = model("Handbooktag").findAll(
					where=loc.tagsearchstring,
					order="tag");
		} catch (any cfcatch) {
		}
		renderView(layout="/handbook/layout_handbook");
	}
	
	function orphanedTags(){
		orphanedTags = model("Handbooktag").findOrphanedTags	()
	}

<!------------------------------->
<!---------END OF REPORTS-------->
<!------------------------------->






<!------------------------------->
<!---------SERVICES-------------->
<!------------------------------->

	void function setTags(itemid,username,tags,type) {
		var loc = arguments
		//convert list to array so I can arrayEach()
		var tagsArray = listToArray(loc.tags)
		//used session.tempUserName if set
		// if ( isDefined("session.temp.tagUserName") ) { loc.username = session.temp.tagUserName }
		clearSessionTemp()
		//Iterate over tagsArray and check make sure not a duplicate then set the tag if new
		arrayEach(tagsArray, function(tag){
				loc.check = model("Handbooktag").findOne(where="itemid = #loc.itemid# AND username LIKE '%#loc.username#%' AND tag = '#tag#'")
				if ( !isObject(loc.check) ) {
					loc.handbooktag = model("Handbooktag").new(itemid = loc.itemid,username= loc.username,tag = tag, type=loc.type)
					loc.check = loc.handbooktag.save()
				}
			}
		)	
	}

	void function clearSessionTemp(){
		structDelete(session,"temp")
	}

	function getSearchString(fieldlist) {
		var loc=structNew();
		loc.searchstring = "";
		for ( loc.i in fieldlist ) {
			loc.searchstring = loc.searchstring & " OR " & loc.i & " like '" & "%" & params.search & "%" & "'";
		}
		loc.searchstring = replace(loc.searchstring," OR ","","one");
		return loc.searchstring;
		ddd(loc.searchString)
	}
	
	private function setCoUserName(params) {
		if ( isDefined("params.coUsername") && isDefined( "session.auth.username")) {
			session.auth.coUsername = params.coUserName
		}
	}

	function deleteOrphanedTags(){
		orphanedTags = model("Handbooktag").findOrphanedTags()
		queryEach(orphanedTags, function(el){
			var tag = model("Handbooktag").findOne(where="id=#el.id#")
			tag.delete()
		})
		redirectTo(action="orphanedTags")
	}

	function queryReverse(originalQuery, columnName) {
		var reversedQuery = querySort(originalQuery,(a,b) => {
			if ( a[columnName] < b[columnName] ) { return 1 }
			return -1
		})
		return reversedQuery
	}
<!------------------------------->
<!---------END OF SERVICES------->
<!------------------------------->
	



<!---------------------->
<!-----TRASH------------>
<!---------------------->
<!--- 
	<cffunction name="XsetTags">
	<cfargument name="itemid" default=#params.itemid#>
	<cfargument name="username" default='#params.username#'>
	<cfargument name="tags" default='#params.tags#'>
	<cfargument name="type" default='#params.type#'>
	<cfset var loc=structNew()>
	<cfset loc = arguments>
	<cfscript>
		if ( isDefined("session.temp.tagUserName") ) { loc.username = session.temp.tagUserName }
		clearSessionTemp()
	</cfscript>

		<cfloop list="#loc.tags#" index="loc.tag">
			<cfset loc.check = model("Handbooktag").findOne(where="itemid = #loc.itemid# AND username LIKE '%#loc.username#%' AND tag = '#loc.tag#'")>
			<cfif not isObject(loc.check)>
				<cfset loc.handbooktag = model("Handbooktag").new(loc)>
				<cfset loc.check =  loc.handbooktag.save()>
			</cfif>
		</cfloop>

	</cffunction>

	<cffunction name="XshareTag">
	<cfargument name="tag" default="#params.tag#">
	<cfargument name="username" default="#params.username#">
	<cfargument name="newuserId" default="#params.newuserId#">
	<cfargument name="shareOrCopy" default="#params.shareOrCopy#">
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
			<cfif loc.shareOrCopy === "copy">
				<cfset args.tags = "#loc.tag#_from_#loc.username#">
				<cfset args.username = loc.newusername>
			<cfelse>	
				<cfset args.tags = "#loc.tag#">
				<cfset args.username = loc.username & "," & loc.newusername>
			</cfif>
	<cfscript>
		throw(serialize(args))
	</cfscript>
	<cfset setTags(argumentcollection=args)>
		</cfloop>

	<cfset flashInsert(success="This tag was shared with #loc.newusername#.")>

	<cfset returnBack()>
	</cffunction>

	<cffunction name="XremoveFromTag">
		<cfif isdefined("session.auth.username")>
			<cfset removeFromTag = model("handbooktag").deleteAll(where="tag='#params.tag#' AND itemid = '#params.itemid#' AND (username = '#session.auth.email#' OR username = '#session.auth.username#')", class="tooltip2", title="Receive notices of updates via email.")>
		<cfelse>
			<cfset removeFromTag = model("handbooktag").deleteAll(where="tag='#params.key#' AND itemid = '#params.itemid#' AND username = '#session.auth.email#'", class="tooltip2", title="Receive notices of updates via email.")>
		</cfif>
		<cfset redirectTo(back=true)>
	</cffunction>

<cfscript>

</cfscript>

	<!--- <cffunction name="Xremove">
		<cfif isdefined("session.auth.username")>
			<cfset removeTag = model("handbooktag").deleteAll(where="tag='#params.tag#' AND (username = '#session.auth.email#' OR username = '#session.auth.username#')", class="tooltip2", title="Receive notices of updates via email.")>
		<cfelse>
			<cfset removeTag = model("handbooktag").deleteAll(where="tag='#params.tag#' AND username = '#session.auth.email#'", class="tooltip2", title="Receive notices of updates via email.")>
		</cfif>
		<cfset returnBack()>
	</cffunction> --->

	<!--- handbook-tags/show/key --->
	<cffunction name="Xshow">
		<cfset var whereString = "">
		<cfset setCoUserName(params)>
		<cfset usesLayout(template="/handbook/layout_handbook", except="download")>
		<cfset people = model("Handbookperson").findAll(where="p_sortorder < 900", include="Handbookstate,Handbookpositions", order="lname,fname,city", group ="id")>
		<cfset organizations = model("Handbookorganization").findAll(where="statusid IN (1,8)", include="Handbookstate", order="org_city,state,name")>

		<!--- Find the record --->
		<cfif isdefined("session.auth.username")>
				<cfset whereString = "(
					username LIKE '%#session.auth.email#%' 
					OR username LIKE '%#session.auth.username#%'
					OR username IN (#commaListToSingleQuoteList(session.auth.rightslist)#)
					) 
					AND tag='#params.key#'" 
					>
				<!--- <cfthrow message=#commaListToSingleQuoteList(session.auth.rightslist)#> --->
	    	<cfset handbookTaggedPeople = model("Handbooktag").findAll(where=whereString & " AND type='person'", include="Handbookperson(Handbookstate)", order="lname,fname")>
	    	<cfset handbookTaggedOrganizations = model("Handbooktag").findAll(where=whereString & " AND type='organization'", include="Handbookorganization(Handbookstate)", order="name")>
		<cfelse>
				<cfset whereString = "username LIKE '%#session.auth.email#%' AND tag='#params.key#'">
	    	<cfset handbookTaggedPeople = model("Handbooktag").findAll(where=whereString & " AND type='person'", include="Handbookperson(Handbookstate)", order="lname,fname")>
	    	<cfset handbookTaggedOrganizations = model("Handbooktag").findAll(where=whereString & " AND type='organization'", include="Handbookorganization(Handbookstate)", order="name")>
		</cfif>
		<cfscript>
			session.tags.tagids = valueList(handbookTaggedPeople.id) & valueList(handbookTaggedOrganizations.id)
			var tagUserName = ""
			if ( isDefined("handbookTaggedPeople.userName") ) {
				tagUserName = handbookTaggedPeople.username[1]
			} else if ( isDefined("handbookTaggedOrganizations.userName") ) {
				tagUserName = handbookTaggedOrganizations.username[1]
			}
		</cfscript>
		<cfif isdefined("params.ajax")>
			<cfset renderPartial("show")>
		</cfif>

		<cfset renderView(layout="/handbook/layout_handbook")>

	</cffunction>

	<cffunction name="Xsearch">
		<cfset var loc=structNew()>
		<!--- <cfdump var="#params#"><cfabort> --->
			<!---Check to make sure a search string has been provided--->
			<cfif !isDefined("params.search") || !len(trim(params.search))>
						<cfset flashInsert(error="Enter your search text in the space provided above")>
					<cfset returnBack()>
			</cfif>
		
			<!---Set whereStrings for people, organizations and tags--->
			<cfset loc.peopleSearchString = "p_sortorder <= #getNonStaffSortOrder()# AND #getSearchString('lname,fname,city,email,position,prefix,suffix')#">
			<cfset loc.orgSearchString = "show_in_handbook = 1 AND #getSearchString('name,org_city,email,fein')#">
			<cfset loc.tagSearchString = "(username = '#session.auth.email#' OR username = '#session.auth.username#') AND tag LIKE '#params.search#%'">
		
			<!---If the search string contains = , the use the string for the whereString--->
			<cfif params.search contains "=">
				 <cfset loc.peopleSearchString = params.search>
				 <cfset loc.orgSearchString = params.search>
				 <cfset loc.tagSearchString = params.search>
			</cfif>
		
			<!---Try to Get People--->	
			<cftry>
			<cfset People = model("Handbookperson").findAll(
				where=loc.peopleSearchString,
				order="alpha",
				include="Handbookstate,Handbookpositions")>
		
			<cfcatch></cfcatch></cftry>
		
			<!---Try to Get Organizations--->	
			<cftry>
			<cfset Organizations = model("Handbookorganization").findAll(
							 where=loc.orgSearchString,
						include="Handbookstatus,Handbookstate",
						order="State")>
		
			<cfcatch></cfcatch></cftry>
		
			<!---Try to Get Tags--->	
			<cftry>
			<cfset Tags = model("Handbooktag").findAll(
						where=loc.tagsearchstring,
						order="tag")>
			<cfcatch></cfcatch></cftry>
		
			<cfset renderView(layout="/handbook/layout_handbook")>
		</cffunction> --->
		
	}