<cfoutput>
<div id="#params.controller##params.action#">	
<h1>An invoice has been started...</h1>	
	#linkTo(controller="focus.invoices", action="show", key=params.key, onlyPath=false)#
</div>	
</cfoutput>