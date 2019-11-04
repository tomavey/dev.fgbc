<h2 class="text-center">Enter this code into the web page to create a new user.</h2>
	
	<div class="postbox">
		<p>
		<cfoutput>
      <cfif isDefined("code") and len(code)>
        <h1 class="text-center">#code#</h1>
			<cfelse>
				We are unable to provide a code to create this user account. Us the "Contact Us" form on charisfellowship.us to request assistance.
			</cfif>
		</cfoutput>
		</p>
	</div>
