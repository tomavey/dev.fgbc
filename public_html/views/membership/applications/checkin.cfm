<cfoutput>
#editbutton('checkinheader')#
<h1>#striptags(getQuestion("checkinheader"))#</h1>

#includePartial("reload")#

<div class="well">

#editbutton('steps')#
#getQuestion("steps")#

</div>

	#includePartial("showFlash")#
</cfoutput>

<cfoutput>

			<cftry>
				#errorMessagesFor("membershipapplication")#
				<cfcatch></cfcatch>
			</cftry>
	
			#startFormTag(action="create")#
		
			#includePartial("form0")#

		<fieldset>

			<div class="offset1">

			#hiddenField(objectName="membershipapplication", property="captcha_check")#	

			<cfimage action="captcha" height="75" width="363" text="#membershipapplication.strCaptcha#" difficulty="medium" fonts="verdana,arial,times new roman,courier" fontsize="28" /><a href="##" onclick="alert('Automatic web crawlers are accessing these forms without our permission and causing errors for legitimate users and extra work for the FGBC office. By asking for the text from this image we can stop 95% of these troublesome queries.'); return false"><span style="font-size:.8em">Why?</span></a>


			#editbutton('captcha')#
			#textField(objectName="membershipapplication", label=getQuestion("captcha"), property="captcha", id="captcha")#

			#editbutton('submitcheckin')#
			#submitTag(trim(stripTags(getQuestion("submitcheckin"))))#

			</div>

		</fieldset>	

		    #endFormTag()#


</cfoutput>
