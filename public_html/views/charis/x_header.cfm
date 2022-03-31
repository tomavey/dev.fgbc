  <!-- Header -->
    <header id="js-header" class="u-header u-header--static">
      <!-- Top Bar -->
      <div class="u-header__section u-header__section--hidden u-header__section--dark g-bg-black g-py-13">
        <div class="container">
          <div class="row flex-column flex-md-row align-items-center justify-content-between text-uppercase g-color-white g-font-size-11 g-mx-minus-15">

            <div class="col-auto g-px-15 w-100 g-width-auto--md">
            </div>

<cfoutput>
            <div class="col-auto g-px-15">
              <ul class="list-inline g-line-height-1 g-mt-minus-10 g-mx-minus-4 mb-0">
                <li class="list-inline-item g-mx-4 g-mt-10">
                    #linkto(text="Give", href="https://www.encompassworldpartners.org/FellowshipCovid", class="g-color-white g-color-primary--hover g-text-underline--none--hover")#
                </li>
                <li class="list-inline-item g-mx-4 g-mt-10">|</li>
                <li class="list-inline-item g-mx-4 g-mt-10">
                    #linkTo(text="Contact Us", controller="messages", action="new", class="g-color-white g-color-primary--hover g-text-underline--none--hover")#
                </li>
                <li class="list-inline-item g-mx-4 g-mt-10">|</li>
                <li class="list-inline-item g-mx-4 g-mt-10">
                  <cfif gotRights("basic")>
                      #linkTo(text="Logout", route="authLogoutUser", class="g-color-white g-color-primary--hover g-text-underline--none--hover")#
                  <cfelse>
                      <a href="##login" data-modal-target="##login" data-modal-effect="slide" class="g-color-white g-color-primary--hover g-text-underline--none--hover">Login</a>
                  </cfif>    
                </li>
                <cfif !gotRights("basic")>
                <li class="list-inline-item g-mx-4 g-mt-10">|</li>
                  <li class="dropdown list-inline-item g-mx-4 g-mt-10">
                    <a class="dropdown-toggle g-color-white g-color-primary--hover g-text-underline--none--hover" data-toggle="dropdown" href="##">Account<b class="caret"></b></a>
                    <ul class="dropdown-menu" style="padding:10px">
                      <li>#linkTo(text="Create an Account.", route="authNewUser")#</li>
                      <li class="list-inline-item g-mx-4 g-mt-10">
                      </li>
                      <li>#linkTo(text="Forgot Password.", route="authForgotPassword")#</li>
                    </ul>
                  </li>
                </cfif>    
                <li class="list-inline-item g-mx-4 g-mt-10">
                </li>
              </ul>
            </div>
  </cfoutput>          
          </div>
        </div>
      </div>
      <!-- End Top Bar -->

      <div class="u-header__section u-header__section--light g-bg-white-opacity-0_8 g-py-10" data-header-fix-moment-exclude="g-bg-white-opacity-0_8 g-py-10" data-header-fix-moment-classes="g-bg-white u-shadow-v18 g-py-0">
        <nav class="navbar navbar-expand-lg">
          <div class="container">
            <!-- Responsive Toggle Button -->
            <button class="navbar-toggler navbar-toggler-right btn g-line-height-1 g-brd-none g-pa-0 g-pos-abs g-top-3 g-right-0" type="button" aria-label="Toggle navigation" aria-expanded="false" aria-controls="navBar" data-toggle="collapse" data-target="#navBar">
              <span class="hamburger hamburger--slider">
            <span class="hamburger-box">
              <span class="hamburger-inner"></span>
              </span>
              </span>
            </button>
            <!-- End Responsive Toggle Button -->
            <!-- Logo -->
            <a href="/" class="navbar-brand">
              <img src="../../assets/img/logo/charis-logo-main.png" alt="charis-fellowship-logo" width="280">
            </a>
            <!-- End Logo -->

            <!-- Navigation -->
            <div class="collapse navbar-collapse align-items-center flex-sm-row g-pt-10 g-pt-5--lg" id="navBar">
          <cfoutput>
              <ul class="navbar-nav text-uppercase g-font-weight-600 ml-auto" id="js-scroll-nav">
                <li class="nav-item g-mx-20--lg">
                  #linkTo(text="ABOUT", href="##about", class="nav-link px-0 #isNavActive("about")#")#
                </li>
                <li class="nav-item g-mx-20--lg">
                  #linkTo(text="NEWS", href="##news", class="nav-link px-0 #isNavActive("news")#")#
                </li>
                <!--- <li class="nav-item g-mx-20--lg">
                  #linkTo(text="PRAYER", href="https://www.charisalliance.org/en/prayer/", target="_new", class="nav-link px-0 #isNavActive("prayer")#")#
                </li> --->
                <!--- <li class="nav-item dropdown g-mx-20--lg">
                  #linkTo(
                      text="Prayer<b class='caret'></b>", 
                      controller="events", 
                      action="index", 
                      encode="arguments",
                      class="dropdown-toggle nav-link px-0 #isNavActive("events")#", data_toggle="dropdown")#
                  <ul class="dropdown-menu" style="padding:10px">
                    <!--- <li>#linkTo(text="Charis Alliance (global)", href="https://www.charisalliance.org/en/prayer/", target="_new")#</li> --->
                    <li class="list-inline-item g-mx-4 g-mt-10">
                    </li>
                    <li>#linkTo(text="Charis Prayer (USA and Canada)", href="https://charisfellowship.us/page/charisprays", target="_new")#</li>
                    <li class="list-inline-item g-mx-4 g-mt-10">
                  </ul>
              </li> --->
              <li class="nav-item g-mx-20--lg">
                    #linkTo(text="CHURCHES", controller="churches", action="index", class="nav-link px-0 #isNavActive("churches")#")#
                </li>
                <li class="nav-item dropdown g-mx-20--lg">
                    #linkTo(
                        text="EVENTS<b class='caret'></b>", 
                        controller="events", 
                        action="index", 
                        class="dropdown-toggle nav-link px-0 #isNavActive("events")#", data_toggle="dropdown")#
                    <ul class="dropdown-menu" style="padding:10px">
                      <li>#linkTo(text="General Calendar", controller="events", action="index")#</li>
                      <li class="list-inline-item g-mx-4 g-mt-10">
                      </li>
                      <li>#linkTo(text="Focus Retreats", controller="focus.main", action="welcome")#</li>
                      <li class="list-inline-item g-mx-4 g-mt-10"></li>
                      <li>#linkTo(text="WeAreOne", href="https://charisfellowship.us/page/weareone")#</li>
                      <li class="list-inline-item g-mx-4 g-mt-10"></li>
                      <li>#linkTo(text="Access2021", href="https://access2021.us/")#</li>
                    </ul>
                </li>
                <li class="nav-item dropdown g-mx-20--lg">
                    #linkTo(
                        text="OPPORTUNITIES<b class='caret'></b>", 
                        controller="jobs", 
                        action="index", 
                        class="dropdown-toggle nav-link px-0 #isNavActive("events")#", data_toggle="dropdown")#
                    <ul class="dropdown-menu" style="padding:10px">
                      <li>#linkTo(text="Give", href="https://www.encompassworldpartners.org/FellowshipCovid")#</li>
                      <li class="list-inline-item g-mx-4 g-mt-10">
                      </li>
                      <li>#linkTo(text="Positions", controller="jobs", action="index")#</li>
                      <li class="list-inline-item g-mx-4 g-mt-10">
                      </li>
                      <li>#linkTo(text="Ministries", controller="ministries", action="index")#</li>
                      <li class="list-inline-item g-mx-4 g-mt-10">
                      <li>#linkTo(text="Resources", controller="resources", action="index")#</li>
                    </ul>
                  </li>
              </ul>
            </cfoutput>       
            </div>
            <!-- End Navigation -->
          </div>
        </nav>
        <cftry>
          <cfif isBefore(getSetting("covidPageIsOpenBefore"))>
            <a href="https://charisfellowship.us/page/covid" class="container" style="border: 3px solid #51758C; text-align:center; font-weight: bold; font-size: 1.2em; display: block; ">
            The Charis Fellowship and COVID-19
          </a>
        </cfif>
          <cfif isBefore(getSetting('prayerWallIsOpenBefore'))>
            <a href=" http://charisfellowship.us/page/globalPrayerWall" target="_new" class="container" style="border: 3px solid #51758C; text-align:center; font-weight: bold; font-size: 1.2em; display: block; margin-top:10px">
              The Charis Prayer Wall
            </a>
          </cfif>
          <cfif isBefore('2020-07-31')>
            <div class="container" style="border: 3px solid #51758C; border-radius:20px; box-shadow: 5px 5px 5px #4F7F71;" >
              <p>
                <a href=" https://charisfellowship.us/page/weAreOneBreakouts" target="_new" class="container" style="border: 3px solid #51758C; text-align:center; font-weight: bold; font-size: 1.2em; color: white; display: block; margin-top:10px; background-color: #345671">
                  WeAreOne Breakouts are Monday (7/27) - Thursday (7-30) - Click here for information
                </a>
              </p>
            </div>  
            <br/>
          </cfif>
          <cfif isAfter('2020-07-26 19:00') || getSetting("forceMainPageBannerOpen")>
            <div class="container" style="border: 3px solid #51758C; border-radius:20px; box-shadow: 5px 5px 5px #4F7F71;" >
              <p>
                <a href="https://www.inspirepastors.org/charis-beliefs" target="_new" class="container" style="border: 3px solid #51758C; text-align:center; font-weight: bold; font-size: 1.2em; color: white; display: block; margin-top:10px; background-color: #345671">
                  Watch the Charis Beliefs Video Series HERE! 
                </a>
              </p>
            </div>  

          </cfif>  

          <cfif isBefore('2021-02-01 00:00')>
            <div class="container" style="border: 3px solid #51758C; border-radius:20px; box-shadow: 5px 5px 5px #4F7F71;" >
              <p>
                <a href="https://buildmomentum.org/" target="_new" class="container" style="border: 3px solid #51758C; text-align:center; font-weight: bold; font-size: 1.2em; color: white; display: block; margin-top:10px; background-color: #345671">
                  Introducing Momentum Ministry Partners 
                </a>
              </p>
            </div>  

          </cfif>  

        <cfcatch></cfcatch>  
        </cftry>
      </div>
    </header>
    <!-- End Header -->

    <cfscript>
      public function isNavActive(item){
        if (item EQ params.controller){
          return "active";
        } 
        return "inactive";
      }

      public function onCovid(){
        alert("hi")
      }

    </cfscript>