<cfscript>
  cfparam(name="showType", default="showHost")
</cfscript>

<cfoutput>

  #styleSheetLinkTag("conference/conferencehomes")#

  <div class="container" style="background-color:white;padding:20px;border-radius:10px">

    #includePartial("includes/#showType#")#

  </div>


</cfoutput>

