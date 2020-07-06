<h1>All Votes</h1>
<cfoutput query="forumvotes" group="postid">
	<div>
			#subject#
		<ul>
		<cfoutput group="votetypeid">
			<cfset count = 0>
			<cfoutput>
				<cfset count = count +1 >
			</cfoutput>
				#vote# #count#</br>
		</cfoutput>
		</ul>
	</div>
</cfoutput>

