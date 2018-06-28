    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
			<cfoutput>
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">

            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          #linkTo(class="brand", text="Focus Retreats", controller="focus.main", action="welcome")#
          <div class="nav-collapse">
            <ul class="nav">
              	<li class="#getActive('home')#">#linkTo(text="Home", controller="focus.main", action="welcome")#</li>
              	<li class="#getActive('about')#">#linkTo(text="About", route="focusAbout")#</li>
              	<li class="#getActive('testimonies')#">#linkTo(text="Stories", controller="focus.testimonies", action="list")#</li>
				<cfif isOffice()>
              	<li class="#getActive('admin')#">#linkTo(text="Admin", route="focusRegistrations", params="unlock=charis")#</li>
				</cfif>
        <cfif isDefined("retreats")>
				<li class="dropdown">
					#linkToData(text="Retreats<b class='caret'></b>", href="##", data_toggle="dropdown", class="dropdown-toggle")#
					<ul class="dropdown-menu">
					<cfloop query="retreats">
						<li>
							#linkto(text=menuname, controller="focus.main", action="retreat", key=id)#
						</li>
					</cfloop>	
					</ul>	
				</li>
        </cfif>
		    </ul>	
          </div><!--/.nav-collapse -->
			</cfoutput>
        </div>
      </div>
    </div>
	<div class="container container-main">

