<cfparam name="thankyouMessag" default="We will review your post and let you know if there are any problems.">
<cfoutput>
<div class="container card card-charis">

	<h1 class="text-center">Thank you for submitting your ministry opportunity.</h1>
	<h3 class="text-center">#thankyouMessage#</h3>
	<cfif isDefined("params.key")>
		<p class="well text-center"> Bookmark this link and use it to edit your posting:<br/>
			#linkTo(controller="jobs", action="edit", params="id=#params.key#", onlyPath=false, class="btn btn-large text-center")#
		</p>
	</cfif>

</div>
</cfoutput>