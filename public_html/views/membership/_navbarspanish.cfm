<cfoutput>
        #linkTo(class="brand", text="FGBC Solicitud de Membres&eacute;a", controller="membership-applications", action="index")#
          <div class="nav-collapse">
            <ul class="nav">
              <li>#linkTo(text="Recursos", controller="membership-applications", action="resources")#</li>
              <li>#linkTo(text="Sobre", controller="membership-applications", action="about")#</li>
            <cfif isMembershipApp()>
              <li>#linkTo(text="Subir", controller="membershipapp-resources", action="new")#</li>
            </cfif>  
</cfoutput>