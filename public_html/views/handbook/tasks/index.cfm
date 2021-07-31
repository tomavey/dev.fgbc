<div class="span10 offset1">
<h1>Listing tasks</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="Create a new task", action="new")#</p>
</cfoutput>

<div class="table table-stripped">

<cfoutput query="handbooktasks">
<div class="well">
<h3>#title#</h3>
<p>#task#</p>
<p>Due: #dateFormat(dueAt)#, assigned to: #assignedto#<p>
<cfif len(status)>
<p>
Status: #status#
</p>
</cfif>
<p>Completed: #dateFormat(completedAt)#</p>
<p>Created: #dateformat(createdat)#; Updated: #dateformat(updatedat)#</p>
<p>#showtag()#&nbsp;#editTag()#&nbsp;#deleteTag()#</p>
</div>
</cfoutput>


</div>