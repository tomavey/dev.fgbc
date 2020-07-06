var newMinistriesServices = angular.module('newMinistriesServices',[]);

    var dbConnectUrl = "https://vivid-torch-5264.firebaseio.com/"

    newMinistriesServices.factory("ministries", ["$firebaseArray","$firebaseObject",
      function($firebaseArray,$firebaseObject) {
        // create a reference to the database location where we will store our data
        var databasename = "ministries";
        var ref = new Firebase(dbConnectUrl + databasename);

        // this uses AngularFire to create the synchronized array
        return {
          list: function() {return $firebaseArray(ref);},
          find: function(id,callback) {
            var ref = new Firebase(dbConnectUrl + databasename + "/" + id);
            setTimeout(callback($firebaseObject(ref)), 2000);
            console.log($firebaseObject(ref));
          },
          add: function (ministry,callback){
            var id = $firebaseArray(ref).$add(ministry,callback).then(function(ref){
              var id = ref.key();
              console.log("added record with id " + id);
              callback(id);
            });
          },
          save: function (ministry) {
            ministry.$save()
          },
          remove: function (ministries,id) {
            alert(id);
            ministries.$remove(id)
          }
        };
      }
    ]);

  newMinistriesServices.factory('questions', function($http){
        return {
          list: function (callback){
            $http({
              method: 'GET',
              url: "/index.cfm/membership.newministries/questions",
              cache: true
            }).success(callback)
          }
        };
      });

  newMinistriesServices.factory("queryString",function(){
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