<cfoutput>
<div class="container card card-charis">

	<h1 class="text-center">Thank you for submitting your ministry opportunity.</h1>
	<h3 class="text-center">We will review and approve the posting as soon as possible.</h3>
	<cfif isDefined("params.key")>
		<p class="well text-center">Save this link and use it to edit your posting:<br/>
			#linkTo(controller="jobs", action="edit", params="id=#params.key#", onlyPath=false, class="btn btn-large text-center")#
		</p>
	</cfif>

</div>
</cfoutput>