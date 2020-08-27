<cfoutput>
<p>	
	#flash("login")#			
</p>

	#startFormTag(action=formaction)#

	<cfif isdefined("session.auth.email")>		
		#textFieldTag(label="Your Email Address:", name="email", value=session.auth.email)#
	<cfelse>				
		#textFieldTag(label="Your Email Address:", name="email")#				
	</cfif>

	<cfif isdefined("params.groupcode")>
		#textFieldTag(label="Group Code:", name="groupcode", value=params.groupcode)#				
	<cfelse>
		#textFieldTag(label="Group Code:", name="groupcode")#				
	</cfif>

	#submitTag("Log into the forum")#
				
	#endFormTag()#
	
</cfoutput>