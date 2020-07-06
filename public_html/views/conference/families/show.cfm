<div class="eachItemShown show">
<cfoutput query="family" group="id">
					<p><span>Last Name: </span>
						#lname#</p>
				
					<p><span>Address: </span> 
						#address#</p>
				
					<p><span>City: </span> 
						#city#</p>
				
					<p><span>State: </span> 
						#state_mail_abbrev#</p>
				
					<p><span>Zip: </span> 
						#zip#</p>
				
					<p><span>Email: </span> 
						#email#</p>
				
					<p><span>Phone: </span> 
						#phone#</p>
				
					<p><span>Comment: </span> 
						#comment#</p>
				
					<p><span>Created: </span>
						#dateformat(createdat, "medium")#</p>
				
					<p><span>Updated: </span>
						#dateformat(updatedat, "medium")#</p>
				
	<div>
		<p>People in this family:
		<cfoutput>
			#linkTo(text='#fname#', controller="conference.people", action="show", key="#conferencepersonid#")#; 
		</cfoutput>
		</p>
	</div>
<cfif gotRights("office")>
	#linkToList(text="Return to the listing", action="index")# | 
	#linkTo(text="Edit this family", action="edit", key=ID)# | 
	#linkTo(text="Add a person to this family", action="new", controller="conference.people", params="familyid=#id#")# | 
</cfif>
</cfoutput>
</div>