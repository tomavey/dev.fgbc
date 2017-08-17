var focusServices = angular.module('focusServices',[]);

    focusServices.factory('messages', function($http){
        return {
          list: function (callback){
            $http({
              method: 'GET',
              url: '/index.cfm/admin.sendemails/json',
              cache: true
            }).success(callback)
          }
          }
      })
