<h1>Showing handbook subscription</h1>

<cfoutput>
<cfif len(handbooksubscribe.handbookemail)>
	<cfset handbooksubscribe.email = handbooksubscribe.handbookemail>
</cfif>
					<p><span>Email</span>: #handbooksubscribe.email#</p>
				
					<p><span>Type</span>: #handbooksubscribe.type#</p>
				
					<p><span>Handbook Id</span>: 
					<cfif val(handbooksubscribe.handbookid)>
					#linkTo(text=handbooksubscribe.handbookid, controller="handbook.people", action="show", key=handbooksubscribe.handbookid)#<cfelse>#linkTo(text="Not Linked", action="edit", key=handbooksubscribe.ID)#</cfif></p>

					<p><span>Created At</span> #dateformat(handbooksubscribe.createdAt)#</p>
				
#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this handbooksubscribe", action="edit", key=handbooksubscribe.ID)# | #linkTo(text="Resend", action="sendTodaysDates", params="sendto=#handbooksubscribe.email#")#
</cfoutput>
