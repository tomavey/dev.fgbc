<div id="welcome"  class="container">
<cfoutput>

	<cfif isbefore(regOpenPromiseDate()) AND !regIsOpen()>
			<h1>Welcome to the  Registration Center.</h1>
			<p>
				The online registration will open on #dateFormat(regOpenPromiseDate(),"mmmm dd, yyyy")#. Check back then to register!
			</p>

			#includePartial(partial="registrationcosts")#

	<cfelseif getSetting("regTemporarilyClosed") && !gotRights("office")>		
			<h1>Welcome to the #getEventAsText()# Registration Center</h1>
			<p style="text-align:center">
				The registration center is closed for maintenance. But we promise it will not take long! Check back tomorrow. 
			</p>
	<cfelseif regIsOpen()>
			<h1>Welcome to the #getEventAsText()# Registration Center</h1>
			<p style="text-align:center">
				Your registration covers all plenary sessions, cohorts, workshops, exhibits, access to discounted meals, and access to Grace Kids. 
			</p>
			<cfif myRegsIsOpen()>
				<p style="text-align:center">
					#linkto(text="My Regs", route="conferencemyreg", class="btn")#
				</p>	
			</cfif>

			<cfif preRegIsOpen() && !regIsOpen()>
				#linkTo(text="Pre Register Now", action="selectoptions", params="single=", class="btn btn-large btn-block btn-info")#
			<cfelse>
				#linkTo(text="Register Now", action="selectregtype", class="btn btn-large btn-block btn-info")#
			</cfif>


			#includePartial(partial="registrationcosts")#

		<br/>
		<p>
			Special note: Our secure online payment center only accepts<br/> Visa, Discover and Master Card.
		</p>

		<p>&nbsp;</p>

			<cfif preRegIsOpen() && !regIsOpen()>

				#linkTo(text="Pre Register Now", action="selectoptions", params="single=", class="btn btn-large btn-block btn-info")#
			<cfelse>
				#linkTo(text="Register Now", action="selectregtype", class="btn btn-large btn-block btn-info")#
			</cfif>

	<cfelseif preRegIsOpen() && !regIsOpen()>
			<h1>... however, you can still purchase discounted registrations for #getEvent()# here...</h1>
			<p>&nbsp;</p>

				#linkTo(text="Pre Register for #getSetting("eventAsText")# Now", action="selectoptions", params="options=1&openreg=1", class="btn btn-large btn-block btn-info")#
	<cfelseif optionsregistrationIsOpen()>
				You Can still purchase tickets for options here.
	<cfelse>
			<p>#getSetting("eventAsText")# is just a few days away! We are preparing registration envelopes for #getSetting("eventAsText")# participants.  If you still need to register or purchase meal tickets, go directly to the Welcome Center when you arrive to register and purchase meal ticket if they are still available.</p>
	</cfif>

</cfoutput>
</div>