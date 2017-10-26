<cfoutput>

  <!-- JS Global Compulsory -->
  <cfset folder = "/assets/vendor">

    #javaScriptIncludeTag("
        #folder#/jquery/jquery.min.js,
        #folder#/jquery-migrate/jquery-migrate.min.js,
        #folder#/jquery.easing/js/jquery.easing.js,
        #folder#/popper.min.js,
        #folder#/bootstrap/bootstrap.min.js
    ")#

  <!-- JS Implementing Plugins -->

    #javaScriptIncludeTag("
        #folder#/slick-carousel/slick/slick.js,
        #folder#/hs-megamenu/src/hs.megamenu.js,
        #folder#/dzsparallaxer/dzsparallaxer.js,
        #folder#/dzsparallaxer/dzsscroller/scroller.js,
        #folder#/dzsparallaxer/advancedscroller/plugin.js,
        #folder#/fancybox/jquery.fancybox.min.js,
        #folder#/typedjs/typed.min.js
    ")#

  <!-- JS Unify -->
    <cfset folder = "/assets/js">
    #javaScriptIncludeTag("
      #folder#/hs.core.js,
      #folder#/components/hs.carousel.js,
      #folder#/components/hs.header.js,
      #folder#/helpers/hs.hamburgers.js,
      #folder#/components/hs.tabs.js,
      #folder#/components/hs.popup.js,
      #folder#/components/text-animation/hs.text-slideshow.js,
      #folder#/components/hs.go-to.js,
      #folder#/vue.min,
      #folder#/app
    ")#

  <!-- JS Customization -->
  #javaScriptIncludeTag("#folder#/custom")#

</cfoutput>

  <!-- JS Plugins Init. -->
  <script>
    $(document).on('ready', function () {
        // initialization of carousel
        $.HSCore.components.HSCarousel.init('.js-carousel');

        // initialization of tabs
        $.HSCore.components.HSTabs.init('[role="tablist"]');

        // initialization of popups
        $.HSCore.components.HSPopup.init('.js-fancybox');

        // initialization of go to
        $.HSCore.components.HSGoTo.init('.js-go-to');

        // initialization of text animation (typing)
        $(".u-text-animation.u-text-animation--typing").typed({
          strings: [
            "an awesome template",
            "perfect template",
            "just like a boss"
          ],
          typeSpeed: 60,
          loop: true,
          backDelay: 1500
        });
      });

      $(window).on('load', function () {
        // initialization of header
        $.HSCore.components.HSHeader.init($('#js-header'));
        $.HSCore.helpers.HSHamburgers.init('.hamburger');

        // initialization of HSMegaMenu component
        $('.js-mega-menu').HSMegaMenu({
          event: 'hover',
          pageContainer: $('.container'),
          breakpoint: 991
        });
      });

      $(window).on('resize', function () {
        setTimeout(function () {
          $.HSCore.components.HSTabs.init('[role="tablist"]');
        }, 200);
      });
  </script>


