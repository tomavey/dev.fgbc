<!---Javascript Redirect--->
<script type="text/JavaScript">

    var oldlocation = location.href.toLowerCase();
    var oldlocationindex = oldlocation.indexOf('fgbc.org');
    alert(oldlocationindex);
    if ( oldlocation.indexOf('fgbc.org') !== -1 ) {
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
