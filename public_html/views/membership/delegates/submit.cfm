<cfoutput>

<cfif not church.delegatecount>
	<div class="alert alert-error">
	<p>Your church has not yet turned in it's statistical report for 2013 and fellowship fee for 2014.  Please use this link to complete this step and then you can submit delegates.
	</p>
	<cfoutput>#linkTo(text="Go to Stat Form", route="sendstats", key=params.key, class="btn btn-primary")#</cfoutput>
	</div>

<cfelse>

	<cfif flashKeyExists("success")>
	<p class="alert alert-error"><cfoutput>#flash("success")#</cfoutput></p>
	</cfif>

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

				#errorMessagesFor("fgbcdelegate")#

				#startFormTag(action="create")#

							#hiddenField(ObjectName='fgbcdelegate', property='churchid')#
							#hiddenFieldTag(Name='key', value=session.delegate.churchid)#
							#hiddenFieldTag(Name='delegatecount', value=church.delegatecount)#
							#hiddenField(objectName='fgbcdelegate', property='status')#
							#hiddenField(objectName='fgbcdelegate', property='year')#

							#textField(objectName='fgbcdelegate', property='submitter', label='Your name(person submitting this form)')#

							#textField(objectName='fgbcdelegate', property='submitteremail', label='Your Email address (required!)')#

							#checkBoxTag(name="noDelegates", label="We will NOT send delegates this year...", class="tooltipside nodelegate", title="Check this box if your church will NOT be submitting delegates this year, then click the submit button at the bottom of this page.")#


						<div class="row">

								<cfloop from="1" to="#church.delegatecount#" index="i">

										#includePartial("delegate")#

								</cfloop>

						</div>

					#submitTag("Submit")#

				#endFormTag()#

</cfif>

</cfoutput>
