<cfoutput>

  <!-- JS Global Compulsory -->
  <cfset folder = "/assets/vendor">

    #javaScriptIncludeTag("
        #folder#/jquery/jquery.min,
        #folder#/jquery-migrate/jquery-migrate.min,
        #folder#/jquery.easing/js/jquery.easing,
        #folder#/jquery-ujs/jquery-ujs,
        #folder#/popper.min,
        #folder#/bootstrap/bootstrap.min
    ")#

  <!-- JS Implementing Plugins -->

    #javaScriptIncludeTag("
        #folder#/slick-carousel/slick/slick,
        #folder#/hs-megamenu/src/hs.megamenu,
        #folder#/dzsparallaxer/dzsparallaxer,
        #folder#/dzsparallaxer/dzsscroller/scroller,
        #folder#/dzsparallaxer/advancedscroller/plugin,
        #folder#/cubeportfolio-full/cubeportfolio/js/jquery.cubeportfolio.min,
        #folder#/hs-bg-video/hs-bg-video,
        #folder#/hs-bg-video/vendor/player.min,
        #folder#/fancybox/jquery.fancybox.min,
        #folder#/typedjs/typed.min,
        #folder#/custombox/custombox.min
    ")#

  <!-- JS Unify -->
    <cfset folder = "/assets/js">
    #javaScriptIncludeTag("
      #folder#/hs.core.js,
      #folder#/components/hs.carousel,
      #folder#/components/hs.header,
      #folder#/helpers/hs.hamburgers,
      #folder#/components/hs.tabs,
      #folder#/components/hs.cubeportfolio,
      #folder#/helpers/hs.bg-video,
      #folder#/components/hs.popup,
      #folder#/components/hs.modal-window,
      #folder#/components/text-animation/hs.text-slideshow,
      #folder#/components/hs.go-to,
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

        // initialization of video on background
        $.HSCore.helpers.HSBgVideo.init('.js-bg-video');

        // initialization of popups
        $.HSCore.components.HSPopup.init('.js-fancybox');

        // initialization of go to
        $.HSCore.components.HSGoTo.init('.js-go-to');

        // initialization of popups
        $.HSCore.components.HSModalWindow.init('[data-modal-target]');

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


