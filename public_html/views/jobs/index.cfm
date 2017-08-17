<cfoutput>
<div class="row-fluid well contentStart contentBg">

    <div class="span3">
        #includePartial(partial="sidebar", selected="home")#
    </div>

<div class="span9">

<div id="instructions">
#getcontent("jobs").content#
</div>

<p>
#linkTo(text="Click HERE to submit a ministry opportunity for posting. All job postings are subject to approval.", controller="jobs", action="new", class="btn btn-primary")#
</p>
	<cfoutput query="job">
		
		<div class="well" >
		
		
							<h1>#job.title#</h1>
						
							<p>#job.description#</p>
		
							<p><span>Email: </span>#mailTo(emailAddress=job.contactemail, encode=true)#</p>
							
							<cfif job.phone is not "">
							<p><span>Phone: </span>#job.phone#</p>
							</cfif>
											
							<p><span>Job post will expire: </span>#dateformat(job.expirationdate)#</p>
						
		<cfif gotRights("superadmin,office")>
				#listTag()# | #editTag()#
		</cfif>
		#showTag()#
		</div>
		
	
	</cfoutput>

	<p>
		#linkto(text="rss", action="rss")#
	</p>

</div>
</div>
</cfoutput>


