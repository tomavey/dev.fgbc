<cfoutput query="registrations">
	<p>
	#fullname# - #combineEmail(ccemail,familyemail,email)# - #optionname# - #linkto(controller="register", action=request.action, params="peopleid=#personid#&invoiceid=#invoiceid#", onlyPath=false)# #dateformat(createdAt)#
	<cfif isdefined("params.sendemail") and params.sendemail>
		<cfset sendemail(from="tomavey@fgbc.org", to=combineEmail(ccemail,familyemail,email), bcc="tomavey@fgbc.org", template="emailwickham", subject="Claim your free ticket for Phil Wickham concert", layout="/layout_for_email")>
		 - SENT!
	</cfif>
	</p>
</cfoutput>
