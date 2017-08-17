<cfoutput>
	<div class="row-fluid well contentStart contentBg">

<div class="span12">


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
				#listTag()# | #editTag()#
		</cfif>
		</div>
		
	
	</cfoutput>

	<p>
		#linkto(text="rss", action="rss")#
	</p>

</div>
</div>
</cfoutput>


