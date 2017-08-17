<cfoutput>
			#hiddenFieldTag(name="captcha_check", value=encrypt(strCaptcha,application.wheels.passwordkey,'CFMX_COMPAT','HEX'))#

			<cfif flashKeyExists("error")>
				<p class="errorMessage">
					#flash("error")#
				</p>
			</cfif>	
			<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="medium" fonts="verdana,arial,times new roman,courier" fontsize="28" /><br />
                 Enter text from this image.&nbsp;
            #textFieldTag(name="captcha", value="", id="captcha")#<br/><br/>

</cfoutput>