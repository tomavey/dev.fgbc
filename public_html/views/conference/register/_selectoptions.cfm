<cfparam name="showClosedMessage" default = "false">

<cfoutput>

<cfif !regRegIsOpen() || !mealsRegIsOpen() || !childRegIsOpen() || !optionsRegIsOpen()>
  <cfset showClosedMessage = "true">
</cfif>

<cfif showClosedMessage>
  <h3 style="text-align:center;display:block">
    The following registration options are now closed:
  </h3>
</cfif>

<cfif regRegIsOpen()>
  #includePartial("registrationoptions")#
<cfelse>
  <p style="text-align:center;display:block">
    Conference Registration<br/>
  </h3>  
</cfif>  

<cfif mealsRegIsOpen()>
  #includePartial("mealoptions")#
<cfelse>  
  <p style="text-align:center;display:block">
    Meal Tickets<br/>
  </p>
</cfif>

<cfif childRegIsOpen()>
  #includePartial("childcareoptions")#
  #includePartial("kidskonferenceoptions")#
<cfelse>  
  <p style="text-align:center;display:block">
    Grace Kids<br/>
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
