<div class="container card card-charis card-charis-square text-center">
<h1>Thank you for creating a new account at charisfellowship.us!</h1>
<p>You should be logged in now.</p>
<cfoutput>
	<cfif isDefined("session.originalURL")>
		#linkto(text="Return to where you were.",  href="#session.originalURL#", class="btn")#
	<cfelse>
		#linkto(text="Return to main page",  controller="home", action="index", class="btn")#
	</cfif>
</cfoutput>
</div>