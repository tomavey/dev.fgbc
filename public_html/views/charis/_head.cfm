<head>
  <!-- Title -->
  <title>Home Default | Unify - Responsive Website Template</title>

  <!-- Required Meta Tags Always Come First -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">

  <!-- Favicon -->
  <link rel="shortcut icon" href="/assets/img/favicon2.ico">
  <!-- Google Fonts -->
  <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans%3A400%2C300%2C500%2C600%2C700%7CPlayfair+Display%7CRoboto%7CRaleway%7CSpectral%7CRubik">
<cfoutput>

  <!-- CSS Global Compulsory -->
  <cfset folder = "/assets/vendor">
  #styleSheetLinkTag("#folder#/bootstrap/bootstrap.min")#

  <!-- CSS Global Icons -->
  #styleSheetLinkTag("
        #folder#/icon-awesome/css/font-awesome.min,
        #folder#/icon-line/css/simple-line-icons,
        #folder#/icon-etlinefont/style,
        #folder#/icon-line-pro/style,
        #folder#/icon-hs/style,
        #folder#/dzsparallaxer/dzsparallaxer,
        #folder#/dzsparallaxer/dzsscroller/scroller,
        #folder#/dzsparallaxer/advancedscroller/plugin,
        #folder#/animate,
        #folder#/fancybox/jquery.fancybox.min,
        #folder#/slick-carousel/slick/slick,
        #folder#/typedjs/typed,
        #folder#/hs-megamenu/src/hs.megamenu,
        #folder#/hamburgers/hamburgers.min,
        #folder#/hs-bg-video/hs-bg-video
      ")#

  <!-- Implementing Pluggins -->

#styleSheetLinkTag("
      #folder#/custombox/custombox.min
")#
      

  <!-- CSS Unify -->

  <cfset folder = "/assets/css">
  #styleSheetLinkTag("
        #folder#/unify-core,
        #folder#/unify-components,
        #folder#/unify-globals,
        #folder#/custom
  ")#

</cfoutput>  

</head>
