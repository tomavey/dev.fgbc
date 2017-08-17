      var handbookApp = angular.module('handbookApp', ['ngRoute','angular-loading-bar','ngAnimate','handbookControllers','handbookServices','CustomFilterModule','ui.bootstrap','ngCookies', 'ngTouch', 'ngAside','handbookFilters']);

        handbookApp.config(function($routeProvider) {
        $routeProvider.
          when('/login/', {
            templateUrl: 'login/login.html',
            controller: 'LoginCtrl'
          }).
          when('/logout/', {
            template: '<h3>You are logged out</h3>',
            controller: 'LogoutCtrl'
          }).
          when('/', {
            templateUrl: 'login/login.html',
            controller: 'LoginCtrl'
          }).
          when('/churches/', {
            templateUrl: 'organizations/churchfind.html',
            controller: 'ChurchListCtrl'
          }).
          when('/churches/:id', {
            templateUrl: 'organizations/churchdetail.html',
            controller: 'ChurchDetailCtrl'
          }).
          when('/church/:id', {
            templateUrl: 'organizations/churchdetail.html',
            controller: 'ChurchDetailCtrl'
          }).
          when('/ministries/', {
            templateUrl: 'organizations/ministryfind.html',
            controller: 'MinistryListCtrl'
          }).
          when('/agbmregions/', {
            templateUrl: 'agbmregions/agbmregionsfind.html',
            controller: 'AgbmRegionListCtrl'
          }).
          when('/agbmmembers/', {
            templateUrl: 'agbmregions/agbmmemlist.html',
            controller: 'AgbmAllMemListCtrl'
          }).
          when('/agbmregion/:id', {
            templateUrl: 'agbmregions/agbmmemfind.html',
            controller: 'AgbmMemListCtrl'
          }).
          when('/staff/', {
            templateUrl: 'staff/stafffind.html',
            controller: 'StaffListCtrl'
          }).
          when('/staff/:staffid', {
            templateUrl: 'staff/staffdetail.html',
            controller: 'StaffDetailCtrl'
          }).
          otherwise({
            redirectTo: '/'
          });
      });

      handbookApp.directive('moreLink',function(){
        return {
          restrict: 'E',
          templateUrl: 'orglist_more.html'
        };
      });


    angular.module('CustomFilterModule', [])
    .filter( 'truncate', function() {
      return function( input ) {
      return input.substring(0,40)}
    });

