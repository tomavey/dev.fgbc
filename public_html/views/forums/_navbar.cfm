    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
			<cfoutput>
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">

            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          #linkTo(class="brand", text=getThisForumName(), controller="forums.posts", action="list")#
          <div class="nav-collapse">
			<cfif getThisForumName() contains "login">
			<cfelse>	
            <ul class="nav">
              <li class="#getNavbarItemClass("home")#">#linkTo(text="Home", controller="forums.posts", action="List")#</li>

              <li class="#getNavbarItemClass("about")#">#linkTo(text="About", controller="forums.forums", action="about")#</li>
              <li class="#getNavbarItemClass("upload")#">#linkTo(text="Upload", controller="forums.resources", action="new")#</li>
              <li class="#getNavbarItemClass("log")#">#linkTo(text="Log", controller="forums.forums", action="forumlog")#</li>
			  <li>	
				  	#startFormTag(action="search", class="navbar-search")#
					#textFieldTag(name="key", class="search-query input-small", placeholder="Search")#
					#endFormTag()#
			  </li>	
            </ul>
			</cfif>
			<cfif isdefined("session.auth.email")>	
           	 	<p class="navbar-text pull-right">#session.auth.email#&nbsp;#linkto(text="Logout", route="authLogoutUser")#</p>
			</cfif>
          </div><!--/.nav-collapse -->
			</cfoutput>
        </div>
      </div>
    </div>
