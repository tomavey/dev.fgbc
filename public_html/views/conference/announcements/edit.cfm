<div data-role="content">
<h1>Editing announcement:</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

<cfif announcement.approved is "yes">
	This announcement has been approved.
<cfelse>
	Approval pending.
</cfif>

			#errorMessagesFor("announcement")#

			#startFormTag(action="update", key=params.key)#

			#includePartial("form")#

			#submitTag()#

			#endFormTag()#



#linkTo(text="Return to the listing", action="list")# |
#linkTo(text="HTML for Button", action="button", target="_new")#
</cfoutput>
</div>