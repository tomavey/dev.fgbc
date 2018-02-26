<div data-role="content">
<cfoutput>
					<p><span>Subject</span>: 
						#announcement.subject#</p>
				
					<p>#paragraphFormat(announcement.content)#</p>

Announcement was sent to: 
<cfloop list="#$regEmails()#" index="i">
	<cfif not listFind(emailnotList(),i)>
		#i#; 
	</cfif>
</cfloop>
</cfoutput>
</div>