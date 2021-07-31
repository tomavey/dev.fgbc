<!DOCTYPE html>
<html lang="en">

  <cfoutput>

  #includePartial(partial="/charis/head")#

  #includePartial(partial="/charis/modal_login")#

  <!--- #includePartial(partial="/charis/modal_rebrand")# --->

  <body>

    <main>

      #includePartial(partial="/charis/header")#

      #contentForLayout()#

      <cfif !isDefined("params.noFooter")>
        <cftry>
          #includePartial(partial="/charis/footer", dataFunction="footerData")#
        <cfcatch></cfcatch>    
        </cftry>
      </cfif>

    </main>

    <div class="u-outer-spaces-helper"></div>

    #includePartial(partial="/charis/jsIncludeTags")#

    <cfif application.wheels.environment NEQ "production" && gotRights("office")>
        <cftry>
          <cfdump var="#session.auth#" label="session auth">
          Rightslist: #session.auth.rightslist#
          Handbook rights? #gotrights("handbook")#
          <cfdump var="#cgi#" label="Cgi">
        <cfcatch>
        </cfcatch>
        </cftry>
        <cftry>
          <cfdump var="#session.listingURL#" label="listingURL">
          <cfdump var="#session.originalURL#" label="originalURL">
          <cfcatch>
          </cfcatch>
        </cftry>
    </cfif>



  </body>

  </cfoutput>

</html>