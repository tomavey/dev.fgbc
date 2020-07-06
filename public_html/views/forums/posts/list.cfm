<div class="row">
	<div class="span4">
		<div class="posts">
			<p>
				<cfif posts.instructions is "">
					Click on each subject to add to the conversation (and vote!).!
				<cfelse>
					<cfoutput>#posts.instructions#</cfoutput>
				</cfif>
			</p>
			<ol>
			<cfoutput query="posts">
				<li>#linkTo(text=subject, action="show", key=id, class="ajaxclickable tooltip2", title="Click to see this post with comments.")# <span style="font-size:.7em;color:gray;float:right">(#getcounts(id,"show")#)</span></li>
			</cfoutput>
			</ol>
			<div id="files">
				Files:
				<cfoutput query="files">
					<p>#linkto(text=file, href="/files/#file#", class="ajaxfiledesc tooltip2", title="Click to download this document.")#<span class="description">#description#</span></p>
				</cfoutput>
				<cfoutput>
					#includePartial("../resources/upload")#
				</cfoutput>
	
			</div>
			<div id="subscribe">
				<cfoutput>
					#session.auth.email# <br/>
					<cfif user.subscribed>	
						#linkTo(text="Un-Subscribe me", class="tooltip2 btn", title="You will no longer receive comments by email.", action="subscribe", key=0, alt="Stop sending me those emails!")#
					<cfelse>
						#linkTo(text="Subscribe me", class="tooltip2 btn", title="Click here to receive new comments by email.", action="subscribe", key=1, alt="Send me email updates of posts")#
					</cfif>
				</cfoutput>
			</div>
		</div>
	</div>
	<div class="span8">
		<div id="thisAjaxInfo">
			<cfif len(posts.message)>
				<cfoutput>#posts.message#</cfoutput>
			<cfelse>	
				Move your cursor over items on the left to temporarily view the fuller statement then click to see that information, make comments, vote, or view comments of others.
			</cfif>	
			<!---this is where the popup information shows up when mousing over the person--->
		</div>
	</div>
</div>
<div class="row">
	<div class="span12" id="allposts">
	<h3><cfoutput>#allposts.recordcount#</cfoutput> comments so far!(most recent are first):</h3>
	<cfoutput>#linkto(text="Votes", controller="forumVotes", action="list")#</cfoutput>
	
	<cfoutput query="allposts">
	<div class="well">#linkto(text='#createdby# commented about "#subject#" on #dateformat(createdAt)#.', action="show", key=parentid, title="Click to see all comments about #subject#.", class="tooltip2")#
		<p>#displaypost(post)#...</p>
	</div>
	</cfoutput>
	</div>
</div>