     <section class="g-py-100" id="news">
      <div class="container">
		  <header class="text-center g-width-60x--md mx-auto g-mb-50">
          <div class="u-heading-v2-3--bottom g-brd g-mb-20">
            <h1 class="h1 u-heading-v2__title g-color-gray-dark-v2 g-font-weight-600 text-uppercase">LATEST NEWS</h1>
          </div>
        </header>
					<div class="row">
                    <div class="col-lg-6 g-mb-30">
                      <!-- Article -->
                      <article>
                    <cfoutput>#includePartial("announcements")#</cfoutput>
                      </article>
                      <!-- End Article -->
                    </div>

                    <div class="col-lg-6 g-mb-30">
                      <!-- Article -->
                      <article>
                    <cfoutput>#includePartial("twitterfeed")#</cfoutput>
                      </article>
                      <!-- End Article -->
                    </div>
                  </div>
                </div>
		</div>
	  </section>
                
