<h2>Enter this code into the web page to create a new user.</h2>

	
	<div class="postbox">
		<p>
		<cfoutput>
      <cfif isDefined("code") and len(code)>
        #code#
			<cfelse>
				We are unable to provide a code to create this user accuont. Us the "Contact Us" form on charisfellowship.us to request assistance.
			</cfif>
		</cfoutput>
		</p>
	</div>
