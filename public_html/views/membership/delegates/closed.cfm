<cfoutput>
  <h2 style="text-align:center">The deadline to submit delegates online has passed.</h2>
  <cfif isBefore("2020-08-01")>
    <p>Questions? Contact #mailto("tomavey@charisfellowship.us")# for assistance.</p>
  <cfelse>  
    <p style="text-align:center">You can download the credential form <a href="https://charisfellowship.us/files/credential_form.doc">HERE</a> and submit the completed form at the welcome center the day before the meeting. <br/>Your church must qualify as a member church in good standing in order for your delegates to be seated.</p>  
  </cfif>
</cfoutput>
