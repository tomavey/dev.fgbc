<cfoutput>

	<div id="#params.controller##params.action#" class="row">	
	
		#flash("success")#
		
		<div id="navlinks">
		#linkto(text="Back to list", action="list", class="tooltip", title="Go back to #forumPost.forumForum.forum#.")#<br/>
		<cfif navlinks.previous>
			#linkTo(text="&lt; Previous", action="show", key=navlinks.previous, class="previous btn")#
		</cfif>	
		<cfif navlinks.next>
			#linkTo(text="Next &gt;", action="show", key=navlinks.next, class="next btn")#
		</cfif>	
		</div>

		<div id="post" class="offset0">
			<p id="subject">
				#forumpost.subject#
			</p>
			<p id="createdby">
				Posted by #mailto(forumpost.createdby)# on #dateformat(forumpost.createdat)#...
			</p>
			
			<div class="well">
				#forumpost.post#
			</div>
			#linkTo(class="tooltip2", text="Add your comment", title="Tell us what you think about this idea.", action="new", params="parentId=#params.key#&forumId=#forumPost.forumId#", class="btn forumcommentbutton")#
	
			<div id="votes" class="offset0">
			<p>#getcounts()#</p>
			<p class="flash votefeedback">#flash("vote")#</p>
			<p>
				<cfif isdefined("session.auth.forumid") AND session.auth.forumid is 5>

				<p class="votebutton">
					#linkTo(Text=imageTag('thumbsup-icon.png'), 
							class="tooltipbelow", 
							title="I Like This", 
							controller="forums.votes", 
							action="create", 
							params="postId=#params.key#&
									votetypeId=7&
									createdBy=#session.auth.email#&
									paction=#params.action#&
									pcont=#params.controller#
									"
							)#

					#linkTo(Text=imageTag('hangloose-icon.png'), 
							class="tooltipbelow", 
							title="I have no opinion about this.", 
							controller="forums.votes", 
							action="create", 
							params="postId=#params.key#&
									votetypeId=10&createdBy=#session.auth.email#&
									paction=#params.action#&
									pcont=#params.controller#
									"
							)#

					#linkTo(Text=imageTag('thumbsdown-icon.png'), 
							class="tooltipbelow", 
							title="I don't like This", 
							controller="forums.votes", 
							action="create", 
							params="postId=#params.key#&
									votetypeId=9&
									createdBy=#session.auth.email#&
									paction=#params.action#&
									pcont=#params.controller#
									"
							)#
				</p>
				
				<cfelse>
					Vote Here: 
					<cfloop query="voteTypes">
						#linkTo(Text=vote, class="tooltip2", title=description, controller="forums.votes", action="create", params="postId=#params.key#&votetypeId=#id#&createdBy=#session.auth.email#", title=description)#
						|		
					</cfloop>
				
				</cfif>
			</p>
			<p>
				#linkTo(Text="Show Votes", class="tooltip2", title="After you vote, see the totals so far... no peaking!", controller="forums.votes", action="show", key=params.key)#		
			</p>	
			</div>
			<cfif gotrights("superadmin")>
					<p id="editlink">
					#linkTo(text="Edit", action="edit", key=forumpost.id)# | 
					#linkTo(text="Delete", action="delete", key=forumpost.id, onclick="return confirm('Are you sure you want to delete this comment?')")#
					</p>
			</cfif>

		</div>
		
		<div>
		<h3>Comments for "#forumpost.subject#":</h3>	
			<cfif comments.recordcount>
				<cfloop query="comments">
					<div class="well">
					#post#
					#buttonTo(text="Reply", class="tooltip2", title="Use this button to leave your comment and send that comment as a reply to #createdby#.", action="new", params="parentId=#params.key#&forumId=#forumPost.forumId#&replyto=#createdBy#")#
					<p class="commentposted">Posted #mailto(createdBy)# on #dateformat(createdAt)#</p>
<!---					
				<p class="votebuttoncomment">
					#linkTo(Text=imageTag('thumbsupsmall-icon.png'), 
							class="tooltipbelow", 
							title="I Like This", 
							controller="forums.votes", 
							action="create", 
							params="postId=#id#&
									votetypeId=7&
									createdBy=#session.auth.email#&
									paction=#params.action#&
									pcont=#params.controller#
									"
							)#

					#linkTo(Text=imageTag('hangloosesmall-icon.png'), 
							class="tooltipbelow", 
							title="I have no opinion about this.", 
							controller="forums.votes", 
							action="create", 
							params="postId=#id#&
									votetypeId=10&createdBy=#session.auth.email#&
									paction=#params.action#&
									pcont=#params.controller#
									"
							)#

					#linkTo(Text=imageTag('thumbsdownsmall-icon.png'), 
							class="tooltipbelow", 
							title="I don't like This", 
							controller="forums.votes", 
							action="create", 
							params="postId=#id#&
									votetypeId=9&
									createdBy=#session.auth.email#&
									paction=#params.action#&
									pcont=#params.controller#
									"
							)#
					<br/>		
					#linkTo(text=getCounts(key=id, show="votes"), controller="forum-votes", action="show", key=id)#	(for this comment)	
					<br/>		
					#flash("vote")#
				</p>
--->				
					<cfif createdby is session.auth.email OR gotrights("superadmin")>
					<p id="editlink">
					#linkTo(text="Edit", action="edit", key=id)# | 
					#linkTo(text="Delete", action="delete", key=id, onclick="return confirm('Are you sure you want to delete this comment?')")#
					</p>
					</cfif>
					</div>
				</cfloop>	
			<cfelse>
				No comments yet!
			</cfif>
		</div>
		
	</div>
</cfoutput>
