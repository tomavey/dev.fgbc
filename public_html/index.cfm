<!---Javascript Redirect--->
<script type="text/JavaScript">

    var oldlocation = location.href;
    if ( oldlocation.search('fgbc.org') === 1 ) {

        var newlocation = oldlocation.replace("fgbc.org","charisfellowship.us");
        console.log(newlocation);
        alert("Redirecting to charisfellowship.us");
        setTimeout(function () {
        window.location.href = newlocation; 
        }, 2000); 
        abort;
    }

</script>

<cfinclude template="wheels/index.cfm">