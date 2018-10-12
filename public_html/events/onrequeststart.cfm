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
    if (isDefined("params.keyy") && len(params.keyy)) { params.key = params.keyy};
}

setKeyToKeyy()

</cfscript>

<cfloop collection="#form#" item="key">
<cftry>
<cfset form[key] = Trim(form[key])>
<cfcatch></cfcatch>
</cftry>
</cfloop>



