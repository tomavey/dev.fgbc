<div class="postbox" id=#params.controller#.#params.action#>
<h1>Editing user</h1>

<cfoutput>

			#errorMessagesFor("user")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#		
		
			#includePartial(partial="form")#				
					
			#submitTag()#
				
			#endFormTag()#
			
<cfif gotRights("superadmin")>
	#linkTo(text="Return to the listing", action="index")#
<cfelse>
	#linkTo(text="Change Password", controller="auth.users", action="get-email-for-change-password-link")#
</cfif>
</cfoutput>
</div>