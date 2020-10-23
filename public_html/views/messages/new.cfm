<script src="https://www.google.com/recaptcha/api.js"></script>
<script>
	function onSubmit(token) {
		alert("workd")
		document.getElementById("demo-form").submit();
	}
</script>

<script src="https://www.google.com/recaptcha/api.js?render=6LeL3tYZAAAAAPHseKw3n5Hl_XtCtx-JPYqbaDj7"></script>
<script>
    grecaptcha.ready(function() {
    // do request for recaptcha token
    // response is promise with passed token
        grecaptcha.execute('6LeL3tYZAAAAAPHseKw3n5Hl_XtCtx-JPYqbaDj7', {action:'validate_captcha'})
                  .then(function(token) {
						// add token value to form
						console.log("token")
						console.log(token)
            document.getElementById('g-recaptcha-response').value = token;
        });
    });
</script>


<cfparam name="headerMessage" default="Send us a message!">
<cfparam name="instructions" default="">
<cfparam name="formaction" default="create">

<cfif isDefined("params.headerMessage") >
	<cfset headerMessage = params.headerMessage>
</cfif>
<cfif isDefined("params.header")>
	<cfset headerMessage = params.header>
</cfif>
<cfif isdefined("params.help")>
	<cfset headerMessage = "Requesting Help">
	<cfset instructions = "Provide your name and email, church name and location and a brief description of the need. For Charis Fellowship churches only.">
</cfif>
<cfoutput>
<div class="container card card-charis text-center">

		<cfif isDefined("session.contactMessage")>
		#session.contactMessage#
		<cfset StructDelete(session,"contactMessage")>
		</cfif>

		<h1>#headerMessage#</h1>
		<p>#instructions#</p>


					#errorMessagesFor("message")#

					#startFormTag(action=formaction, id="contact-us")#

								#hiddenField(objectName='message', property='subject')#

								#textField(objectName='message', property='name', label='Name: ')#

								#textField(objectName='message', property='email', label='Email: ')#

								#textArea(objectName='message', property='message', label='', rows="10", cols="75")#

					#includePartial("/captcha")#
					<input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response">
					<input type="hidden" name="action" value="validate_captcha">
					
					#submitTag(value="Send Message", id="g-recaptcha-response")#


					<!--- #submitTag(
						value='Send Message', 
						data_sitekey='6LeL3tYZAAAAAPHseKw3n5Hl_XtCtx-JPYqbaDj7',  
						data_callback='onSubmit',  
						data_action='submit',
						onclick="return onSubmit()"
						)# 
 --->

					#endFormTag()#

					<form id="contact-us">
						<button class="g-recaptcha" 
						data-sitekey="6LeL3tYZAAAAAPHseKw3n5Hl_XtCtx-JPYqbaDj7" 
						data-callback='onSubmit' 
						data-action='submit'>.</button>

					</form>

		<cfif gotRights("superadmin,office")>
			#linkTo(text="Return to the listing", action="index")#
		</cfif>

</div>
</cfoutput>

