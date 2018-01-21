<cfparam name="pageTitle" default="FGBC Membership Application">
<cfparam name="pageTitleLinkController" default="membership.applications">
<cfparam name="pageTitleLinkAction" default="index">

<div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
      <cfoutput>
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">

            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <cfif isDefined("session.membershipapplication.language") and session.membershipapplication.language is "Spanish">
              #includePartial("/membershipapplayouts/navbarspanish")#
          <cfelseif isDefined("session.membershipapplication.language") and session.membershipapplication.language is "French">
              #includePartial("/membershipapplayouts/navbarfrench")#
          <cfelse>    
          #linkTo(class="brand", text=pagetitle, controller=pageTitleLinkController, action=pageTitleLinkAction)#
          <div class="nav-collapse">
            <ul class="nav">
              <li>#linkTo(text="Resources", controller="membership.applications", action="resources")#</li>
              <li>#linkTo(text="About", controller="membership.applications", action="about")#</li>
            <cfif isMembershipApp()>
              <li>#linkTo(text="Upload", controller="membership.resources", action="new")#</li>
            </cfif>  
          </cfif>    
              <cfif gotRights("superadmin,office") OR isFellowshipCouncil()>
                <li class="dropdown">
                    <a href="##" class="dropdown-toggle" data-toggle="dropdown">Admin<b class="caret"></b></a>
                    
                    <ul class="dropdown-menu">
                      <li>#linkTo(text="List Apps", controller="membership.applications", action="index")#</li>
                      <li>#linkTo(text="Questions", controller="membership.questions", action="index")#</li>
                      <li>#linkTo(text="Resources", controller="membership.resources", action="index", params="showall=true")#</li>
                      <li>#linkTo(text="Clear", controller="membership.applications", action="clear")#</li>
                    </ul>
              </li>
              </cfif>

        <cfif gotRights("superadmin,office")>
          <li>  
              #startFormTag(action="search", class="navbar-search")#
            #textFieldTag(name="search", class="search-query input-small", placeholder="Search")#
            #endFormTag()#
          </li> 
        </cfif>
            </ul>
      <cfif isdefined("session.membershipapplication.email")>  
              <p class="navbar-text pull-right">#session.membershipapplication.email#</p>
      </cfif>
          </div><!--/.nav-collapse -->
      </cfoutput>
        </div>
      </div>
    </div>
