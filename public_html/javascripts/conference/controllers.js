var accessControllers = angular.module('accessControllers',[]);

accessControllers.controller('featuresController', function($scope){
    alert("features");
    $scope.welcome = "Howdi!";
})

accessControllers.controller('contactMessageController', function($scope,contactMessages){
    alert("works");
    $scope.contactFormMessage = "Any questions? Drop us a note";
    $scope.addContactMessage = function(){
        contactMessages.submit($scope.contact, function(data){
            console.log(data);
            if (data == "TRUE" ) {
                $scope.contactFormMessage = "Your message has been sent"
                }
                else if (data = "INVALID"){
                $scope.contactFormMessage = "Please provide a valid email address."
                };
        })
    }
});

accessControllers.controller('subscribeController', function($scope,subscriptions){
    $scope.message = "Subscribe to receive updates";
    $scope.addSubscriber = function(){
    console.log($scope.subscribe);
    $scope.subscribe.message = "";
    $scope.subscribe.name = "";
    subscriptions.submit($scope.subscribe,function(data){
        if (data === "TRUE") {
            $scope.message = $scope.subscribe.email + " has been subscribed.";
        }
        else if ( data === "DUPLICATE") {
            $scope.message = $scope.subscribe.email + " is already subscribed.";
        }
        else if ( data === "INVALID") {
            $scope.message = "Please enter a valid email address.";
        }
        else {
            $scope.message = $scope.subscribe.email + " has NOT been subscribed.";
        }
    });
    }
})

