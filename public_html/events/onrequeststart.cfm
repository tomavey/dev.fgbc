
<!--- Place code here that should be executed on the "onRequestStart" event. --->

<cfscript>

if ( lcase(cgi.http_host) is 'fgbc.org' ){
    var newlocation = 'https://charisfellowship.us' & cgi.script_name & "/?" & cgi.query_string; 
    location(url = newlocation);
}

</cfscript>

<cfloop collection="#form#" item="key">
<cftry>
<cfset form[key] = Trim(form[key])>
<cfcatch></cfcatch>
</cftry>
</cfloop>



