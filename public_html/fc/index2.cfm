<!DOCTYPE html>
<html lang="en">
  <head>

  <cfinclude  template="/events/functions.cfm">

    <cfscript>
      members = {};
      fc = createObject("component", "control");
      agenda = queryToJson(fc.get_content_fc(name="Agenda"));
      menuIds = fc.get_content_fc(selectString="id, name", asJson = true);
      members.all = fc.getstaffinfo(tag="fc", asJson = true);
      members.finance = fc.getstaffinfo(tag="fc_membership", asJson = true);
      members.structures = fc.getstaffinfo(tag="fc_structures", asJson = true);
      members.membership = fc.getstaffinfo(tag="fc_membership", asJson = true);
    </cfscript>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon -->
    <link rel="shortcut icon" href="/assets/img/favicon2.ico">
  
    <title>Fellowship Council</title>

    <!-- Bootstrap core CSS -->
    <link href="assets/vendors/bootstrap/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="assets/css/dashboard.css" rel="stylesheet">
  </head>

  <body>
  <div id="app">
    <nav class="navbar navbar-toggleable-md navbar-inverse fixed-top bg-inverse">
      <button class="navbar-toggler navbar-toggler-right hidden-lg-up" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <a class="navbar-brand" href="#">Fellowship Council</a>

      <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Agenda</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Minutes</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Commissions</a>
          </li>
        </ul>
        <form class="form-inline mt-2 mt-md-0 hidden">
          <input class="form-control mr-sm-2" type="text" placeholder="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <nav class="col-sm-3 col-md-2 bg-faded sidebar" :class="sideBarClass()">
          <ul class="nav nav-pills flex-column">
            <li v-for="item in menuItems" class="nav-item">
              <a class="nav-link" href="#">{{item.name}}</a>
            </li>
          </ul>
        </nav>

        <main class="col-sm-9 offset-sm-3 col-md-10 offset-md-2 pt-3" :class="mainClass()">
          <my-page></my-page>
          <h2 v-html="contents[0].name"></h2>
          <div v-cloak v-html="contents[0].paragraph"></div>
        </main>
      </div>
    </div>
    </div><!---id="app--->"

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="assets/vendors/vue/vue.js"></script>
    <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
    <script src="assets/vendors/bootstrap/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>

    <script src="/assets/js/axios.min.js"></script>
    <script src="/assets/js/vue-router.min.js"></script>
    <cfoutput>
    <script>

    var myComponent = {
      template: "<p>My Component {{greeting}}</p>",
      data : function(){
        return {
          greeting : "Helllllooooo",
        }
      }
    }  

    var myPage = {
      template: "<p v-html='thisPage'></p>",
      data: function(){
        return {
          thisPage: 'page',
        };
      },
    }

    var vm = new Vue({
        el: "##app",
        data: {
            message: "Working",
            menuItems: #menuIds#,
            contents: #agenda#,
            testArrayOfObjects: [
              {fname:"Tom", lname:"Avey", id:1},
              {fname:"Sandi", lname:"Avey", id:2},
              {fname:"Sandy", lname:"Barrett", id:3}
            ],
            testArray: ['apple','pear', 'orange'],
            pages: "",
            page: "",
        },
        components: {
          'my-component' : myComponent,
          'my-page': {
            props: ['page'],
            template: "<div><p v-html='componentPage.paragraph'></p><p>{{componentPage.name}}</p></div>",
            data: function(){
              return {
                componentPage: "page",
              };
            },
            methods: {
              loadComponentPage: function(id=0){
                this.componentPage="Loading page...";
                var vm = this;
                axios.get('/index.cfm?controller=fellowshipcouncil.Pages&action=index&key=' + id)
                .then(function( response ){
                  vm.componentPage=response.data[0];
                  console.log(response.data[0]);
                })
                .catch(function ( error ){
                  vm.componentPage = "An Error Happened";
                })
              },
            },
            created: function(){
              this.loadComponentPage(1);
            },
          },
        },
        methods: {
          mainClass: function(){
            return ""
          },
          sideBarClass: function(){
            return "hidden-xs-down"
          },
          circlesClass: function(){
            return ""
          },
          contentClass: function(){
            return ""
          },
          loadPages: function(){
            this.pages="Loading pages...";
            var vm = this;
            axios.get('/index.cfm?controller=fellowshipcouncil.Pages&action=index')
            .then(function( response ){
              vm.pages=response.data;
            })
            .catch(function ( error ){
              vm.pages = "An Error Happened";
            })
          },
          loadPage: function(id){
            this.page="Loading page...";
            var vm = this;
            axios.get('/index.cfm?controller=fellowshipcouncil.Pages&action=index&key=' + id)
            .then(function( response ){
              vm.page=response.data[0];
            })
            .catch(function ( error ){
              vm.page = "An Error Happened";
            })
          }
        },
        computed: {
          testArrayOfObjectsSorted: function(){
            return this.testArrayOfObjects.sort( 
              function(a,b){
                return a.fname > b.fname;
              }
            )
          },
          testArrayOfObjectsMapped: function(){
            return this.testArrayOfObjects.map(function(a){
              a.fullname = a.fname + ' ' + a.lname;
              return {fname: a.fname, lname: a.lname, fullname: a.fullname};
            })
          },
        },
        created: function(){
          this.loadPages();
          this.loadPage(1);
        }
    })
    </script>
    </cfoutput>
  </body>
</html>
