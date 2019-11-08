<cfparam name="formAction" default="create">
<cfparam name="user" required="true" type="struct">

<div class="container card card-charis text-center">

	<cfif getSetting("AllowUserAccountCreation")>

		<h1>Create a new Charis user account: </h1>


		<cfoutput>

			<cfif flashKeyExists("usedEmail")>
				<p class="errorMessage">
						#flash("usedEmail")#
				</p>
			</cfif>
	
			<cfif flashKeyExists("usedUsername")>
				<p class="errorMessage">
						#flash("usedUsername")#
				</p>
			</cfif>

			#errorMessagesFor("user")#

			#startFormTag(action=formAction)#

			#includePartial("form")#	
			
			<cfif !bypassCaptcha>
				#includePartial("/captcha")#	
			</cfif>

			#submitTag("Create Your New Account")#
				
			#endFormTag()#
					
			<cfif gotRights("superadmin")>
				#linkTo(text="Return to the listing", action="index")#
			</cfif>

		</cfoutput>
	<cfelse>
		<h1>New user account creation is temporarily closed! </h1>
	</cfif>	

</div>
