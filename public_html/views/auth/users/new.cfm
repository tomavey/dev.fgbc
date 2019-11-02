<cfparam name="formAction" default="create">

<div class="container">

<cfif getSetting("userAccountCreationAllowed")>
	<h1>Create a new Charis user account: </h1>

	<cfoutput>

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
