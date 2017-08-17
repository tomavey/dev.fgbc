<div data-role="content">
<h1>Submit a New Announcement</h1>
<p>Announcements will be sent to the conference coordinator for approval before they are displayed.</p>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			#errorMessagesFor("announcement")#

			#startFormTag(action="create")#

			#includePartial("form")#

			#submitTag("Submit your announcement")#

			#endFormTag()#



#linkTo(text="Return to the listing", action="list")# |
#linkTo(text="HTML for Button", action="button", target="_new")#
<br/><br/>
<p> Email list: #regEmailLessNotList()#</p>
</cfoutput>
</div>
