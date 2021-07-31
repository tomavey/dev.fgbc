<cfoutput>
<h2>Your new church record has been started.  Use this link to complete the form:</h2>
<p>#linkto(controller="membership.newchurches", action="edit", key=newchurch.uuid, onlyPath=false)#
</p>
</cfoutput>