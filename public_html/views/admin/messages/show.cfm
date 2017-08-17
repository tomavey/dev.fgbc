<cfoutput>
<div class="row-fluid well contentStart contentBg">

<div class="span12">

<h1>Showing message</h1>


					<p><span>Name: </span>
						#message.name#</p>
				
					<p><span>Email: </span>
						#mailto(message.email)#</p>
				
					<cfif isDefined("message.subject") && len(message.subject)>
						<p><span>Subject: </span>
							#message.subject#</p>
					</cfif>	
				
					<p>
						#message.message#</p>
				
					<p><span>Created:</span>
						#dateformat(message.createdAt)#</p>
<cfif gotrights("superadmin,office")>
				
#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this message", action="edit", key=message.id)#

</cfif>

</div>
</div>

</cfoutput>
