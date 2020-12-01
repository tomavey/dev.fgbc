<cfscript>
  cfparam(name="showType", default="showHost")
</cfscript>

<cfoutput>

  #styleSheetLinkTag("conference/conferencehomes")#

  <div class="container" style="background-color:white;padding:20px;border-radius:10px">

    #includePartial(partial="includes/#showType#")#

  </div>

  <!--- <p>
    #buttonForEmail(text="View Home", action="show", key=home.id)#
  </p>

  <p>
    #buttonForEmail(text="List of Homes", action="index")#
  </p> --->

</cfoutput>

