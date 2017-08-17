<cfoutput>
	#includePartial("/handbook/header")#

	<cfif not isMobile()>
	#includePartial("/handbook/banner")#
	</cfif>

		<cfif not params.controller is "handbookwelcome">
			#includePartial("/handbook/navigation")#
		</cfif>

<div class="row">


	<div class="span11">
	    	#contentForLayout()#
	</div>
</div>

	#includePartial("/handbook/footer")#

</cfoutput>