<cfoutput>

	#includePartial(partial="/handbook/header")#

	<cfif not isMobile()>
	#includePartial(partial="/handbook/banner")#
	</cfif>

		<cfif not params.controller is "handbook.welcome">
			#includePartial(partial="/handbook/navigation")#
		</cfif>

<div class="row">	
	
	<cfif isMobile()>
		<cfset spancount = 10>
	<cfelse>
		<cfset spancount = 6>
	</cfif>	

	<div class="span0">
	</div>
	
	<div class="span#spancount#" id="maininfo">
	    	#contentForLayout()#
	</div>
	
	<div id="thisAjaxInfo" class="span4 well visible-desktop">
	</div>
</div>

	#includePartial(partial="/handbook/footer")#
	
</cfoutput>