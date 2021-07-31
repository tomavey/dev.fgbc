var crudServices = angular.module('crudServices',[]);

    //connect url from firebase
    var dbConnectUrl = "https://vivid-torch-5264.firebaseio.com/";

    crudServices.factory("answers", ["$firebaseArray","$firebaseObject","dbname",
      function($firebaseArray,$firebaseObject,dbname) {

        // create a reference to the database location where we will store our data
        var ref = new Firebase(dbConnectUrl + dbname);

        // this uses AngularFire to create the synchronized array
        return {
          list: function() {return $firebaseArray(ref);},
          find: function(id) {
            console.log(id);
            var ref = new Firebase(dbConnectUrl + dbname + "/" + id);
            return $firebaseObject(ref);
          },
            add: function (data,callback){
            var id = $firebaseArray(ref).$add(data,callback).then(function(ref){
              var id = ref.key();
              console.log("added record with id " + id);
              callback(id);
            });
          },
          save: function(data){
            data.$save()
          },
          remove: function (data) {
            $remove(data);
          }
        };
      }
    ]);

  //get content from the json api
  crudServices.factory('content', function($http){
        return {
          list: function (callback){
            $http({
              method: 'GET',
              url: "/index.cfm/crud/content/",
              cache: true
            }).success(callback)
          }
        };
      });

  //used to find the id in the url query string
  crudServices.factory("queryString",function(){
      return {
        variable: function (variable)
              {
                     var query = window.location.search.substring(1);
                     var vars = query.split("&");
                     for (var i=0;i<vars.length;i++) {
                             var pair = vars[i].split("=");
                             if(pair[0] == variable){return pair[1];}
                     }
                     return(false);
              }
      }
    });

  crudServices.factory("mysql",function($http,mysqlConnectUrl){
    return {
      save: function(answer,callback){
        $http.post(mysqlConnectUrl,answer)
          .success(callback)
          .error(function(data,status){
            console.log(data);
            console.log(status);
          })
      },
      list: function(callback){
        $http.get(mysqlConnectUrl)
          .success(callback)
          .error(function(data,status){
            console.log(data);
            console.log(status);
         })
      },
      remove: function(item,callback){
        $http.delete(mysqlConnectUrl + item.id)
        .success(callback)
      },
      find: function(id,callback){
        $http({
          method:"GET",
          url: mysqlConnectUrl + id
        })
        .success(callback)
      }
    }
  })