<h1>Votes for <cfoutput>#forumvote.subject#...</cfoutput></h1>

<cfif forumvote.recordcount>

<cfoutput query="forumvote" group="forumVoteTypeId">
<p>
<cfset count=0>
	#vote# - 
	<cfoutput>
	<cfset count = count + 1>
	</cfoutput>
	#count#
</p>	
</cfoutput>
<cfelse>
No votes yet!
</cfif>
<cfoutput>#linkTo(text="Back", controller="forums.posts", action="show", key=params.key, class="btn")#
</cfoutput>
