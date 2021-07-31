<cfoutput>
<p><center>	
Please use this link to access the FGBC online handbook: 
	
#linkTo(controller="handbook.welcome", action="welcome", onlyPath=false, params="id=#params.key#")#
</center>
</p>
</cfoutput>