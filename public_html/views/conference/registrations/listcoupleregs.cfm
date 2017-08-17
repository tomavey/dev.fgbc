<cfoutput query="registrations">
	<p>
	#fullname# - #combineEmail(ccemail,familyemail,email)# - #optionname# - #linkto(controller="register", action="addCoupleConcertTicket", params="peopleid=#personid#&invoiceid=#invoiceid#", onlyPath=false)#
	</p>
</cfoutput>
