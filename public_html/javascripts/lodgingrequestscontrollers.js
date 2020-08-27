var lodgingRequestsControllers = angular.module('lodgingRequestsControllers', []);

  var goToIndex =  function () {
    window.open('/index.cfm/conference.lodgingrequests/','_self');
  }

  lodgingRequestsControllers.controller('indexController', function ($scope,lodgingRequests){
    $scope.lodgingRequests = lodgingRequests.list();
    $scope.sortField = 'datetime';
    $scope.reverse = true;
    $scope.removeLodgingRequest = function(lodgingRequest) {
      if (confirm("Are you sure?"))
      {
        $scope.lodgingRequests.$remove(lodgingRequest)
      };
      }
  });

  lodgingRequestsControllers.controller('showController', function ($scope,lodgingRequests,queryString,questions){
    $id=queryString.variable("id");
    $scope.lodgingRequest = lodgingRequests.find($id);
    questions.list(function(questions){
      $scope.questions = questions;
    });

    $scope.eachquestion = function(question){
      var a = "<div class='eachquestion'><p>{{questions." + question + "}}</p><p>{{lodgingRequest." + question + "}}</p></div>"
      return a;
      };
  });

  lodgingRequestsControllers.controller('newController', function ($scope,lodgingRequests,queryString,questions){
   questions.list(function(questions){
    $scope.questions = questions;
   });
  $scope.editorOptions = {
        language: 'en',
        uiColor: '#FFFFFF',
        height: 150
    };
   $scope.lodgingRequests = lodgingRequests.list();
    var id = queryString.variable("id");
    console.log(id);
    if (id) {
      $scope.lodgingRequest = lodgingRequests.find(id);
      console.log($scope.lodgingRequest);
    };
   $scope.addLodgingRequest = function() {
      // calling $add on a synchronized array is like Array.push(),
      // except that it saves the changes to our database!
      if ($scope.lodgingRequest.$id) {
        $scope.lodgingRequest.updatedAt = new Date().getTime();
        lodgingRequests.save($scope.lodgingRequest);
        alert($scope.lodgingRequest.name + " has been updated");
        $scope.message = "A lodging request has been updated";
        goToIndex();
      }
      else
      {
        $scope.lodgingRequest.date = new Date().toDateString();
        $scope.lodgingRequest.time = new Date().toTimeString();
        $scope.lodgingRequest.datetime = new Date().getTime();
        $scope.lodgingRequest.updatedAt = new Date().getTime();
        lodgingRequests.add($scope.lodgingRequest,function(id){
          alert("A new lodging request  has been added to the database at id: " + id);
          window.open('/index.cfm/conference.lodgingrequests/email?id='+id+'&email='+$scope.lodgingRequest.email+'&name='+$scope.lodgingRequest.name,'_self');
        });
      }
    };
  });

  lodgingRequestsControllers.controller('ckeditorController', function($scope){
    $scope.welcome = "Hello";
    $scope.editorOptions = {
        language: 'en',
        uiColor: '#FFFFFF'
    };
})