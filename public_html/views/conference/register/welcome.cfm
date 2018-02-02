<div id="welcome"  class="container">
	<cfif isbefore("02/17/2017") AND !regIsOpen()>
			<h1>Welcome to the  Registration Center.</h1>
			<p>The online registration will open on Wednesday, February 1 2017. Check back then to register!</p>
			<cfoutput>
				#includePartial("registrationcosts")#
			</cfoutput>

	<cfelseif regIsOpen()>
			<cfoutput>
			<h1>Welcome to the #getEventAsText()# Registration Center</h1>
			<p style="text-align:center">Your registration covers all plenary sessions, collaboration groups, access to discounted meals, excrusion events, discounted room rate and access to Grace Kids. <!---Check out the <a href="#getConfUrl()###venue" target="_blank">location page for lodging options</a>.---></p>
			<p style="text-align:center">
			#linkto(text="My Regs", route="conferencemyreg", class="btn")#
			</p>	
			<cfif preRegIsOpen() && !regIsOpen()>

				#linkTo(text="Pre Register Now", action="selectoptions", params="single=", class="btn btn-large btn-block btn-info")#
			<cfelse>
				#linkTo(text="Register Now", action="selectregtype", class="btn btn-large btn-block btn-info")#
			</cfif>


				#includePartial("registrationcosts")#
<!---
				#linkto(text="View instructions", id="showreginstructions")#
				#linkto(text="Hide instructions", id="hidereginstructions")#
--->
			</cfoutput>




		<br/>
		<p>Special note: Our secure online payment center only accepts<br/> Visa, Discover and Master Card.</p>

		<cfoutput>
			<p>&nbsp;</p>

			<cfif preRegIsOpen() && !regIsOpen()>

				#linkTo(text="Pre Register Now", action="selectoptions", params="single=", class="btn btn-large btn-block btn-info")#
			<cfelse>
				#linkTo(text="Register Now", action="selectregtype", class="btn btn-large btn-block btn-info")#
			</cfif>
		</cfoutput>
		</p>

	<cfelseif preRegIsOpen() && !regIsOpen()>
			<h1>... however, you can still purchase discounted registrations for Access2017 here...</h1>
		<cfoutput>
			<p>&nbsp;</p>

				#linkTo(text="Pre Register for Access2017 Now", action="selectoptions", params="options=1&openreg=1", class="btn btn-large btn-block btn-info")#
		</cfoutput>
	<cfelse>

		<p>We are preparing registration envelopes for margins2016.  If you still need to register or purchase meal tickets, go directly to the Welcome Center (Lower Concourse) when you arrive to register and purchase meal ticket if they are still available.</p>

<!---
			<p id="churchpack"><a href="http://margins2016.eventbrite.com/"class="btn" target="_blank">If your church would like to purchase a pack of registrations in advance, click HERE</a>.</p>
			<cfoutput>
				#includePartial("registrationcosts")#
			</cfoutput>
--->

	</cfif>

</div>