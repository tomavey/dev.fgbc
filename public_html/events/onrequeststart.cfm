<!--- Place code here that should be executed on the "onRequestStart" event. --->

<!---Redirect fgbc.org to charisfellowship.us with path and query string--->
<cfscript>

var hostsToRedirect = "fgbc.org,www.fgbc.org,charisfellowship.com,www.charisfellowship.com";
var thisHost = cgi.http_host;

if ( findNoCase(thisHost, hostsToRedirect) ){
    var newlocation = '//charisfellowship.us' & cgi.path_info & "?" & cgi.query_string; 
    location(url=newlocation, addToken="no");
}

function setKeyToKeyy() {
    if (isDefined("url.keyy") && len(url.keyy)) { url.key = url.keyy};
}

setKeyToKeyy()

</cfscript>

<cfloop collection="#form#" item="key">
<cftry>
<cfset form[key] = Trim(form[key])>
<cfcatch></cfcatch>
</cftry>
</cfloop>



