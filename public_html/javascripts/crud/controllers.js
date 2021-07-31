var crudControllers = angular.module('crudControllers', []);

  var goToIndex =  function () {
    window.open('/index.cfm/crud/index','_self');
  }

/*---------------------*/
/*indexController*/
/*---------------------*/
  crudControllers.controller('indexController', function ($scope,answers,mysql,dbtype){
    $scope.sortField = 'datetime';
    $scope.reverse = true;
    $scope.gotRights = function(rights){
      return true
    };

    /*Switch block to get all the answers - either from MYSQL or Firebase*/
    switch(dbtype) {
      case "firebase":
        $scope.answers = answers.list();
        break;
      case "mysql":
        mysql.list(function(data){
          $scope.answers = data;
          console.log(data);
        });
        break;
    }

    /*Switch block to remove an answer - either from MYSQL or Firebase*/
    $scope.removeAnswer = function(item) {
      switch(dbtype) {
        case "firebase":
          if (confirm("Are you sure?"))
            {
              $scope.answers.$remove(item);
            };
        case "mysql":
          if(confirm("Are you sure"))
          {
            mysql.remove(item,function(){
              var i = $scope.answers.indexOf(item);
              delete $scope.answers[i]; // this doesn't look right
            });
          }
      }
      }
  });


/*--------------------*/
/*showController*/
/*--------------------*/
  crudControllers.controller('showController', function ($scope,answers,content,mysql,dbtype,$stateParams){
    var $id=$stateParams.id;
    switch(dbtype){
      case "firebase":
        $scope.answer = answers.find($id);
      case "mysql":
        mysql.find($id,function(data){
          $scope.answer = data[0];
          console.log($scope.answer);
        })
    };
    content.list(function(data){
      $scope.questions = data.questions;
      console.log($scope.questions);
    });
  });

/*-------------------*/
/*newController*/
/*-------------------*/
  crudControllers.controller('newController', function ($scope,answers,content,mysql,dbtype,$stateParams,$state,$location){

   content.list(function(data){
    $scope.questions = data.questions;
     });


    $scope.editorOptions = {
          language: 'en',
          uiColor: '#FFFFFF',
          height: 150
      };

    if ($stateParams.id) {
      var $id=$stateParams.id;
      switch (dbtype){
        case "firebase":
          $scope.answer = answers.find($id);
          console.log("This answer = " + $scope.answer);
       case "mysql":
          mysql.find($id,function(data){
          $scope.answer = data[0]
          console.log("This answer = " + $scope.answer);
          })
        }
      }
      else
      {
        $scope.answer = {};
        console.log("Empty answer = " + $scope.answer);
      };

   $scope.addAnswer = function(){
      switch (dbtype){
        case "firebase":
          $scope.addAnswerFirebase();
          break;
        case "mysql":
          $scope.addAnswerToMySql();
          break;
          }
      };

   $scope.addAnswerFirebase = function() {
      if ($scope.answer.$id) {
        $scope.answer.updatedAt = new Date().getTime();
        answers.save($scope.answer);
        alert($scope.answer.$id + " has been updated");
        $state.go('index');
      }
      else
      {
        $scope.answer.date = new Date().toDateString();
        $scope.answer.time = new Date().toTimeString();
        $scope.answer.datetime = new Date().getTime();
        $scope.answer.updatedAt = new Date().getTime();
        console.log("before adding " + $scope.answers);
        answers.add($scope.answer,function(id){
          alert("A new record has been added to the database at id: " + id);
          $state.go('index');
        });
      }
    }

    $scope.addAnswerToMySql = function(){
      mysql.save($scope.answer,function(data){
        console.log(data);
        alert("Answer has been saved");
      });
      $location.path('index');
    }

  });

/*questionsController*/
  crudControllers.controller('questionsController',function($scope,content){
    content.list(function(data){
      $scope.questions=data.questions;
    });
  })

