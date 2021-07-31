<cfoutput>

	#includePartial(partial="/handbook/header")#

	<cfif !isMobile() && params.action NEQ "inspire">
	#includePartial(partial="/handbook/banner")#
	</cfif>

<div class="row">	
	
	
	<div id="content" class="span12">
	    	<cfoutput>#contentForLayout()#</cfoutput>
	</div>
	
</div>
	
	#includePartial(partial="/handbook/footer")#

</cfoutput>