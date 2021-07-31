<cfoutput>				

	<div class="card card-text container">#getcontent("jobsform").content#</div>

#ckeditor()#	
						#textField(objectName='job', property='email', label='Your Email Address: ')#
					
						#textField(objectName='job', property='title', label='Title of the position you are advertising: ')#
					
						#textArea(objectName='job', property='description', rows="10", cols="70", class="ckeditor", label='Use the "Paste From Word" icon to paste from MSWord.')#
					
					<cfif gotRights("superadmin,office")>
					
						#select(objectName='job', property='approved', label='Approved: ', options="Y,N")#

					</cfif>	
					
						#textField(objectName='job', property='phone', label='Phone number to show on this ad: ')#
					
						#textField(objectName='job', property='contactemail', label='Email Address to show on the ad: ')#

						#hiddenFieldTag(name="captcha_check", value=encrypt(strCaptcha,application.wheels.passwordkey,'CFMX_COMPAT','HEX'))#
					
					<cfif gotRights("superadmin,office") || isDefined('params.id')>
						<p>

							Expiration Date: #dateSelect(objectName='job', property='expirationdate', dateOrder='year,month,day', monthDisplay='abbreviations', label="")#
							<span style="font-size:.8em; color: grey">[change the expiration date to yesterday's date to make this post inactive]</span>
							
						</p>
					<cfelse>
						#hiddenFieldTag(name='job[expirationdate]', value=now()+90)#	
					</cfif>	

</cfoutput>