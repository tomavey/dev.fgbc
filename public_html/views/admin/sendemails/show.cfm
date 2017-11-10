<cfoutput>
<div class="container">
	<h1>#sendemails.subject#</h1>

	#includePartial("showFlash")#

			<div class='well'>#sendemails.message#</div>

			<p><span>From email: </span>#sendemails.fromemail#</p>

			<p><span>From name:</span>
				#sendemails.fromname#</p>

			<p><span>Tags: </span>
				#sendemails.tags# - set by #sendemails.tagsusername#</p>

			<p><span>Sent To:</span>
				#sendemails.sentTo#</p>

			<p><span>Comment: </span>
				#sendemails.comment#</p>

			<cfif sendemails.sendplaintext is "Yes">
				<p><span>Will be sent as plain text.</span></p>
			<cfelse>
				<p ><span>Background Color: </span>
					###sendemails.backgroundcolor#&nbsp;&nbsp;<span style="background-color:###sendemails.backgroundcolor#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
			</cfif>

			<p><span>Sent:</span>
				#dateformat(sendemails.sentAt)#</p>

			<p><span>Created: </span>
				#dateformat(sendemails.createdAt)#</p>

			<p><span>Updated: </span>
				#dateformat(sendemails.updatedAt)#</p>

	#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this send-email", action="edit", key=sendemails.id)#

</div>
</cfoutput>
