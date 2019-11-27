<div class="postbox span12 container">
<cfoutput>	

	<cfif params.controller is "handbookwelcome">
	<p class="well">
	If you have a user account on www.fgbc.org and the email address on that account matches your email address in this online handbook, you can use this login form to access the online handbook.
	</p>
	</cfif>
			<h2>
				#flash("success")#	
			</h2>

			#startFormTag(controller="auth.users", action="checkLogin", class="text-center")#
		
				
						<p>
							#textField(objectName='user', property='username', label='Username: ')#
						</p>
					
						<p>
							#passwordField(objectName='user', property='password', label='Password: ')#
						</p>
						<p>
							#submitTag("Submit")#
						</p>
				
			#endFormTag()#

		<p class="text-center">
			#linkto(text="Forgot your password or username?", controller="auth.users", action="getEmailForChangePasswordLink")#
		</p>	
</cfoutput>
</div>
