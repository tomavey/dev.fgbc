<cfif users.recordcount GT 1 >
	<h2 class="text-center">There are more than one usernames using your email address.  Please use the appropriate link to edit your information:</h2>
</cfif>

<cfloop query="usersTokens">
	
	<div class="postbox">
		<p class="text-center">
		<cfoutput>
			<cfif isDefined("token") and len(token)>
				Please use this link to enter a new password for #username#:<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;#linkto(controller="auth.users", action="changepassword", key=token, onlyPath=false)#
			<cfelse>
				We are unable to provide a change-password link for #username#. Us the "Contact Us" form on www.fgbc.org to request assistance.
			</cfif>
		</cfoutput>
		</p>
	</div>

</cfloop>