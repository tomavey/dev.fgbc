<cfparam name="headerMessage" default="Send us a message!">
<cfparam name="instructions" default="">
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

					#startFormTag(action="create")#

								#hiddenField(objectName='message', property='subject')#

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
