<cfoutput>
	<div class="container">



	<cfoutput query="job">
		
		<div class="well" >
		
		
							<h1>#job.title#</h1>
						
							<p>#job.description#</p>
		
							<p><label>Email: </label>#mailTo(emailAddress=job.contactemail, encode=true)#</p>
							
							<cfif job.phone is not "">
							<p><label>Phone: </label>#job.phone#</p>
							</cfif>
											
							<p><label>Expiration date: </label>#dateformat(job.expirationdate)#</p>
						
		<cfif gotRights("superadmin,office")>
				#listTag()# | #editTag()#<br/>
				#linkto(text="Public Edit Link", controller="jobs", action="edit", params="id='#uuid#'")#
		</cfif>
		</div>
		
	
	</cfoutput>

	<p>
		#linkto(text="rss", action="rss")#
	</p>

</div>
</cfoutput>


