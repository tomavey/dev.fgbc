/*Contains Services for staff, churches, ministries, abgm and login*/
/*Plus a constants service for settins at the bottom*/

var handbookServices = angular.module('handbookServices',[]);

/*Factory for staff lookup*/

    handbookServices.factory('staff', function($http,settings){
        return {
          list: function (callback){
            $http({
              method: 'GET',
              url: settings.listApi('staff'),
              cache: true
            }).success(callback)
          },
          find: function(id, callback){
            $http({
              method: 'GET',
              url: settings.findApi(id,'staff'),
              cache: true
            }).success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });;
          }
        };
      });

/*Factory for church lookup*/

    handbookServices.factory('churches', function($http,settings){
        return {
          list: function (callback){
            $http({
              method: 'GET',
              url: settings.listApi('churches'),
              cache: true
            }).success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });;
          },
          find: function(id, callback){
            $http({
              method: 'GET',
              url: settings.findApi(id,'church'),
              cache: true
            }).success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });;
          }
        };
      });

/*Factory for ministries lookup*/
/*uses Church factory for ministry detail*/

    handbookServices.factory('ministries', function($http,settings){
        return {
          list: function (callback){
            $http({
              method: 'GET',
              url: settings.listApi('ministries'),
              cache: true
            }).success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });;
          },
        };
      });

/*Factory for AGBM lookup*/

    handbookServices.factory('agbm', function($http,settings){
        return {
          list: function (callback){
            $http({
              method: 'GET',
              url: settings.listApi('agbmregions'),
              cache: true
            }).success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });;
          },
          regionmembers: function(id, callback){
            $http({
              method: 'GET',
              url: settings.findApi(id,'agbmregions'),
              cache: true
            }).success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });;
          },
          allmembers: function(callback){
            $http({
              method: 'GET',
              url: settings.listApi('agbmmembers'),
              cache: true
            }).success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });;
          },
          rep: function(id, callback){
            $http({
              method: 'GET',
              url: settings.findApi(id,'agbmrep'),
              cache: true
            }).success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });;
          }
        };
      });


/*Factory for login lookup*/

    handbookServices.factory('login', function($http){
        var user = angular.fromJson(window.localStorage['user'] || '[]');
        return {
          login: function (credentials, callback){
            $http({
              method: 'GET',
              url: '/index.cfm/auth.users/handylogin/?email='+credentials.email
            }).success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });
          },

          logout: function(){
            $http({
              method: 'GET',
              url:'/index.cfm/auth.users/handyLogout/'
            });
          },

          getsessionauth: function(callback){
            $http({
              method: 'GET',
              url: '/index.cfm/auth.users/handysessionauth/',
              cache: true
            }).success(callback)
            .error(function(data,status){
              console.log(data);
              console.log(status)
            });
          },
          setCookie: function setCookie(cname, cvalue) {
            var d = new Date();
            d.setTime(d.getTime() + (30*24*60*60*1000));
            var expires = "expires="+d.toUTCString();
            document.cookie = cname + "=" + cvalue + "; " + expires;
          },
          saveUser: function(user){
               window.localStorage['user'] = angular.toJson(user);
          },
          getUser: function(){
            return user;
          }
        };
      });

  handbookServices.constant('settings',{
        listApi:function(action){
            var user = angular.fromJson(window.localStorage['user'] || '[]');
            if(user.email) {
            return '/index.cfm/api/' + action + '/' +'?email=' +user.email;
          }
            else
          {
            return '/index.cfm/api/' + action + '/';
          }
    },
        findApi: function(id,action){
            var user = angular.fromJson(window.localStorage['user'] || '[]');
            if(user.email) {
            return '/index.cfm/api/' + action + '/' + id +'?email=' +user.email;
          }
            else
          {
            return '/index.cfm/api/' + action + '/' + id;
          }

        },

  });