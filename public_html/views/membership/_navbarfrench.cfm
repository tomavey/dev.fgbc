<cfoutput>
        #linkTo(class="brand", text="Inscription pour la FGBC", controller="membership-applications", action="index")#
          <div class="nav-collapse">
            <ul class="nav">
              <li>#linkTo(text="Ressources", controller="membership-applications", action="resources")#</li>
              <li>#linkTo(text="A propos", controller="membership-applications", action="about")#</li>
            <cfif isMembershipApp()>
              <li>#linkTo(text="T&egrave;l&egrave;charger", controller="membershipapp-resources", action="new")#</li>
            </cfif>
</cfoutput>