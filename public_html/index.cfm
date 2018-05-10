<!---Javascript Redirect--->
<script type="text/JavaScript">

    var oldlocation = toLowerCase(location.href);
    if ( !oldlocation.search('fgbc.org') == -1 ) {
        alert("hi");
        var newlocation = oldlocation.replace("fgbc.org","charisfellowship.us");
        console.log(newlocation);
        setTimeout(function () {
        window.location.href = newlocation; 
        }, 1000); 
        abort;
    }

</script>

    <cfinclude template="wheels/index.cfm">
