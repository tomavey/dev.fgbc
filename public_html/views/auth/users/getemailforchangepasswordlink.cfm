<div class="container card card-charis text-center">
<h1>Enter your email address:</h1>
<p>If the email address you enter here is found in our system, you will be sent a link to change your password.</p>
<cfoutput>

		    <cfif flashKeyExists("error")>
		        <p class="message">
		            #flash("error")#
		        </p>
		    </cfif>
		    
			#errorMessagesFor("user")#
	
			#startFormTag(action="emailChangePasswordLink")#

			#textField(objectName='user', property='email', label='Email Address: ')#
					
			#submitTag("Send me a link")#
				
			#endFormTag()#
			
</cfoutput>
</div>