var sendEmailsServices = angular.module('sendEmailsServices',[]);

    sendEmailsServices.factory('messages', function($http){
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
