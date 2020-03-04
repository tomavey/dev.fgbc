<cfoutput>

<cfif isBefore(#application.wheels.sendHandbookDeadline#)>
	A handbook will be sent to:<br/>

	#person.fname# #person.lname#<br/>
	#person.address1#<br/>
	<cfif len(person.address2)>
		#person.address2#<br/>
	</cfif>
	#person.city#, #person.state_mail_abbrev# #person.zip#<br/>
<br/>
	#linkto(text="Access the online handbook", controller="handbook.welcome", action="welcome", key=encrypt(person.email,getSetting("passwordkey"),"CFMX_COMPAT","HEX"), class="btn")#

<cfelse>
	The deadline for requesting your free Charis Fellowship handbook has passed.
</cfif>
</cfoutput>
