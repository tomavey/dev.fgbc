<div class="postbox" id="<cfoutput>#params.controller#.#params.action#</cfoutput>">

<cfoutput>

	<p>
		<h1>#church.name#</h1><br/>
		#church.address1#<br/>
		<cfif len(church.address2)>
		#church.address2#<br/>
		#church.org_city#, #church.Handbookstate.state_mail_abbrev# #church.zip# #church.country#
		</cfif>
		#church.org_city#, #church.Handbookstate.state_mail_abbrev# #church.zip# #church.country#
	</p>
	
	<p>
		Listed City: #church.listed_as_city#
	</p>
	<p>
		<cfif len(church.phone)>
			#church.phone#<br/>
		</cfif>
		<cfif len(church.email)>
			#mailto(church.email)#<br/>
		</cfif>
		<cfif len(church.fax)>
			Fax: #church.fax#<br/>
		</cfif>
		<cfif len(church.website)>	
			#linkTo(href=church.website)#
		</cfif>		
	</p>
	<p>
		#church.meetingplace#
	</p>
	<p>
		#church.statusid#
	</p>
				
<cfif gotrights("superadmin,office")>
#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this church", action="edit", key=church.id)#
</cfif>
</cfoutput>
</div>
