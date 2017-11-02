<!----jobs index--->
    <!-- Promo Block -->
    <section class="g-pos-rel">
      <div class="dzsparallaxer auto-init height-is-based-on-content use-loading mode-scroll" data-options='{direction: "reverse", settings_mode_oneelement_max_offset: "150"}'>
        <div class="divimage dzsparallaxer--target w-100 g-bg-cover g-bg-pos-top-center g-bg-img-hero g-bg-bluegray-opacity-0_2--after" style="height: 130%; background-image: url(../assets/img/extra-hero-image.jpg);"></div>

         <div class="container text-center g-py-130">
        <h3 class="h3 g-color-white g-font-weight-300 mb-2">Ministry Possibilities</h3>
        <p class="g-color-white g-font-weight-600 g-font-size-35 text-uppercase">Charis Fellowship churches have posted the following opennings...</p>
      </div>
      </div>
    </section>
    <!-- End Promo Block --> 
	  <div class="container text-center g-py-100">
			<cfoutput>
				<p>#getcontent("jobs").content#</p>
        #linkto(text="Post a new opportunity", controller="jobs", action="new", class="btn btn-md u-btn-outline-teal g-mr-10 g-mb-15")#
				<hr/>
			</cfoutput>
            <div class="g-pr-40--lg">
              <!-- Heading -->
              <h2 class="h2 g-color-grey g-font-weight-600 mb-4">Opportunities</h2>
              <cfoutput query="job">
              <div class="card card-charis">
              <h4 class="card-title">#linkTo(text=title, key=id)#</h4>
              <div class="card-text text-left">
                #description#
              </div>  
              <div class="card-text text-right">
                #mailto(contactemail)#
              </div>
              <div class="card-text text-right">
                Listing Expires: #dateFormat(expirationdate)#
              </div>
              </div>
              </cfoutput>
              <!-- End Heading -->
            </div>
    </div>
