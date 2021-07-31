<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, width=device-width">
    <title></title>

    <link href="img/apple-touch-icon.png" rel="apple-touch-icon" />
    <link href="img/apple-touch-icon-76x76.png" rel="apple-touch-icon" sizes="76x76" />
    <link href="img/apple-touch-icon-120x120.png" rel="apple-touch-icon" sizes="120x120" />
    <link href="img/apple-touch-icon-152x152.png" rel="apple-touch-icon" sizes="152x152" />
    <link href="img/apple-touch-icon-180x180.png" rel="apple-touch-icon" sizes="180x180" />
    <link href="img/icon-hires.png" rel="icon" sizes="192x192" />
    <link href="img/icon-normal.png" rel="icon" sizes="128x128" />
    <link rel="SHORTCUT ICON" href="/img/favicon.ico">
    <link href="lib/ionic/css/ionic.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

    <!-- IF using Sass (run gulp sass first), then uncomment below and remove the CSS includes above
    <link href="css/ionic.app.css" rel="stylesheet">
    -->

    <!-- ionic/angularjs js -->
    <script src="lib/ionic/js/ionic.bundle.js"></script>

    <!-- cordova script (this will be a 404 during development) -->
    <script src="cordova.js"></script>

    <!-- your app's js -->
    <script src="/javascripts/angular-touch.min.js"></script>
    <script src="js/app.js"></script>
    <script src="js/controllers.js"></script>
    <script src="js/services.js"></script>
    <script src="js/filters.js"></script>

  </head>
  <body ng-app="handbook">
    <ion-side-menus enable-menu-with-back-views="true">
    <ion-side-menu-content>
      <ion-nav-bar class="bar-positive">
        <ion-nav-buttons side="left">
          <button menu-toggle="left" class="button button-outline button-icon button-clear ion-navicon">Menu
          </button>
        </ion-nav-buttons>
        <ion-nav-buttons side="right">
          <button ui-sref="home" class="button button-icon button-clear ion-home">
          </button>
        </ion-nav-buttons>
        <ion-nav-back-button></ion-nav-back-button>
      </ion-nav-bar>
      <ion-nav-view></ion-nav-view>
      </ion-side-menu-content>
        <ion-side-menu slide="left">
          <ion-header-bar class="bar-stable">
            <h1 class="title">Menu</h1>
          </ion-header-bar>
          <ion-content>
            <ion-list>
              <ion-item menu-close href="#/tab/churches" class="border1">Churches</ion-item>
              <ion-item menu-close href="#/tab/staff" class="border1">Staff</ion-item>
              <ion-item menu-close href="#/login/" class="border2">Login</ion-item>
              <ion-item menu-close href="#/logout/" class="border2">Logout</ion-item>
            </ion-list>
          </ion-content>
        </ion-side-menu>
      </ion-side-menus>
  </body>
</html>
