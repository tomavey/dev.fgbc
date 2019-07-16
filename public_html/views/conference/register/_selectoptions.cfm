<cfoutput>

<cfif regRegIsOpen()>
  #includePartial("registrationoptions")#
<cfelse>
  Online Registration is Closed.  
</cfif>  

<cfif mealsRegIsOpen()>
  #includePartial("mealoptions")#
<cfelse>  
  Online Ticket sales are Closed
</cfif>

<cfif childRegIsOpen()>
  #includePartial("childcareoptions")#
  #includePartial("kidskonferenceoptions")#
<cfelse>  
  Grace Kids Registration is Closed
</cfif>


<cfif optionsRegIsOpen()>
  #includePartial("otheroptions")#
<cfelse>
  Options signup us closed    
</cfif>

<div id="specialcode">
#textFieldTag(label="Special Code", name="specialcode", value="")#
</div>

</cfoutput>
