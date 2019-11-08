var app = angular.module('handbook', ['ionic', 'handbook.controllers', 'handbook.services', 'handbook.filters','ngTouch']);

app.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if (window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
      cordova.plugins.Keyboard.disableScroll(true);

    }
    if (window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleLightContent();
    }
  });
});

app.config(function($stateProvider, $urlRouterProvider) {

  // Ionic uses AngularUI Router which uses the concept of states
  // Learn more here: https://github.com/angular-ui/ui-router
  // Set up the various states which the app can be in.
  // Each state's controller can be found in controllers.js
  $stateProvider

  // setup an abstract state for the tabs directive
    .state('tab', {
    url: '/tab',
    abstract: true,
    templateUrl: 'templates/tabs.html'
  })
  .state('tab.staff', {
    url: '/staff',
    views: {
      'tab-staff': {
        templateUrl: 'templates/tab-staff.html',
        controller: 'StaffController'
      }
    }
  })
  .state('tab.staff-detail', {
    url: '/staff/:id',
    views: {
      'tab-staff': {
        templateUrl: 'templates/tab-staff-detail.html',
        controller: 'StaffDetailController'
      }
    }
  })
  .state('tab.churches', {
      url: '/churches',
      views: {
        'tab-churches': {
          templateUrl: 'templates/tab-churches.html',
          controller: 'ChurchesController'
        }
      }
    })
  .state('tab.church-detail', {
    url: '/churches/:id',
    views: {
      'tab-churches': {
        templateUrl: 'templates/tab-church-detail.html',
        controller: 'ChurchDetailController'
      }
    }
  })
  .state('tab.ministries', {
    url: '/ministries',
    views: {
      'tab-ministries': {
        templateUrl: 'templates/tab-ministries.html',
        controller: 'MinistriesController'
      }
    }
  })
  .state('staff-detail', {
    url: '/staff/:id',
    templateUrl: 'templates/tab-staff-detail.html',
    controller: 'StaffDetailController'
  })
  .state('staff', {
    url: '/staff',
    templateUrl: 'templates/tab-staff.html',
    controller: 'StaffController'
  })
  .state('login', {
    url: '/login',
    templateUrl: 'templates/login.html',
    controller: 'LoginController'
  })
  .state('logout', {
    url: '/logout',
    templateUrl: 'templates/login.html',
    controller: 'LogoutController'
  })

  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/login');

});
