var newMinistriesControllers = angular.module('newMinistriesControllers', []);

  var goToIndex =  function () {
    window.open('/index.cfm/membership.newministries/','_self');
  }

  newMinistriesControllers.controller('indexController', function ($scope,ministries){
    $scope.ministries = ministries.list();
    $scope.sortField = 'datetime';
    $scope.reverse = true;
    $scope.removeMinistry = function(ministry) {
      if (confirm("Are you sure?"))
      {
        $scope.ministries.$remove(ministry)
      };
      }
  });

  newMinistriesControllers.controller('showController', function ($scope,ministries,queryString,questions){
    $id=queryString.variable("id");
    ministries.find($id, function(data){
        $scope.ministry = data;
        console.log($scope.ministry);
      });
    questions.list(function(questions){
      $scope.questions = questions;
    });
    /*not working correctly*/
    $scope.eachquestion = function(question){
      var a = "<div class='eachquestion'><p>{{questions." + question + "}}</p><p>{{ministry." + question + "}}</p></div>"
      return a;
      };
  });

  newMinistriesControllers.controller('newController', function ($scope,ministries,queryString,questions){
  $scope.defaultRequiredLength = 20;
   questions.list(function(questions){
    $scope.questions = questions;
   });
  $scope.editorOptions = {
        language: 'en',
        uiColor: '#FFFFFF',
        height: 150
    };
   $scope.ministries = ministries.list();
   $id = queryString.variable("id");
    console.log($id);
    if ($id) {
      ministries.find($id, function(data){
        $scope.ministry = data;
        console.log($scope.ministry);
      });
    };
   $scope.showForm = function(ministry){
     if (!$id || ministry.updatedAt){return true;}
     else {return false;}
   }; 
   $scope.addMinistry = function() {
      // calling $add on a synchronized array is like Array.push(),
      // except that it saves the changes to our database!
      if ($scope.ministry.$id) {
        $scope.ministry.updatedAt = new Date().getTime();
        ministries.save($scope.ministry);
        alert($scope.ministry.name + " has been updated");
          window.open('/index.cfm/membership.newministries/email?id='+$scope.ministry.$id+'&email='+$scope.ministry.contactemail+'&name='+$scope.ministry.name,'_self');
        $scope.message = "A ministry has been updated";
        window.open('/index.cfm/membership.newministries/email?id='+$scope.ministry.$id+'&email='+$scope.ministry.contactemail+'&name='+$scope.ministry.name,'_self');
      }
      else
      {
        $scope.ministry.date = new Date().toDateString();
        $scope.ministry.time = new Date().toTimeString();
        $scope.ministry.datetime = new Date().getTime();
        $scope.ministry.updatedAt = new Date().getTime();
        ministries.add($scope.ministry,function(id){
          alert("A new ministry has been added to the database at id: " + id);
          window.open('/index.cfm/membership.newministries/email?id='+id+'&email='+$scope.ministry.contactemail+'&name='+$scope.ministry.name,'_self');
        });
      }
    };
  });

