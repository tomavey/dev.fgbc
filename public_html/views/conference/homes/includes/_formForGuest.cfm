<cfscript>
  cfparam(name="type", default="host")
</cfscript>

<cfoutput>

  <div class="homes-form">

  #includePartial(partial="includes/contactfields")#

  #includePartial(partial="includes/guestfields")#

</div>

</cfoutput>

                    
