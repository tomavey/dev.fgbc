var lodgingRequestsServices = angular.module('lodgingRequestsServices',[]);

    var dbConnectUrl = "https://vivid-torch-5264.firebaseio.com/"

    lodgingRequestsServices.factory("lodgingRequests", ["$firebaseArray","$firebaseObject",
      function($firebaseArray,$firebaseObject) {
        // create a reference to the database location where we will store our data
        var databasename = "lodgingrequests";
        var ref = new Firebase(dbConnectUrl + databasename);

        // this uses AngularFire to create the synchronized array
        return {
          list: function() {return $firebaseArray(ref);},
          find: function(id) {
            console.log(id);
            var ref = new Firebase(dbConnectUrl + databasename + "/" + id);
            console.log($firebaseObject(ref));
            return $firebaseObject(ref);
          },
          add: function (lodgingrequest,callback){
            var id = $firebaseArray(ref).$add(lodgingrequest,callback).then(function(ref){
              var id = ref.key();
              console.log("added record with id " + id);
              callback(id);
            });
          },
          save: function (lodgingrequest) {
            lodgingrequest.$save()
          },
          remove: function (lodgingrequest,id) {
            alert(id);
            lodgingrequest.$remove(id)
          }
        };
      }
    ]);

  lodgingRequestsServices.factory('questions', function($http){
        return {
          list: function (callback){
            $http({
              method: 'GET',
              url: "/index.cfm/conference.lodgingrequests/questions",
              cache: true
            }).success(callback)
          }
        };
      });

  lodgingRequestsServices.factory("queryString",function(){
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