var handbookControllers = angular.module('handbookControllers', []);

      handbookControllers.controller('OrgListCtrl', function ($scope, $http){
        $http({
            method: 'GET',
            url: 'http://localhost:8888/index.cfm/handbook.organizations/index/?format=json',
            cache: true
            }).success(function(data) {
          $scope.organizations = data;
        });
      $scope.sortField = 'state';
      $scope.reverse = true;

      });

      handbookControllers.controller('OrgDetailCtrl', function ($scope, $routeParams, $http){
        $http({
          method: 'GET',
          url: 'http://localhost:8888/index.cfm/handbook.organizations/index/?format=json',
          cache: true
          }).success(function(data){
          $scope.org = data.filter(function(entry){
            return entry.orgId === $scope.orgId;
          })[0];
        })
      });

