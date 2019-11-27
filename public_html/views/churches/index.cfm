<cfparam name="title" default="Churches and Campuses in the Charis Fellowship">
      <!-- Promo Block -->
    <section class="g-pos-rel">
      <div class="dzsparallaxer auto-init height-is-based-on-content use-loading mode-scroll" data-options='{direction: "reverse", settings_mode_oneelement_max_offset: "150"}'>
        <div class="divimage dzsparallaxer--target w-100 g-bg-cover g-bg-pos-top-center g-bg-img-hero g-bg-bluegray-opacity-0_2--after" style="height: 130%; background-image: url(../assets/img/extra-hero-image.jpg);"></div>

         <div class="container text-center g-py-130">
        <p class="g-color-white g-font-weight-600 g-font-size-35 text-uppercase"><cfoutput>#title#</cfoutput></p>
      </div>
      </div>
    </section>
    <!-- End Promo Block --> 

<p class="container card text-center"><a href="/handbook/" target="_new" class="btn btn-md u-btn-inset u-btn-bluegray g-mr-10 g-mb-15">Access the online handbook</a></p>

<cfoutput>
  <p class="container text-center">
    Request additional information about a church using the #linkTo(text="Contact Us", controller="messages", action="new")# form.
  </p>
</cfoutput>

<div class="container card card-charis card-charis-square text-center" v-cloak id="churches1">
<p>
<span>| </span>
<span v-for="state in states"><a href="" v-on:click.prevent="setSearch(state.state)">{{state.state}} | </a></span>
</p>

<p>
  <input v-model="searchString" v-on:keyUp="onkeyup()" placeholder="Search for..." /></br>
  Search by state, city, or church name
</p>

  <div v-bind:class="columnsClass">
  <cfoutput>
  <div v-for="(church, index) in filteredChurches">
    <div v-if="isNewState(index,church.state,filteredChurches)">
      <hr/>
      <h3 class="alert alert-warning">{{church.state}}</h3>
    </div>
    <p class="card">
      <h4>{{church.name}}</h4>
      {{church.org_city}}, {{church.state}} {{church.zip}}</br>
      <span v-if="church.org_city !== church.listed_as_city">Listed as: {{church.listed_as_city}}</br></span>
      <span >Meeting at: {{church.meetingplace}}</br></span>
      <span ><a v-bind:href="fixUrlLink(church.website)">{{ fixUrlLook(church.website) }}</a></br></span>
      {{church.phone}}</br>
    </p>
  </div>
  </cfoutput>
  </div>
</div>


<cfoutput>

<script>
var vm = new Vue({
    el: "##churches1",
    data: {
        welcome: "Hello",
        churches: #churchesjson#,
        states: #churchStatesJson#,
        searchString: "",
        filterString: "",
        columnsClass: "charis-columns"
    },
    methods: {
        fixUrlLink: function(website){
          if (website.includes("https://")){
            return website;
          };
          website = website.replace("http://","");
          return "http://" + website;
        },
        fixUrlLook: function(website) {
          website = website.replace("http://","");
          website = website.replace("https://","");
          return website
        },
        isNewState: function(index,state,churches){
          if (index==0){
            return true;
          };
          if (churches[index-1].state !== state) {
            return true;
          };
          return false;
        },
        onkeyup: _.debounce(function(){
          this.filterString = this.searchString;
          console.log(this.filterString);
          this.columnsClass = "";
          },300),
        setSearch: function(state){
          this.filterString = state;
          this.columnsClass = "";
         },
      },     
    computed: {
        filteredChurches: function(){
          var searchString = this.filterString,
              church_array = this.churches
          if(!searchString){
            return church_array;
          }
          searchString = searchString.trim().toLowerCase();
            church_array = church_array.filter(function(item){
              if(item.name.toLowerCase().indexOf(searchString) !== -1 ||
                item.state.toLowerCase().indexOf(searchString) !== -1 ||
                item.org_city.toLowerCase().indexOf(searchString) !== -1 ||
                item.email.toLowerCase().indexOf(searchString) !== -1 ||
                item.listed_as_city.toLowerCase().indexOf(searchString) !== -1 
                ){
                return item
              }
            })
            return church_array;
          },
    }
});


</script>

</cfoutput>

