<cfoutput>
#styleSheetLinkTag("conference/conferencehomes")#

<cfparam name="instructions" default="AccessHostRequestInstructions">
<cfparam name="instructionsId" default=0>

<div class="container" style="background-color:white;padding:20px;border-radius:10px">

  #includePartial("includes/navbar")#

    <cfif gotRights("office")>
      <p class="text-right">
        #linkto(text="<i class='fa fa-pencil-square'></i>", controller="admin.contents", action="edit", key=instructionsId)#
      </p>
    </cfif>
  
    <p>#instructions#</p>
  
  
  <!--- <cfdump var="#homes#"><cfabort> --->

  <cfscript>
    if ( !Homes.recordcount ){
      writeOutput(
        "<div style='border:2px solid black; margin-bottom:30px; padding: 20px'><h1 class='text-center'>There are no host homes ready for selection at this time. Check back soon!</h1></div>"
      );
    } else {
      for ( home in homes ) {
        writeOutput(includePartial("includes/list"))
      }
    }
    writeOutput(hiddenMessagetoTestFor())
  </cfscript>

</div>
</cfoutput>

