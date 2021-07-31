<div id="welcome" class="container" style="margin:50px 0 30px 0">

    <cfoutput>
        <p>An email with a link to edit to the conference lodging assistance request  for <span style="font-size:1.3em; font-style:italic;">#name#</span> was sent to #mailto(email)#.</p>
        <p>&nbsp;</p>
        <p>You can view your request here: #linkto(controller="conference.lodgingrequests", action="show", params="id=#lodgingrequestid#", onlyPath=false)#</p>
    </cfoutput>

</div>