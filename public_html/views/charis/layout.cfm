<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Title -->
  <title>Home Default | Unify - Responsive Website Template</title>

  <!-- Required Meta Tags Always Come First -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">

  <!-- Favicon -->
  <link rel="shortcut icon" href="../../favicon.ico">
  <!-- Google Fonts -->
  <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans%3A400%2C300%2C500%2C600%2C700%7CPlayfair+Display%7CRoboto%7CRaleway%7CSpectral%7CRubik">
<cfoutput>



  <!-- CSS Global Compulsory -->
  <cfset folder = "charis/vendor/">
  #styleSheetLinkTag("#folder#bootstrap/bootstrap.min")#

  <!-- CSS Global Icons -->
  #styleSheetLinkTag("
        #folder#icon-awesome/css/font-awesome.min,
        #folder#icon-line/css/simple-line-icons,
        #folder#icon-etlinefont/style,
        #folder#icon-line-pro/style,
        #folder#icon-hs/style,
        #folder#dzsparallaxer/dzsparallaxer,
        #folder#dzsparallaxer/dzsscroller/scroller,
        #folder#dzsparallaxer/advancedscroller/plugin,
        #folder#animate,
        #folder#fancybox/jquery.fancybox.min,
        #folder#slick-carousel/slick/slick,
        #folder#typedjs/typed,
        #folder#hs-megamenu/src/hs.megamenu,
        #folder#hamburgers/hamburgers.min
      ")#

  <!-- CSS Unify -->

  <cfset folder = "charis/">
  #styleSheetLinkTag("
        #folder#unify-core,
        #folder#unify-components,
        #folder#unify-globals,
        #folder#custom
  ")#

</cfoutput>  

</head>

<body>
  <main>


 <cfoutput>#contentForLayout()#</cfoutput>
   
  </main>

  <div class="u-outer-spaces-helper"></div>

<cfoutput>

  <!-- JS Global Compulsory -->
  <cfset folder = "charis/vendor">

    #javaScriptIncludeTag("
        #folder#/jquery/jquery.min.js,
        #folder#/jquery-migrate/jquery-migrate.min.js,
        #folder#/jquery.easing/js/jquery.easing.js,
        #folder#/popper.min.js,
        #folder#/bootstrap/bootstrap.min.js
    ")#

  <!-- JS Implementing Plugins -->
  <cfset folder = "charis/vendor">

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
  <cfset folder = "charis">
  #javaScriptIncludeTag("
    #folder#/hs.core.js,
    #folder#/components/hs.carousel.js,
    #folder#/components/hs.header.js,
    #folder#/helpers/hs.hamburgers.js,
    #folder#/components/hs.tabs.js,
    #folder#/components/hs.popup.js,
    #folder#/components/text-animation/hs.text-slideshow.js,
    #folder#/components/hs.go-to.js
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







</body>

</html>