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

<cfif !isDefined("url.redirect")>
<cfinclude template="wheels/index.cfm">
<cfelse>
<cfdump var="should redirect">
</cfif>