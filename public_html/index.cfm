<!---Javascript Redirect--->
<script type="text/JavaScript">

    var oldlocation = location.href;
    if ( oldlocation.includes('fgbc.org') ) {
        var newlocation = oldlocation.replace("fgbc.org","charisfellowship.us");
        console.log(newlocation);
        alert("Redirecting to charisfellowship.us");
        setTimeout(function () {
        window.location.href = newlocation; 
        }, 2000); 
        abort;
    }

</script>

<cfif !isDefined("url.redirect")>
<cfinclude template="wheels/index.cfm">
<cfelse>
<cfdump var="should redirect">
</cfif>