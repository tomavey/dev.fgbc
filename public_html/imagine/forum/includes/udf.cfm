<cfsetting enablecfoutputonly=true>
<!---
	Name         : udf.cfm
	Author       : Raymond Camden 
	Created      : June 01, 2004
	Last Updated : October 12, 2007
	History      : Reset for V2
	Purpose		 : 
--->

<cfscript>
function isLoggedOn() {
	return structKeyExists(session, "user");
}
request.udf.isLoggedOn = isLoggedOn;

function getGroups() {
	if(request.udf.isLoggedOn()) return session.user.groupids;
	return "";
}
request.udf.getGroups = getGroups;

/**
 * Tests passed value to see if it is a valid e-mail address (supports subdomain nesting and new top-level domains).
 * Update by David Kearns to support '
 * SBrown@xacting.com pointing out regex still wasn't accepting ' correctly.
 * 
 * @param str 	 The string to check. (Required)
 * @return Returns a boolean. 
 * @author Jeff Guillaume (jeff@kazoomis.com) 
 * @version 2, August 15, 2002 
 */
function IsEmail(str) {
//supports new top level tlds
if (REFindNoCase("^['_a-z0-9-]+(\.['_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name))$",str)) return TRUE;
	else return FALSE;
}
request.udf.isEmail = isEmail;

function isValidUsername(str) {
	if(reFindNoCase("[^a-z0-9]",str)) return false;
	return true;
}
request.udf.isValidUsername = isValidUsername;

/**
 * Returns a XHTML compliant string wrapped with properly formatted paragraph tags.
 * 
 * @param string 	 String you want XHTML formatted. 
 * @param attributeString 	 Optional attributes to assign to all opening paragraph tags (i.e. style=""font-family: tahoma""). 
 * @return Returns a string. 
 * @author Jeff Howden (jeff@members.evolt.org) 
 * @version 1.1, January 10, 2002 
 */
function XHTMLParagraphFormat(string) {
  var attributeString = '';
  var returnValue = '';
  
  //added by me to support different line breaks
  string = replace(string, chr(10) & chr(10), chr(13) & chr(10), "all");
  
  if(ArrayLen(arguments) GTE 2) attributeString = ' ' & arguments[2];
  if(Len(Trim(string)))
    returnValue = '<p' & attributeString & '>' & Replace(string, Chr(13) & Chr(10), '</p>' & Chr(13) & Chr(10) & '<p' & attributeString & '>', 'ALL') & '</p>';
  return returnValue;
}

request.udf.XHTMLParagraphFormat = XHTMLParagraphFormat;


/*
 This function returns asc or desc, depending on if the current dir matches col
*/
function dir(col) {
	if(isDefined("url.sort") and url.sort is col and isDefined("url.sortdir") and url.sortdir is "asc") return "desc";
	return "asc";
}
request.udf.dir = dir;

function headerLink(col) {
	var str = "";
	var colname = arguments.col;
	var qs = cgi.query_string;
	
	if(arrayLen(arguments) gte 2) colname = arguments[2];
	
	// can't be too safe
	if(not isDefined("url.sort")) url.sort = "";
	if(not isDefined("url.sortdir")) url.sortdir = "";
	
	//clean qs
	qs = reReplaceNoCase(qs, "&*sort=[^&]*","");
	qs = reReplaceNoCase(qs, "&*sortdir=[^&]*","");
	qs = reReplaceNoCase(qs, "&*page=[^&]*","");
	qs = reReplaceNoCase(qs, "&*logout=[^&]*","");
	qs = reReplaceNoCase(qs, "&{2,}","");
	if(len(qs)) qs = qs & "&";
	
	if(url.sort is colname) str = str & "[";
	str = str & "<a href=""#cgi.script_name#?#qs#sort=#urlEncodedFormat(colname)#&sortdir=" & dir(colname) & """>#col#</a>";
	if(url.sort is colname) str = str & "]";
	return str;
}
request.udf.headerLink = headerLink;
</cfscript>

<!--- provides a cached way to get user info --->
<cffunction name="cachedUserInfo" returnType="struct" output="false">
	<cfargument name="username" type="string" required="true">
	<cfargument name="usecache" type="boolean" required="false" default="true">
	<cfargument name="userid" type="boolean" required="false" default="false">
	<cfset var userInfo = "">
	
	<cfif not isDefined("application.userCache")>
		<cfset application.userCache = structNew()>
		<cfset application.userCache_created = now()>
	</cfif>
	
	<cfif dateDiff("h",application.userCache_created,now()) gte 2>
		<cfset structClear(application.userCache)>
		<cfset application.userCache_created = now()>
	</cfif>

	<!--- New argument, userid, if true, we first convert from ID to username --->
	<cfif arguments.userid>
		<cfset arguments.username = application.user.getUsernameFromID(arguments.username)>
	</cfif>
	
	<cfif structKeyExists(application.userCache, arguments.username) and arguments.usecache>
		<cfreturn duplicate(application.userCache[arguments.username])>
	</cfif>
	
	<cfset userInfo = application.user.getUser(arguments.username)>
	<!--- Get a rank for their posts --->
	<cfset userInfo.rank = application.rank.getHighestRank(userInfo.postCount)>
	
	<cfset application.userCache[arguments.username] = userInfo>
	<cfreturn userInfo>
	
</cffunction>
<cfset request.udf.cachedUserInfo = cachedUserInfo>

<cffunction name="querySortManual" returnType="query" output="false">
	<cfargument name="query" type="query" required="true">
	<cfargument name="column" type="string" required="true">
	<cfargument name="direction" type="string" required="true">
	<cfset var result = "">
	<cfset var stickyStr = "sticky ">
	
	<cfif findNoCase("sticky", query.columnlist)>
		<cfset stickyStr = stickyStr & "desc,">
	<cfelse>
		<cfset stickyStr = "">
	</cfif>
	
	<cfif not listFindNoCase(query.columnList, column)>
		<cfreturn query>
	</cfif>
	
	<cfif not listFindNoCase("asc,desc", arguments.direction)>
		<cfset arguments.direction = "asc">
	</cfif>
	
	<cfquery name="result" dbtype="query">
	select		*
	from		arguments.query
	order by 	#stickyStr# #arguments.column# #arguments.direction#
	</cfquery>
	
	<cfreturn result>
</cffunction>
<cfset request.udf.querySort = querySortManual>
	
<cfsetting enablecfoutputonly=false>