<cfparam name="formAction" default="create">

<div class="container">
	<h1>New user account creation is temporarily closed! </h1>
	<!--- 	
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
 --->
</div>
