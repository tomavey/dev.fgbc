    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
			<cfoutput>
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">

            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
		  <cfif params.action is "getChurchId">
               #linkTo(class="brand", text="Please select your church from the dropdown list...", controller="fgbc-delegates", action="submit")#
		  <cfelseif params.action is "show" or params.action is "submit" or params.action is "email">
		       #linkTo(class="brand", text=church.name, controller="fgbc-delegates", action="submit")#
	      <cfelse>   
          <div class="nav-collapse">
            <ul class="nav">
              <li class="active">#linkTo(text="Home", controller="membership.delegates", action="index")#</li>

              <li>#linkTo(text="Delinquent", controller="membership.delegates", action="delinquent")#</li>
              <li>#linkTo(text="PDF Form", href="http://www.fgbc.org/files/credential_form.pdf")#</li>
              <li>#linkTo(text="Settings", controller="admin.settings", action="index", params="category=delegates")#</li>

      			  <!---li>	
      				  	#startFormTag(action="search", class="navbar-search")#
      					#textFieldTag(name="key", class="search-query input-small", placeholder="Search")#
      					#endFormTag()#
      			  </li--->	
            </ul>
			<cfif isdefined("session.auth.email")>	
           	 	<p class="navbar-text pull-right">#session.auth.email#&nbsp;#linkto(text="Logout", route="authLogoutUser")#</p>
			</cfif>
          </div><!--/.nav-collapse -->
		  </cfif>
			</cfoutput>
        </div>
      </div>
    </div>
