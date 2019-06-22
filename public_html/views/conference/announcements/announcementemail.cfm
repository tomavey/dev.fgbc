<cfoutput>
<table align="center" width="800px" style="background-color:white;padding:20px">
<tr>
<td>
<h3>Attention #getEventAsText()# folk...</h3>

<p>&nbsp;</p>
<p style="font-weight:bold">#announcement.subject#</p>
<p>&nbsp;</p>
<p>#paragraphFormat(announcement.content)#</p>
<cfif len(announcement.link)>
	<p>#announcement.link#</p>
</cfif>
<p>&nbsp;</p>
<cfif isDefined("announcement.invoiceLink") and announcement.invoiceLink>
    Use this link to see your registration information: #linkto(route="showInvoiceByEmail", params="email=#trim(i)#", onlypath=false)#
</cfif>
<!---
<p style="font-weight:bold">See more Margins2016 announcements at <a href="http://www.flinchmobile.com">flinchmobile.com</a><p>
--->
<p>&nbsp;</p>
<p style="font-size:.8em;color:grey"><span>Author</span>: #announcement.author#</p>
<p style="font-size:.8em;color:grey">You are receiving this email because you are registered for #getEventAsText()#</p>
</td>
</tr>
</table>
</cfoutput>