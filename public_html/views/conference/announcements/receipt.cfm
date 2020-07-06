<cfoutput>
	<h3>Thank you for submitting this announcement.</h3>
	<p><span>Subject</span>: #announcement.subject#</p>
	<p>#announcement.content#</p>
	<p>To be posted #dateformat(announcement.postAt)#</p>
	<cfif len(announcement.link)>
		<p>#announcement.link#</p>
	</cfif>

<!---	#linkTo(text="Edit this announcement", action="edit", key=announcement.id, onlyPath="false")#
--->

</cfoutput>