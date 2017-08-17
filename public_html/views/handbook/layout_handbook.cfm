<cfoutput>

	#includePartial("/handbook/header")#

	<cfif not isMobile()>
	#includePartial("/handbook/banner")#
	</cfif>

		<cfif not params.controller is "handbook.welcome">
			#includePartial("/handbook/navigation")#
		</cfif>

<div class="row">	
	
	<cfif isMobile()>
		<cfset spancount = 10>
	<cfelse>
		<cfset spancount = 6>
	</cfif>	

	<div class="span1">
	</div>
	
	<div class="span#spancount#" id="maininfo">
	    	#contentForLayout()#
	</div>
	
	<div id="thisAjaxInfo" class="span4 well visible-desktop">
		Move your cursor over names to temporarily view information then click to switch the information to the center screen.
	</div>
</div>

	#includePartial("/handbook/footer")#
	
</cfoutput>