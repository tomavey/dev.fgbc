    <!-- Header -->
    <header id="js-header" class="u-header u-header--static">
      <!-- Top Bar -->
      <div class="u-header__section u-header__section--hidden u-header__section--dark g-bg-black g-py-13">
        <div class="container">
          <div class="row flex-column flex-md-row align-items-center justify-content-between text-uppercase g-color-white g-font-size-11 g-mx-minus-15">

            <div class="col-auto g-px-15 w-100 g-width-auto--md">
              <ul id="dropdown-megamenu" class="d-md-block collapse list-inline g-line-height-1 g-mx-minus-4 mb-0">
              <cfoutput>
                <li class="d-block d-md-inline-block g-mx-4">
                  #linkTo(text="Contact Us", controller="messages", action="new", class="g-color-white g-color-primary--hover g-text-underline--none--hover")#
                </li>
              </cfoutput>  
              </ul>
            </div>

            <div class="col-auto g-px-15">
              <ul class="list-inline g-line-height-1 g-mt-minus-10 g-mx-minus-4 mb-0">
                <li class="list-inline-item g-mx-4 g-mt-10">
                  <a href="#login" data-modal-target="#login" data-modal-effect="slide" class="g-color-white g-color-primary--hover g-text-underline--none--hover">Login</a>
                </li>
                <li class="list-inline-item g-mx-4 g-mt-10">|</li>
                <li class="list-inline-item g-mx-4 g-mt-10">
                  <a href="#" class="g-color-white g-color-primary--hover g-text-underline--none--hover">Register</a>
                </li>
                <li class="list-inline-item g-mx-4 g-mt-10">
                </li>
              </ul>
            </div>
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
            <a href="index.cfm" class="navbar-brand">
              <img src="../../assets/img/logo/charis-logo-main.png" alt="charis-fellowship-logo">
            </a>
            <!-- End Logo -->

            <!-- Navigation -->
            <div class="collapse navbar-collapse align-items-center flex-sm-row g-pt-10 g-pt-5--lg" id="navBar">
          <cfoutput>
              <ul class="navbar-nav text-uppercase g-font-weight-600 ml-auto">
                <li class="nav-item g-mx-20--lg">
                  #linkTo(text="HOME", controller="Charis", action="index", class="nav-link px-0 #isNavActive("home")#")#
                </li>
                <li class="nav-item g-mx-20--lg">
                  #linkTo(text="WHO ARE WE", controller="about", action="cci", class="nav-link px-0 #isNavActive("about")#")#
                </li>
                <li class="nav-item g-mx-20--lg">
                    #linkTo(text="CHURCHES", controller="churches", action="index", class="nav-link px-0 #isNavActive("churches")#")#
                </li>
                <li class="nav-item g-mx-20--lg">
                    #linkTo(text="EVENTS", controller="events", action="index", class="nav-link px-0 #isNavActive("events")#")#
                </li>
                <li class="nav-item g-mx-20--lg">
                    #linkTo(text="OPPORTUNITIES", controller="jobs", action="index", class="nav-link px-0 #isNavActive("jobs")#")#
                </li>
                </cfoutput>       
              </ul>
            </div>
            <!-- End Navigation -->
          </div>
        </nav>
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
    </cfscript>
