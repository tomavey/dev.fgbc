var sendEmailsControllers = angular.module('sendEmailsControllers', []);

  sendEmailsControllers.controller('indexController', function ($scope,messages,$filter){
    $scope.welcome = "Hello";
    messages.list(function(messages){
        $scope.messages = angular.fromJson(messages);
        $scope.testdate="11/11/2015"
    })
  });

  sendEmailsControllers.controller('formController', function ($scope){
    $scope.welcome = "Hello";
    $scope.show = false;
    console.log("formController is working");
    });
