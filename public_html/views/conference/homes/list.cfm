<cfoutput>
#styleSheetLinkTag("conference/conferencehomes")#

<cfparam name="instructions" default="AccessHostRequestInstructions">
<cfparam name="instructionsId" default=0>

<div class="container" style="background-color:white;padding:20px;border-radius:10px">

    <cfif gotRights("office")>
      <p class="pull-right">
        #linkto(text="<i class='fa fa-pencil-square'></i>", controller="admin.contents", action="edit", key=instructionsId)#
      </p>
    </cfif>
  
    <p>#instructions#</p>
  
  
  <!--- <cfdump var="#homes#"><cfabort> --->
  
  <cfscript>
    for ( home in homes ) {
        writeOutput(includePartial("includes/list"))
    }
  </cfscript>

</div>
</cfoutput>

