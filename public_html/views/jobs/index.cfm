<!----jobs index--->
<cfparam name="title" default="Ministry Opportunities">



      <!-- Promo Block -->
    <section class="g-pos-rel">
      <div class="dzsparallaxer auto-init height-is-based-on-content use-loading mode-scroll" data-options='{direction: "reverse", settings_mode_oneelement_max_offset: "150"}'>
        <div class="divimage dzsparallaxer--target w-100 g-bg-cover g-bg-pos-top-center g-bg-img-hero g-bg-bluegray-opacity-0_2--after" style="height: 130%; background-image: url(../assets/img/extra-hero-image.jpg);"></div>

         <div class="container text-center g-py-130">
        <p class="g-color-white g-font-weight-600 g-font-size-35 text-uppercase"><cfoutput>#title#</cfoutput></p>
      </div>
      </div>
    </section>
    <!-- End Promo Block --> 
    	  <div class="container text-center g-py-100" id="app">
			<cfoutput>
				<div class="card card-text container">#getcontent("jobs").content#</div>
        #linkto(text="Post a new opportunity", controller="jobs", action="new", class="btn btn-md u-btn-outline-teal g-mr-10 g-mb-15")#
				<hr/>
        <cfif !isDefined("params.showalldescriptions") && !isDefined("params.key")>
          #linkto(text="Show All Descriptions", action="index", params="showalldescriptions", class="pull-right")#
        </cfif>
        <cfif isDefined("params.key")>
          #linkto(text="Show All Opportunities", action="index", params="", class="pull-right")#
        </cfif>
			</cfoutput>
            <div class="g-pr-40--lg">
              <!-- Heading -->
              <h2 class="h2 g-color-grey g-font-weight-600 mb-4">Opportunities</h2>
              <cfoutput query="job">
              <div class="card card-charis">
                <h4 class="card-title">#linkTo(text=title, key=id)#</h4>
                //if the listing title is clicked it will add a key which will show just that job with description.  If "showalldescriptions" is in the query string all the jobs will show with descriptions
                <cfif isDefined("params.key") || isDefined("params.showalldescriptions")>
                <div class="card-text text-left">
                  #description#
                </div>  
                </cfif>
                <div class="card-text text-right">
                  #mailto(contactemail)#
                </div>
                <div class="card-text text-right">
                  Listing Expires: #dateFormat(expirationdate)#
                </div>
                <cfif gotRights("office") && len(uuid)>
                  <div class="card-text text-right">
                  #linkto(text="Public Edit Link", controller="jobs", action="edit", params="id=#uuid#")#
                  </div>
                </cfif>
              </div>
              </cfoutput>
              <!-- End Heading -->
            </div>
        </div>


