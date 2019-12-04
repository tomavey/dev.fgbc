<cfoutput>
	<div class="homes homes-office">
		<p><span>Approved?</span>#home.approved#</p>
	</div>
	#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this home", action="edit", key=home.id)#
</cfoutput>
