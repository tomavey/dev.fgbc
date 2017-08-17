<cfoutput>
<p>The following message was left on www.fgbc.org:</p>
<p>#message.message#</p>
<p>From: <cftry>#message.name# @ <cfcatch></cfcatch></cftry>#mailTo(message.email)#</p>
<p>#linkTo(href="www.fgbc.org/messages/show/#message.id#")#</p>
</cfoutput>