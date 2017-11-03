<div class="container card card-charis text-center">
<h1>Create a new Charis user account: </h1>

<cfoutput>

			#errorMessagesFor("user")#
	
			#startFormTag(action="create")#
		
			#includePartial("form")#	
			
			#includePartial("/captcha")#	

			#submitTag("Create Your New Account")#
				
			#endFormTag()#
			
<cfif gotRights("superadmin")>
	#linkTo(text="Return to the listing", action="index")#
</cfif>
</cfoutput>
</div>
