<div id="exhibitorthankyou" class="container">
<cfoutput>
<h1>Thank you for requesting exhibit space at the #getEventASText()#. <br/>We will contact you soon!</h1>
<div class="well">
					<p><span>Organization:</span>
						#exhibit.organization#</p>

					<p><span>Address:</span>
						#exhibit.address#</p>

					<p><span>Phone:</span>
						#exhibit.phone#</p>

					<p><span>Email:</span>
						#exhibit.email#</p>

				<cfif len(exhibit.fax)>
					<p><span>Fax:</span>
						#exhibit.fax#</p>
				</cfif>

					<p><span>Contact Person:</span>
						#exhibit.person#</p>

					<p><span>Number of tables:</span>
						#exhibit.numbertables#</p>

					<p><span>Number of spaces:</span>
						#exhibit.numberspaces#</p>

					<p><span>Electricity?:</span>
						<cfif exhibit.elect>
						Yes
						<cfelse>
						No
						</cfif></p>

				<cfif len(exhibit.specialrequest)>
					<p><span>Special Request:</span>
						#exhibit.specialrequest#</p>
				</cfif>

					<p><span>Date of Request:</span>
						#dateformat(exhibit.createdAt)#</p>

</div>
</cfoutput>
</div>