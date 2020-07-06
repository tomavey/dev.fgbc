<div>
<cfoutput>
The following invoice has been entered into the registration system.  Watch for payment!
<a href="http://#cgi.HTTP_HOST#/index.cfm?controller=conference.invoices&action=show&key=#thisinvoiceid#">http://#cgi.HTTP_HOST#/index.cfm?controller=conference.invoices&action=show&key=#thisinvoiceid#</a>
<p>&nbsp;</p>
<p>Sent to #getRegistrar()#</p>
</cfoutput>
</div>