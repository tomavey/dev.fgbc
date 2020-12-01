<div class="postbox" id="#params.controller##params.action#">
<h1>Create a new FGBC user account: </h1>

<cfoutput>

			#errorMessagesFor("user")#
	
			#startFormTag(action="create")#
		
			#includePartial(partial="form")#	
			
			#includePartial(partial="/captcha")#	

			#submitTag("Create Your New Account")#
				
			#endFormTag()#
			
<cfif gotRights("superadmin")>
	#linkTo(text="Return to the listing", action="index")#
</cfif>
</cfoutput>
</div>
