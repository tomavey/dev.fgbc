<cfoutput>
	#includePartial(partial="/handbook/header")#

	<cfif not isMobile()>
	#includePartial(partial="/handbook/banner")#
	</cfif>

		<cfif not params.controller is "handbookwelcome">
			#includePartial(partial="/handbook/navigation")#
		</cfif>

<div class="row">


	<div class="span11">
	    	#contentForLayout()#
	</div>
</div>

	#includePartial(partial="/handbook/footer")#

</cfoutput>