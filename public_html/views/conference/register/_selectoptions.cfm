<cfoutput>

<cfif regRegIsOpen()>
  #includePartial("registrationoptions")#
<cfelse>
  <p>
    Online Registration is Closed.<br/>
  </p>  
</cfif>  

<cfif mealsRegIsOpen()>
  #includePartial("mealoptions")#
<cfelse>  
  <p>
    Online Ticket sales are Closed.
  </p>
</cfif>

<cfif childRegIsOpen()>
  #includePartial("childcareoptions")#
  #includePartial("kidskonferenceoptions")#
<cfelse>  
  <p>
    Grace Kids Registration is Closed.
  </p>
</cfif>


<cfif optionsRegIsOpen()>
  #includePartial("otheroptions")#
<cfelse>
  <p>
    Options signup is closed.    
  </p>
</cfif>

<div id="specialcode">
#textFieldTag(label="Special Code", name="specialcode", value="")#
</div>

</cfoutput>
