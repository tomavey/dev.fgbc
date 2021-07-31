<head>
  <!-- Global site tag (gtag.js) - Google Analytics -->
  <script async src="https://www.googletagmanager.com/gtag/js?id=UA-77925750-2"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', 'UA-77925750-2');
  </script>

  <!-- Title -->
  <title>Charis Fellowship | Planting Churches - Training Leaders - Doing Good</title>

  <!-- Required Meta Tags Always Come First -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <meta property="fb:app_id" content="1771808052863201"/>
  <meta property="og:type" content="website" />
  <meta property="og:image" content="https://charisfellowship.us/assets/img/logo/PNGs/facebookog.png" />
  <meta property="og:url" content="https://charisfellowship.us" />
  <meta property="og:title" content="Charis Fellowship | Planting Churches - Training Leaders - Doing Good" />
  <meta property="og:description" content="Churches who value Truth, Relationship and Mission... Churches who start more churches, train leaders, and do good in their communities." />
  
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

  <!---Load Vue Early--->
  <cfset folder = "/assets/js">
    #javaScriptIncludeTag("
      #folder#/vue,
      #folder#/lodash.min,
      #folder#/axios.min
    ")#

  </cfoutput>  

</head>
