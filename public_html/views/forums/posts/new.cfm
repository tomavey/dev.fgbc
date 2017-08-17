<h1>Create a new comment:</h1>
<cfif isdefined("params.replyto")>
<p>	
This is a reply to another comment so the following will happen:
<ul>
<li>
<cfoutput>#params.replyto#</cfoutput> will recieve this reply as an email message.
</li>
<li>
This message will be posted as a new comment on the forum.
</li>
</ul>


</p>	
</cfif>

<cfoutput>

			#errorMessagesFor("forumpost")#
	
			#startFormTag(action="create")#
			
			<cfif isdefined("params.replyto")>
			#hiddenFieldTag(name="replyto", value=params.replyto)#
			</cfif>
			
			#includePartial("form")#
		
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
