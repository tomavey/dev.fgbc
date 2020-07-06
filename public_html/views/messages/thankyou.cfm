<cfoutput>
<div class="container card card-charis">
	<div class="text-center"><h1>Thank you for your message.<br/>  Stay tuned!</h1>
	<cfif flashKeyExists("failed")>
            <p class="successMessage">
                #flash("failed")#
            </p>
  </cfif>
	</div>
</div>
</cfoutput>