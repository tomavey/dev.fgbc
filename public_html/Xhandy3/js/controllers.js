var handbookController = angular.module('handbook.controllers', []);

handbookController.controller('StaffController', function($scope,staff,$ionicLoading) {
  console.log("Staff Controller starts");
   $ionicLoading.show({
    content: 'Loading',
    animation: 'fade-in',
    showBackdrop: true,
    maxWidth: 200,
    showDelay: 0
  });
  staff.list(function(staff){
    $scope.staff = staff;
    console.log("Staff Loaded");
    $ionicLoading.hide();
  });
  $scope.sortField = "selectname";
  $scope.defaultLimit = 100;
  $scope.limit = $scope.defaultLimit;
  $scope.more = $scope.defaultLimit;
  $scope.showmore = function(){
     $scope.limit = $scope.limit + $scope.more;
  };
});

handbookController.controller("StaffDetailController",function($scope,staff,$ionicLoading,$stateParams){
   $ionicLoading.show({
    content: 'Loading',
    animation: 'fade-in',
    showBackdrop: true,
    maxWidth: 200,
    showDelay: 0
  });
   staff.find($stateParams.id,function(staff){
    $scope.positions = staff;
    $scope.staff = staff[0]
    console.log($scope.staff);
    $ionicLoading.hide();
   });
});

handbookController.controller('ChurchesController', function($scope,churches,$ionicLoading) {
  console.log("Churces Controller starts");
   $ionicLoading.show({
    content: 'Loading Churches',
    animation: 'fade-in',
    showBackdrop: true,
    maxWidth: 200,
    showDelay: 0
  });
  churches.list(function(churches){
    $scope.churches = churches;
    console.log("Churches Loaded");
    $ionicLoading.hide();
  });
  $scope.sortField = "selectname";
  $scope.defaultLimit = 50;
  $scope.limit = $scope.defaultLimit;
  $scope.more = $scope.defaultLimit;
  $scope.showmore = function(){
     $scope.limit = $scope.limit + $scope.more;
  };
});

handbookController.controller("ChurchDetailController",function($scope,churches,$ionicLoading,$stateParams){
   $ionicLoading.show({
    content: 'Loading',
    animation: 'fade-in',
    showBackdrop: true,
    maxWidth: 200,
    showDelay: 0
  });
   churches.find($stateParams.id,function(churches){
    $scope.staff = churches;
    $scope.church = churches[0]
    console.log($scope.staff);
    console.log($scope.church);
    $ionicLoading.hide();
   })
});

handbookController.controller('MinistriesController', function($scope) {
  $scope.welcome = "Ministries Page";
});

handbookController.controller('LoginController', function($scope,login,$rootScope,$state) {
  $scope.credentials = {};
  $scope.credentials.email = login.getUser().email || "";
  console.log($scope.credentials);
  login.login($scope.credentials,function(data){
    if (angular.isObject(data)){
        console.log(data);
        $scope.auth = data[0];
        $rootScope.authenticate = true;
        $state.go("tab.staff");
    }
  });
  $scope.login = function (){
              login.login($scope.credentials,function(data){
                if (angular.isObject(data)) {
                  $scope.auth = data[0];
                  $rootScope.authenticate = true;
                  login.setCookie("handyemail",$scope.auth.email);
                  login.saveUser($scope.auth);
                  $state.go("tab.staff");
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

handbookController.controller('LogoutController',function($scope,login,$rootScope,$state){
  login.logout();
  $state.go("login");
   window.localStorage.removeItem('user');
   console.log(localStorage);
})

