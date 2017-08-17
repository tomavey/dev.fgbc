<cfoutput>
	#includePartial("/handbook/header")#

	<cfif not isMobile()>
	#includePartial("/handbook/banner")#
	</cfif>

<div class="row">	
	
	
	<div id="content" class="span12">
	    	<cfoutput>#contentForLayout()#</cfoutput>
	</div>
	
</div>
	
	#includePartial("/handbook/footer")#

</cfoutput>