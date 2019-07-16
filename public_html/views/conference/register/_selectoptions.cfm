<cfparams name="showClosedMessage" default = "false">

<cfoutput>

<cfif !regRegIsOpen() || !mealsRegIsOpen() || !childRegIsOpen() || !optionsRegIsOpen()>
  <cfset showClosedMessage = "true">
</cfif>

<cfif showClosedMessage>
  <h3 style="text-align:center">
    The following registration options are now closed:
  </h3>
</cfif>

<cfif regRegIsOpen()>
  #includePartial("registrationoptions")#
<cfelse>
  <p style="text-align:center">
    Conference Registration<br/>
  </h3>  
</cfif>  

<cfif mealsRegIsOpen()>
  #includePartial("mealoptions")#
<cfelse>  
  <p style="text-align:center">
    Meal Tickets
  </p>
</cfif>

<cfif childRegIsOpen()>
  #includePartial("childcareoptions")#
  #includePartial("kidskonferenceoptions")#
<cfelse>  
  <p style="text-align:center">
    Grace Kids.
  </p>
</cfif>


<cfif optionsRegIsOpen()>
  #includePartial("otheroptions")#
<cfelse>
  <p style="text-align:center">
    Other Options.    
  </p>
</cfif>

<div id="specialcode">
#textFieldTag(label="Special Code", name="specialcode", value="")#
</div>

</cfoutput>
