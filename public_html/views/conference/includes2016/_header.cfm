<cfoutput>
<cfset baseref = getConfUrl()>
<header class="top-bar" id="topbar">
  <div class="container">
    <div class="row">
      <div class="span12"><!-- logo link --><a class="logo pull-left" href="##intro" title="Vision Conference"><span></span></a>
        <div class="navbar main-nav pull-right">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
          <nav>
            <div class="nav-collapse collapse">
              <ul id="mainnav" class="nav">
                <li> <a href="#baseref###about">About</a> </li>
                <li> <a href="#baseref###speakers">Speakers</a> </li>
                <cfif showschedule()>
                  <li><a href="#baseref###schedule">Schedule</a> </li>
                </cfif>
                <cfif showworkshops()>
                  <li><a href="#baseref###workshops">Workshops</a> </li>
                </cfif>
                <cfif showchildcare()>
                  <li> <a href="#baseref###childcare">Childcare</a> </li>
                </cfif>
                <li><a href="#baseref###venue">Venue</a> </li>
                <cfif showsponsors()>
                <li><a href="#baseref###sponsors">Sponsors</a> </li>
                </cfif>
                <li><a href="http://www.fgbc.org/conference">Registration Costs</a> </li>
                <cfif shownews()>
                <li><a href="#baseref###news">News</a> </li>
                </cfif>
                <li><a href="#baseref###contact">Contact</a> </li>
              </ul>
            </div>
          </nav>
        </div>
        <!-- end navbar -->
      </div>
    </div>
    <!-- end row -->
  </div>
  <!-- end container -->
</header>
<!-- end top-bar -->
</cfoutput>