<cfparam name="showEmailWarning" default="false">
<cfparam name="count" default=0>

<cfoutput>
	

<div id="churchinfo">	
<p>
	#church.address1#<br/>
	<cfif len(church.address2)>
		#church.address2#<br/>
	</cfif>
	#church.org_city#, #church.handbookstate.state_mail_abbrev# #church.zip#<br/>
</p>
<p>	
	Delegates allowed: #church.delegatecount#
</p>

</div>
<div class-"well">
<p>Submitter: #delegates.submitter#</p>
<p>Submitter Email: #mailTo(delegates.submitteremail)#</p>
<!--- [#linkTo(text="Change submitter info", controller="membership.delegates", action="newsubmitter")#] --->
</div>
<p>&nbsp;</p>
<cfif flashKeyExists("success")>
	<p class="alert alert-success"><cfoutput>#flash("success")#</cfoutput></p>
</cfif>

<p>Your Delegates.......</p>
</cfoutput>

					<div class="row">
						
						<div class="span12">

							<cfoutput query="delegates">

									<div class="well span5">
										
										<p class="span2">#name#</p>
										<p class="span2">
											<cfif isValid("email",email)>
												#mailto(email)#
											<cfelseif !find("No delegates", name)>
												<cfset showEmailWarning = true>	
												*	(see note below)	
											</cfif>
										</p>
										<p class="span2">#deleteTag(class="noajax")# #editTag()#</p>

									</div>
									<cfset count = count + 1>
							</cfoutput>
						</div>
					
					</div>

<cfoutput>
	<cfif showEmailWarning>
		<p>
			* If you do not provide a valid email for this person he or she will not receive advance reports
		</p>
	</cfif>
	<p>
		Delegates in this report: #count#
	</p>

	[#linkTo(text="Add a new delegate", action="addnewdelegate", key=session.delegate.churchid)#]&nbsp;	
	[#linkTo(text="Delete all these delegates and start over", action="deleteAll", key=session.delegate.churchid)#]	
	<p>&nbsp;</p>
	<p>
	#linkTo(text="I am finished!", controller="membership.delegates", action="email", key=session.delegate.churchid, class="btn btn-primary btn-large")#	
	</p>
</cfoutput>

	

