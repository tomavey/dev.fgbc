var accessServices = angular.module('accessServices',[])

        accessServices.factory('subscriptions', function($http,settings){
        var apiUrl = settings.apiHost() + "api/emaillist/";
        var apiUrlPost = settings.apiPostAnnounce();
        return {
          list: function (callback){
            $http({
              method: 'GET',
              url: apiUrl,
              cache: false
            }).success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });
          },
          find: function(id, callback){
            $http({
              method: 'GET',
              url: apiUrl+"?id=" + id,
            }).success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });
          },
          submit: function(subscription,callback){
            $http({
              method: 'POST',
              url: apiUrlPost,
              data: subscription,
            })
            .success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });
            console.log(subscription);
          }
        };
      });

   accessServices.factory("contactMessages",function($http,settings){
     var apiUrl = settings.apiHost() + "api/emaillist/";
     var apiUrlPost = settings.apiPostAnnounce();
    return{
          submit: function(subscription,callback){
            $http({
              method: 'POST',
              url: apiUrlPost,
              data: subscription,
            })
            .success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });
            console.log(subscription);
          }
        }
   })

accessServices.constant("settings",{
        apiHost : function(){
        if (location.hostname == "access:8888"){
          return "http://access:8888/api/emaillist";
        }
        else
        {
          return "http://access2017.com/";
        }
      },
      apiPostAnnounce: function(){
        if (location.host == "access:8888"){
          return "http://access:8888/api/emaillist/save/"
        }
        else
        {
          return "http://access2017.com/api/emaillist/save/"
        }
      },
})