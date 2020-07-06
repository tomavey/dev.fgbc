<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("handbooktags")>
		<cfset belongsTo(name="Handbookperson", modelName="Handbookperson", foreignKey="itemid")>
		<cfset belongsTo(name="Handbookorganization", modelName="Handbookorganization", foreignKey="itemid")>
	</cffunction>

	<cffunction name="findMyTagsForId">
	<cfargument name="id" required="true" type="numeric">
	<cfargument name="type" required="true" type="string">
		<cfif isdefined("session.auth.username")>
			<cfset tags = model("Handbooktag").findAll(where="itemid='#arguments.id#' AND type='#arguments.type#' AND (username = '#session.auth.email#' OR username='#session.auth.username#')")>
		<cfelse>
			<cfset tags = model("Handbooktag").findAll(where="itemid='#arguments.id#' AND type='#arguments.type#' AND username = '#session.auth.email#'")>
		</cfif>
		<cfreturn tags>
	</cffunction>

	<cfscript>
		function findMyTags(required struct auth) {
				var whereString = "username LIKE '%#session.auth.email#%'"
				if ( isDefined("session.auth.username") ) { whereString = whereString & " OR username LIKE '%#session.auth.username#%'" }
				if ( isDefined("session.auth.rightslist") ) { whereString = whereString & " OR username IN (#commaListToQuoteList(session.auth.rightslist)#)" }
				if ( isDefined("session.auth.coEmail") ) {  whereString = whereString & " OR username LIKE '%#session.auth.coEmail#%'" }
				var orderbyString = "tag"
				// throw(message=whereString)
				var tags = findAll(where = whereString, order = orderByString)
				return tags
		}
		
	</cfscript>

	<cffunction name="findAllPersonTags">
	<cfargument name="tags" required="true" type="string">
	<cfargument name="tagsusername" required="true" type="string">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
	<cfset loc.return = queryNew("id")><!---Creates an empty query--->
	<cfloop list="#loc.tags#" index="loc.i">
		<cfset loc.tags = findAll(select="fname,lname,id,email,email2,fullname", where="tag='#loc.i#' AND username = '#loc.tagsusername#' AND type='person'", include="Handbookperson")>
		<cfset loc.return = queryAppend(loc.return,loc.tags)>
	</cfloop>

	<cfreturn loc.return>

	</cffunction>

	<cffunction name="findAllTags">
	<cfargument name="tags" required="true" type="string">
	<cfargument name="tagsusername" required="true" type="string">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
		<cfset loc.return = findAllPersonTags(loc.tags,loc.tagsusername)>
	<cfreturn loc.return>
	</cffunction>

</cfcomponent>