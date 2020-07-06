var handbookControllers = angular.module('handbookControllers', []);

/*controllers for churches*/

  handbookControllers.controller('ChurchListCtrl', function ($scope, churches){
        churches.list(function(churches){
          $scope.churches = churches;
          window.localStorage['churches'] = angular.toJson(churches);
          $scope.churches2 = window.localStorage['churches'];
        });
      $scope.sortField = 'selectname';
      $scope.reverse = false;
      $scope.defaultLimit = 40;
      $scope.more = 40;
      $scope.showall = 100000;
      $scope.limit = $scope.defaultLimit;
      $scope.showmore = function(){
         $scope.limit = $scope.limit + $scope.more;
      };
      $scope.showing = function(){
        if (churches.filter(query).length < $scope.limit)
          {return $scope.limit;}
        else
          {return churches.filter(query).length;}
      };
      $scope.querythis = function(querythis){
        $scope.query = querythis;
      };
      });

      handbookControllers.controller('ChurchDetailCtrl', function ($scope, $routeParams, churches){
        churches.find($routeParams.id,function(data){
            $scope.staff = data;
            $scope.org=$scope.staff[0];
            console.log($scope.staff);
        });
      });

/*Controller for ministries*/

      handbookControllers.controller('MinistryListCtrl', function ($scope, ministries){
        ministries.list(function(ministries){
          $scope.ministries = ministries;
        });
      $scope.sortField = 'name';
      $scope.reverse = false;
      $scope.querythis = function(querythis){
        $scope.query = querythis;
      };
      });

/*controllers for staff*/

      handbookControllers.controller('StaffListCtrl', function ($scope, staff){
        staff.list(function(staff){
          $scope.staff = staff;
        });
      $scope.sortField = 'selectname';
      $scope.reverse = false;
      $scope.defaultLimit = 100;
      $scope.showall = 100000;
      $scope.limit = $scope.defaultLimit;
      $scope.more = $scope.defaultLimit;
      $scope.showmore = function(){
         $scope.limit = $scope.limit + $scope.more;
      };

      $scope.showing = function(){
        if (organizations.filter(query).length < $scope.limit)
          {return $scope.limit;}
        else
          {return organizations.filter(query).length;}
      };
      $scope.querythis = function(querythis){
        $scope.query = querythis;
      };
      });

      handbookControllers.controller('StaffDetailCtrl', function ($scope, $routeParams, staff){
        staff.find($routeParams.staffid,function(data){
          $scope.positions = data;
          $scope.staff = $scope.positions[0];
          console.log($scope.positions);
        });

      });

/*controllers for AGBM Regions*/

      handbookControllers.controller('AgbmRegionListCtrl', function ($scope, agbm){
        agbm.list(function(agbmregions){
          $scope.agbmregions = agbmregions;
        });
      $scope.sortField = 'selectname';
      $scope.reverse = false;
      $scope.defaultLimit = 10;
      $scope.showall = 100000;
      $scope.limit = $scope.defaultLimit;
      $scope.showing = function(){
        if (agbmregions.filter(query).length < $scope.limit)
          {return $scope.limit;}
        else
          {return agbmregions.filter(query).length;}
      };
      $scope.querythis = function(querythis){
        $scope.query = querythis;
      };
      });

      handbookControllers.controller('AgbmMemListCtrl', function ($scope, $routeParams, agbm){
        agbm.regionmembers($routeParams.id,function(members){
          $scope.members = members;
          $scope.rep = members[0];
          console.log($scope.members);
        });
      });

      handbookControllers.controller('AgbmAllMemListCtrl', function ($scope, agbm){
        agbm.allmembers(function(members){
          $scope.sortField = 'lname';
          $scope.showchevronmem = true;
          $scope.showchevronrep = false;
          $scope.reverse = false;
          $scope.members = members;
          $scope.defaultLimit = 50;
          $scope.limit = $scope.defaultLimit;
          $scope.more = $scope.defaultLimit;
          $scope.showmore = function(){
             $scope.limit = $scope.limit + $scope.more;
          };
          console.log($scope.members);
        });
      });

  /*Controllers for login and menus*/

handbookControllers.controller('LoginCtrl', function($scope,login,$rootScope,$location) {
  $scope.credentials = {};
  $scope.credentials.email = login.getUser().email || "";
  console.log($scope.credentials);
  login.login($scope.credentials,function(data){
    if (angular.isObject(data)){
        console.log(data);
        $scope.auth = data[0];
        $rootScope.authenticate = true;
         $location.path("/staff");
    }
  });
  $scope.login = function (){
              login.login($scope.credentials,function(data){
                if (angular.isObject(data)) {
                  $scope.auth = data[0];
                  $rootScope.authenticate = true;
                  login.setCookie("handyemail",$scope.auth.email);
                  login.saveUser($scope.auth);
                 $location.path("/staff");
                  }
                else
                  {$rootScope.authenticate = false;
                  $rootScope.error = $scope.credentials.email + " is not an authorized email address.";
                  console.log($rootScope.error);
                  console.log($rootScope.error.length);
                  alert("NOT Logged In. Try again with an authorized email address.")
                  }
                })
              };
});

handbookControllers.controller('LogoutCtrl',function($scope,login,$rootScope,$location){
  login.logout();
  window.localStorage.removeItem('user');
  $location.path("/login");
});

    handbookControllers.controller('HeaderController', function($scope, $aside, $location) {
      $scope.isActive = function (viewLocation) {
            return viewLocation === $location.path();
        };

      $scope.openAside = function(position) {
        $aside.open({
          templateUrl: 'login/aside.html',
          placement: position,
          size: 'sm',
          backdrop: false,
          controller: function($scope, $modalInstance) {
            $scope.ok = function(e) {
              $modalInstance.close();
              e.stopPropagation();
            };
            $scope.cancel = function(e) {
              $modalInstance.dismiss();
              e.stopPropagation();
            };
          }
        })
    }
  });