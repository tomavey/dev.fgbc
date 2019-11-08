<!DOCTYPE html>
<html lang="en" ng-app="handbookApp">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">
    <title>FGBC - Handy</title>

    <link href="img/apple-touch-icon.png" rel="apple-touch-icon" />
    <link href="img/apple-touch-icon-76x76.png" rel="apple-touch-icon" sizes="76x76" />
    <link href="img/apple-touch-icon-120x120.png" rel="apple-touch-icon" sizes="120x120" />
    <link href="img/apple-touch-icon-152x152.png" rel="apple-touch-icon" sizes="152x152" />
    <link href="img/apple-touch-icon-180x180.png" rel="apple-touch-icon" sizes="180x180" />
    <link href="img/icon-hires.png" rel="icon" sizes="192x192" />
    <link href="img/icon-normal.png" rel="icon" sizes="128x128" />
    <link rel="SHORTCUT ICON" href="/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/stylesheets/bootstrap-3.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/stylesheets/bootstrap-3.3.2/css/bootstrap-theme.min.css">
    <link rel="stylesheet" type="text/css" href="/stylesheets/loading-bar.css">
    <link rel="stylesheet" type="text/css" href="/stylesheets/angular-aside.min.css">
    <link rel="stylesheet" type="text/css" href="/stylesheets/handy.css">

  </head>

  <body>

    <div ng-include="'login/navbar.html'">
    </div>

    <div ng-view class="container-fluid">
    </div>
    <script src="/javascripts/jquery.min.js"></script>
    <script src="/javascripts/bootstrap-3.3.2/js/bootstrap.min.js"></script>

    <script src="/javascripts/angular.min.js"></script>
    <script src="/javascripts/angular-route.min.js"></script>
    <script src="/javascripts/angular-cookies.min.js"></script>
    <script src="/javascripts/angular-animate.min.js"></script>
    <script src="/javascripts/angular-touch.min.js"></script>
    <script src="/javascripts/loading-bar.js"></script>
    <script src="/javascripts/angular-aside.min.js"></script>
    <script src="/javascripts/ui-bootstrap-tpls-0.12.1.min.js"></script>

    <script src="js/handbookApp.js"></script>
    <script src="js/handbookControllers.js"></script>
    <script src="js/handbookServices.js"></script>
    <script src="js/handbookFilters.js"></script>


  </body>



</html>