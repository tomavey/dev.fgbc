<cfset prevsubject = "">
<cfif forumvotes.recordcount>

<cfoutput query="forumvotes" group="forumVoteTypeId">
<cfif prevsubject NEQ subject>
<hr/>
		<h2>#linkTo(text=subject, controller="forum-posts", action="show", key=postid)#</h2>
</cfif>
<p style="margin-left:60px;width=100px">
<cfset count=0>
	#vote# - 
	<cfoutput>
	<cfset count = count + 1>
	</cfoutput>
	#count#
</p>
<cfset prevsubject = subject>	
</cfoutput>
<cfelse>
No votes yet!
</cfif>

