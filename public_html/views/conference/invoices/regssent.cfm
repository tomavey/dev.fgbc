<div class="container">
<cfoutput>
<h1 class="text-center">A list of invoices connected with #params.email# has been sent to #params.email#.</h1>
<p class="well text-center">
Be sure to check your junk mail folder!  Click on each invoice to see details and to add items to your registration.
    <cfif workshopsRegOpen()>Or to sign up for workshops.</cfif>
</p>
<p>#linkTo(text="Go back to the registration center", class="btn btn-block", controller="conference.register", action="selectregtype")#</p>
</cfoutput>
</div>