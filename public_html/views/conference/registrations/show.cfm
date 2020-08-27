<div class="eachItemShown show">

<cfoutput query="registration">

					<p><span>Id: </span>
						#id#</p>

					<p><span>Person: </span>
						#linkTo(text='#fname# #lname#', controller='conference.people', action='show', key=conferencepersonID)#</p>

					<p><span>Option:</span>
							#linkTo(text='#name#', controller='conference.options', action='show', key=conferenceoptionID)#</p>
					<p><span>Invoice: </span>
						#linkTo(text='#ccorderid#', controller='conference.invoices', action='show', key=conferenceinvoiceID)#</p>

					<p><span>Quantity: </span>
						#quantity#</p>

					<p><span>Cost: </span>
						#cost#</p>

					<p><span>Created: </span>
						#dateformat(createdat, "medium")#</p>

					<p><span>Updated: </span>
						#dateformat(updatedat, "medium")#</p>

#linkToList(text="Return to the list", action="index")# | #linkTo(text="Edit this registration", action="edit", key=registration.id)#
</cfoutput>
</div>