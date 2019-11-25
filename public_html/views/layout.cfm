<!DOCTYPE html>
<html lang="en">

  <cfoutput>

  #includePartial("/charis/head")#

  #includePartial(partial="/charis/modal_login")#

  <!--- #includePartial("/charis/modal_rebrand")# --->

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

    #includePartial("/charis/jsIncludeTags")#

    <cfif application.wheels.environment NEQ "production">
        <cftry>
          <cfdump var="#session.auth#" label="session auth">
          #session.auth.rightslist#
          #gotrights("handbook")#
          <cfdump var="#cgi#" label="Cgi">
        <cfcatch>
        </cfcatch>
        </cftry>
    </cfif>



  </body>

  </cfoutput>

</html>