      var handbookApp = angular.module('handbookApp', ['ngRoute','angular-loading-bar','ngAnimate','handbookControllers']);

        handbookApp.config(function($routeProvider) {
        $routeProvider.
          when('/', {
            templateUrl: 'orglist.html',
            controller: 'OrgListCtrl'
          }).
          when('/:orgId', {
            templateUrl: 'orgdetail.html',
            controller: 'OrgDetailCtrl'
          }).
          otherwise({
            redirectTo: '/'
          });
      });

