<cfoutput>
<section id="intro">
  <div class="container">
          <!-- slide 1 -->
          <div class="row jumbotron">
            <div class="span12 text-center">
              <cfif isDefined("introTitle")>
                  <h1>#introTitle#</h1>
              <cfelse>
                  <h1>Registration Center</h1>
                  <cfif !regIsOpen()>
                      <br/>
                      <h3 style="color:blue">Closed</h3>
                  </cfif>
              </cfif>
             </div>
            <!-- end span12 -->
          </div>
          <!-- end row -->
  </div>
  <!-- end container -->
</section>
<!-- end intro section -->
</cfoutput>