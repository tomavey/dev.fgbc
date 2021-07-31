<cfoutput>
<div style="margin:20px; padding:20px; font-size:1.5em; border:2px solid gray">
    <p>A new cooperating ministry application has been started for <span style="font-size:1.3em; font-style:italic;"> #ministryname# </span>.  Use this link to complete or edit the application:
    #linkto(controller="membership.newministries", action="new", params="id=#ministryid#", onlyPath=false)#</p>
    <p>You can view your application here: #linkto(controller="ministry.newministries", action="show", params="id=#ministryid#", onlyPath=false)#</p>
</cfoutput>