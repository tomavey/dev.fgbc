<!---Javascript Redirect--->
<script type="text/JavaScript">

    var oldlocation = location.href;
    if ( oldlocation.includes('fgbc.org') ) {
        var newlocation = oldlocation.replace("fgbc.org","charisfellowship.us");
        console.log(newlocation);
        setTimeout(function () {
        window.location.href = newlocation; 
        }, 1000); 
        abort;
    }

</script>

<cfif !findNoCase('fgbc.org',cgi.SERVER_NAME) >
    <cfinclude template="wheels/index.cfm">
</cfif>