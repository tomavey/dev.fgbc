<cfoutput>

<cfif gotRights("basic")>
	<div class="well">
		#linkto(text="Since you are already logged into fgbc.org you go directly to the form!", controller="membership.newchurches", action="edit", key=newchurch.uuid, onlyPath=false)#
	</div>	
<cfelse>	
	<h1>An email has been sent to #newchurch.email# with a link to verify your email address.</h1>
	<h2>Your new-church record has been started.  Use this link to complete the form.  Save this link so you can edit the for later.</h2>
<p>#linkto(controller="membership.newchurches", action="edit", key=newchurch.uuid, onlyPath=false)#
</p>
</cfif>
</cfoutput>