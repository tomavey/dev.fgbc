<cfoutput>

<div class="row-fluid well contentStart contentBg">
	<div class="span3">
		#includePartial(partial="sidebar", selected="home")#
	</div>

	<div class="span9">

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
</div>
</cfoutput>
