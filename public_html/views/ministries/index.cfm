<cfparam name="params.category" default="">

<cfoutput>
	<cfif params.category is "Church Planting Ministries">
		#includePartial("/charis/promo_churchplanting")#
	</cfif>

	<cfif params.category is "Leadership Training Ministries">
		#includePartial("/charis/promo_leaders")#
	</cfif>

	<cfif params.category is "Doing Good">
		#includePartial("/charis/promo_doinggood")#
	</cfif>
</cfoutput>


<div class="container card card-charis card-charis-square text-center" id="ministrieslist">

	<p>
	<input v-model="searchString" v-on:keyUp="onkeyup()" placeholder="Search for..." /></br>
	Search by Ministry name or Description
	</p>

	<p v-if="showCategoriesFilter">
		<a href="" v-on:click.prevent="setSearch('Doing Good')">Doing Good</a> | 
		<a href="" v-on:click.prevent="setSearch('Church Planting Ministries')">Church Planting Ministries</a> | 
		<a href="" v-on:click.prevent="setSearch('Leadership Training Ministries')">Leadership Training Ministries</a> | 
		<a href="" v-on:click.prevent="setSearch('Districts')">Districts</a> | 
		<a href="" v-on:click.prevent="setSearch('Communication')">Communication</a> | 
		
	</p>

	<div v-for="ministry in filteredMinistries" class="card card-charis-sub">
			<h2 class="card-title">{{ministry.name}}</h2>
			<p v-if="ministry.image.length"><img v-bind:src="'/images/ministries/' + ministry.image" /></p>
			<p>{{ministry.summary}}</p>
			<p v-if="ministry.webaddress.length"><a v-bind:href="fixurl(ministry.webaddress)">{{cleanurl(ministry.webaddress)}}</a></p>
			<p class="text-right"><a href="" v-on:click.prevent="setSearch(ministry.category)">Category: {{ministry.category}}</a></p>
	</div>

</div>

<cfoutput>

<script>
var vm = new Vue({
    el: "##ministrieslist",
    data: {
        welcome: "Hello",
        ministries: #queryToJson(ministry)#,
        searchString: "",
        filterString: "",
		category: "#params.category#"
    },
    methods: {
        fixurl: function(website){
          if (website.includes("https://")){
            return website;
          };
          website = website.replace("http://","");
          return "http://" + website;
        },
        cleanurl: function(website){
	        website = website.replace("https://","");
    	    website = website.replace("http://","");
        	return website;
        },
        onkeyup: _.debounce(function(){
          this.filterString = this.searchString;
          console.log(this.filterString);
          },300),
        setSearch: function(state){
          this.filterString = state;
         },
      },     
    computed: {
        filteredMinistries: function(){
          var searchString = this.filterString,
              ministries_array = this.ministries
          if(!searchString){
            return ministries_array;
          }
          searchString = searchString.trim().toLowerCase();
            ministries_array = ministries_array.filter(function(item){
              if(item.name.toLowerCase().indexOf(searchString) !== -1 ||
                item.summary.toLowerCase().indexOf(searchString) !== -1 ||
                item.category.toLowerCase().indexOf(searchString) !== -1
                ){
                return item
              }
            })
            return ministries_array;
          },
		  showCategoriesFilter: function(){
			  return this.category.length;
		  }
    }
});


</script>

</cfoutput>