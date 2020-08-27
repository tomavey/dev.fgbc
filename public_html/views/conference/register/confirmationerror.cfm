<p>There was an error during the final confirmation step of a conference registration.  Check for a recent registration that was not completed properly.</p>
<p>Possible reasons:
<ul>
<li>Credit card did not process.</li>
<li>Code glitch</li>
<li>Registrar waited too long to complete process</li>
<li>The planets aligned wrongly</li>
</ul>
</p>
<cfif isStruct("params")>
    <cfdump var="#params#">
</cfif>
<cfif isStruct("cfcatch")>
    <cfdump var="#cfcatch#">
</cfif>