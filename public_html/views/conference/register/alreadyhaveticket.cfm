<cfoutput>
<h1>Your invoice already has a free ticket (single or couple) for the Phil Wickham concert.</h1>
<p>Use this link to see your invoice with this free ticket: #linkTo(controller="invoices", action="show", key=params.invoiceid, onlyPath=false)#</p>
<p>Questions? #mailto("sandy@fgbc.org")#</p>
</cfoutput>