<cfscript>
  cfparam(name="showType", default="showHost")
</cfscript>

<cfoutput>

  #styleSheetLinkTag("conference/conferencehomes")#

  <div class="container">

    #includePartial("includes/#showType#")#

  </div>

</cfoutput>

