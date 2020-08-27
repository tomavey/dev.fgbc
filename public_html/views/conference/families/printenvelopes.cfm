<cfoutput query="envelopes">
<cfset thisenvelopeinfo = thisFamilyEnvelopeInfo(id)>
<cfif len(thisenvelopeinfo.items)>

<div>
  <p>
  	<span>#LNAME#,&nbsp;#thisFamilyEnvelopeInfo(id).name#</span><br/> 
  	(#linkto(text=thisenvelopeinfo.invoice, controller="invoices", action="show", key=val(thisenvelopeinfo.invoice))#
  	#thisenvelopeinfo.status#)
  </p>	
  <p>
   	#thisenvelopeinfo.items#
  </p>	
</div>

</cfif>
</cfoutput>