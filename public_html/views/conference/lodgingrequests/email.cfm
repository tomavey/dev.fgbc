<cfoutput>
<div style="margin:20px; padding:20px; font-size:1.5em; border:2px solid gray">
    <p>A new conference lodqing assistance request has been started for <span style="font-size:1.3em; font-style:italic;"> #name# </span>.  Use this link to complete or edit the application:
    #linkto(controller="conference.lodgingrequests", action="new", params="id=#lodgingrequestid#", onlyPath=false)#</p>
    <p>You can view your application here: #linkto(controller="conference.lodgingrequests", action="show", params="id=#lodgingrequestid#", onlyPath=false)#</p>
</div>
</cfoutput>