var handbookServices=angular.module('handbook.services', []);

/*Factory for staff lookup*/

    handbookServices.factory('staff', function($http){
        var user = angular.fromJson(window.localStorage['user'] || '[]');
        var addUserEmail = function(url){
                if (user.email) {
                  return url + '?email=' + user.email
                }
                 else
                 {
                    return url
                 }
              };
        return {
          list: function (callback){
            $http({
              method: 'GET',
              url: addUserEmail('/index.cfm/api/staff/'),
              cache: true
            }).success(callback);
          },
          find: function(id, callback){
            $http({
              method: 'GET',
              url: addUserEmail('/index.cfm/api/staff/'+id),
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

    handbookServices.factory('churches', function($http){
        return {
          list: function (callback){
            $http({
              method: 'GET',
              url: '/index.cfm/api/churches',
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
              url: '/index.cfm/api/church/'+id,
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

