<cfparam name="title" default="Upcoming Events in the Charis Fellowship">

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

	  <div class="container text-center g-py-100">
            <div class="g-pr-40--lg">
              <!-- Heading -->
              <h2 class="h2 g-color-grey g-font-weight-600 mb-4">Events</h2>
              <cfoutput query="events">
                <div class="card card-inverse card-charis">
                    <div class="card-block">
                        <h4 class="card-title">
                            <a href="#eventlink#">#event#</a>
                        </h2>
                        <div class="card-text">
                                    <cfif begin eq end>
                                        #dateformat(begin,"medium")#
                                    <cfelse>
                                        <cfif datepart("m",begin) is datepart("m",end)>
                                            #dateformat(begin,"MMM")# #dateformat(begin,"dd")# - #dateformat(end,"dd")#, #dateformat(begin,"yyyy")#
                                        <cfelse>
                                            #dateformat(begin,"MMM")# #dateformat(begin,"dd")# - #dateformat(end,"MMM")# #dateformat(end,"dd")#, #dateformat(begin,"yyyy")#
                                        </cfif>
                                    </cfif>
                        </div>
                        <div class="card-text">
                            Sponsor: <a href="#sponsorlink#">#sponsor#</a>
                        </div>
                </div>
                </div>
              </cfoutput>
              <!-- End Heading -->
            </div>
    </div>
