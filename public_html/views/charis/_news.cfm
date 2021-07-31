<cfparam name="newsClass" default="col-lg-6 g-mb-30">
<cfif !announcements.recordcount>
  <cfset newsClass = "col-lg-12 g-mb-30 text-center">
</cfif>

<section class="g-py-100" id="news">
  <div class="container">
    <header class="text-center g-width-60x--md mx-auto g-mb-50">
      <div class="u-heading-v2-3--bottom g-brd g-mb-20">
        <h1 class="h1 u-heading-v2__title g-color-gray-dark-v2 g-font-weight-600 text-uppercase">LATEST NEWS</h1>
      </div>
    </header>

    <cfoutput>
  	<div class="row">
    
    <cfif announcements.recordcount>
      <div class="#newsClass#">
      <!-- Article -->
        <article>
          #includePartial(partial="announcements")#
        </article>
      <!-- End Article -->
      </div>
    </cfif>  

      <div class="#newsClass#">
      <!-- Article -->
        <article>
          #includePartial(partial="twitterfeed")#
        </article>
      <!-- End Article -->
      </div>
    
    </div>
    </cfoutput>      

	</div>
	  </section>
                
