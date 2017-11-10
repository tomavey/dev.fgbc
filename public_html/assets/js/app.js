var vm = new Vue({
    el: "#churches1",
    data: {
        welcome: "Hello",
    },
    methods: {
        loadChurches: function(){
            var vm = this;
            this.$http.get('http://charisfellowship.us/api/churches')
            .then(function(response){
                vm.churches = response.data;
                console.log(response.data)
            }).
            catch(function(error){console.log(error)})
        },
    },
    created: function(){
        this.loadChurches();
    },
});


