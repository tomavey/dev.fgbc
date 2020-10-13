<cfoutput>

<div class="container">

		<h1>Send us a message!</h1>


					#errorMessagesFor("message")#
			
					#startFormTag(action="create", name="contactUs")#
				
						
								#textField(objectName='message', property='name', label='Name: ')#
							
								#textField(objectName='message', property='email', label='Email: ')#
							
								#textArea(objectName='message', property='message', label='', rows="10", cols="75")#
								
					<!--- #includePartial("/captcha")#	 --->

						#submitTag("Send Message")#

					<button class="g-recaptcha" 
						data-sitekey="6LeL3tYZAAAAAPHseKw3n5Hl_XtCtx-JPYqbaDj7" 
						data-callback='onSubmit' 
						data-action='submit'>Submit</button>
								
					<!--- #endFormTag()# --->
					
		<cfif gotRights("superadmin,office")>
			#linkTo(text="Return to the listing", action="index")#
		</cfif>
</div>
</cfoutput>

<script>
	function onSubmit(token) {
		document.getElementById("demo-form").submit();
	}
</script>

