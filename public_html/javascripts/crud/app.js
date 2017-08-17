var crudApp = angular.module("crudApp",['crudServices','crudControllers','firebase','ngCkeditor','ngSanitize','720kb.tooltips','settings','ui.router']);

crudApp.config(function($stateProvider,$urlRouterProvider){

  $urlRouterProvider.otherwise("index");

  $stateProvider
    .state('index', {
      url: '/index',
      templateUrl: "/views/crud/partials/list.cfm"
    })
    .state('new',{
      url: '/new',
      templateUrl: "/views/crud/partials/new.cfm"
    })
    .state('show',{
      url: '/show/:id',
      templateUrl: "/views/crud/partials/show.cfm"
    })
    .state('edit',{
      url: '/edit/:id',
      templateUrl: "/views/crud/partials/new.cfm"
    })


})

//a test input field directive - for use later
crudApp.directive('inputField', function() {
  return {
    restrict: "E",
    scope: {
        answerkey: '=',
        placeholder: '='
    },
    template: '{{answerkey}} - {{placeholder}}'
  };
});

//a test generic directive - for use later
crudApp.directive('myDirective', function(){
  return {
    restrict: 'E',
    template: '<input ng-model="{{answerkey}}" type="text" placeholder="{{placeholder}}" /> {{placeholder}}',
    scope: {
      answerkey: '=',
      placeholder: '='
    }
  }
});

