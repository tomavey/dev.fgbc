<script type="text/JavaScript">
var newlocation = "http://charisfellowship.us";
var oldlocation = location.href;
if (oldlocation.search("/handbook") || oldlocation.search("/focus")){
    newlocation = oldlocation.replace("fgbc.org","charisfellowship.us")
};
console.log(newlocation);
setTimeout(function () {
   window.location.href = newlocation; 
}, 2000); 
</script>

<cfinclude template="wheels/index.cfm">