<h1>My Notes: </h1>

<cfoutput query="handbookNotes">
<div class="eachNote well">
	<p>#thisentity#</p>
	<p>#note#</p>
	<p>
		Created: #dateformat(createdAt)#<br/>
		Updated: #dateformat(updatedAt)#
	</p>
#editTag()#
</div>
</cfoutput>
