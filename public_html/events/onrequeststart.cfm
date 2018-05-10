
<!--- Place code here that should be executed on the "onRequestStart" event. --->

<!---Redirect fgbc.org to charisfellowship.us with path and query string--->
<cfscript>

if ( lcase(cgi.http_host) is 'fgbc.org' ){
    var newlocation = '//charisfellowship.us' & cgi.path_info & "?" & cgi.query_string; 
    location(url=newlocation, addToken="no");
}

</cfscript>

<cfloop collection="#form#" item="key">
<cftry>
<cfset form[key] = Trim(form[key])>
<cfcatch></cfcatch>
</cftry>
</cfloop>



