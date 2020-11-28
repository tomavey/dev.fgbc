<h1>Thank You</h1>
<cfoutput>
<cftry>
<p>You can use this link to edit this form: #linkto(controller="membership.newchurches", action="edit", key=newchurch.uuid, onlyPath=false)#
</p>
<cfcatch></cfcatch></cftry>

#includePartial(partial="show")#

</cfoutput>

