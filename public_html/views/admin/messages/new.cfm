<cfoutput>

<div class="container">

		<h1>Send us a message!</h1>


					#errorMessagesFor("message")#
			
					#startFormTag(action="create")#
				
						
								#textField(objectName='message', property='name', label='Name: ')#
							
								#textField(objectName='message', property='email', label='Email: ')#
							
								#textArea(objectName='message', property='message', label='', rows="10", cols="75")#
								
					#includePartial("/captcha")#	

						#submitTag("Send Message")#
						
					#endFormTag()#
					
		<cfif gotRights("superadmin,office")>
			#linkTo(text="Return to the listing", action="index")#
		</cfif>
</div>
</cfoutput>
