<!---Javascript Redirect--->
<script type="text/JavaScript">

    var oldlocation = location.href.toLowerCase();
    var oldlocationindex = oldlocation.indexOf('fgbc.org');
    if ( oldlocationindex !== -1 ) {
        var newlocation = oldlocation.replace("fgbc.org","charisfellowship.us");
        console.log(newlocation);
        setTimeout(function () {
        window.location.href = newlocation; 
        }, 1000); 
        abort;
    }

</script>

<cfif lcase(cgi.SERVER_NAME) NEQ 'fgbc.org'>
    <cfinclude template="wheels/index.cfm">
</cfif>

