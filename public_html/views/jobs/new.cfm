<cfparam name="formaction" default="create">
<cfoutput>
	<div class="container card card-charis">
			#errorMessagesFor("job")#
			<cfif flashKeyExists("error")>
				<p class="errorMessage">
					#flash("error")#
				</p>
			</cfif>	

			#startFormTag(action=formaction)#
			
			#includePartial(partial="form")#

			<cfif flashKeyExists("error")>
				<p class="errorMessage">
					#flash("error")#
				</p>
			</cfif>	

			<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="medium" fonts="verdana,arial,times new roman,courier" fontsize="28" /><br />
                Enter text from this image.&nbsp;
                #textFieldTag(name="captcha", value="", id="captcha")#<br/><br/>

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#

	</div>
</cfoutput>