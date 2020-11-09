<cfparam name="params.previouspage" default=0>
<cfparam name="params.nextpage" default=0>
<cfparam name="handbookpeople" type="query">
<cfparam name="allhandbookpeople" type="query">

<div class="peopleList">


<h1 v-if="loading">Loading Names</h1>
<h1 v-if="!loading">People</h1>
<span v-if="!loading" v-for="alpha in alphabetArray" :key=alpha @click="alphaFilter = alpha" style="cursor:pointer">{{alpha}}&nbsp;|&nbsp;</span>

	<p v-if="!loading">
		<input v-model="searchString" placeholder="Quick search..." /></br>
	</p>

	<p v-if="loading" class="loader">Loading...</p>

	<div class="names-list">
		<p v-for="person in cleanFilteredSortedPeople" :key=person.id>
			<span v-html="person.selectnamestate" @click="goToPerson(person.id)" style="cursor:pointer"></span>
		</p>
	</div>

</div>

<script>
	var wm = new Vue({
		el: ".peopleList",
		data() {return {
			message:"welcome",
			people: [],
			sortBy: "selectnamestate",
			searchString: "",
			alphaFilter: "",
			}
		},
		computed: {
			alphabetArray: function(){
				var alphabet = 'abcdefghijklmnopqrstuvwxyz'.toUpperCase().split('')
				return alphabet
			},
			sortedPeople: function(){return this.people.sort(this.compareValues(this.sortBy))},
			filteredSortedPeople: function(){
				var self = this
				var searchString = this.searchString.toLowerCase()
				var people_array = this.sortedPeople
					if( self.alphaFilter.length ) {
						return people_array.filter(person => person.alpha === self.alphaFilter)
					}
					if( !searchString ){
						return people_array;
					}
				return people_array.filter(person => person.selectnamestate.toLowerCase().includes(searchString))
			},
			cleanFilteredSortedPeople: function() {
				let self = this
				let filteredSortedPeople = this.filteredSortedPeople.map(function(el) {
					// for (cleaner in self.cleaners) {
					// 	el.selectnamestate = el.selectnamestate.replace(cleaner.original, cleaner.replacement)
					// }
					el.selectnamestate = el.selectnamestate
						.replace(", Non US", "")
						.replace(", -TBD","")
						.replace(",,","")
						.replace(", ,","")
					return el
				})
				return filteredSortedPeople
			},
			loading: function(){
				if ( !this.people.length ) { return true }
				return false
			}
		},
		methods: {
			goToPerson: function(id) {
				window.location.href="/handbook/people/" + id
			},
			compareValues: function(key, order=this.sortBy) {
				return function(a, b) {
						if(!a.hasOwnProperty(key) || !b.hasOwnProperty(key)) {
						// property doesn't exist on either object
								return 0; 
						}

						const varA = (typeof a[key] === 'string') ? 
						a[key].toUpperCase() : a[key];
						const varB = (typeof b[key] === 'string') ? 
						b[key].toUpperCase() : b[key];

						let comparison = 0;
						if (varA > varB) {
						comparison = 1;
						} else if (varA < varB) {
						comparison = -1;
						}
						return (
						(order == 'desc') ? (comparison * -1) : comparison
						);
					};
			},
		},
		created: function(){
			let self = this
			axios.get('http://127.0.0.1:8000/api/people')
			.then(function(res){
				console.log(res.data) 
				self.people = res.data 
			})
		}
	})
</script>

<style>
.peopleList {
	margin-left:10px;
	width:110%
}

@media (min-width:900px) {
	.names-list {
		column-count:2
	}
}
@media (min-width:1200px) {
	.names-list {
		column-count:3
	}
}

.loader,
.loader:before,
.loader:after {
  border-radius: 50%;
}
.loader {
  color: #ffffff;
  font-size: 11px;
  text-indent: -99999em;
  margin: 55px auto;
  position: relative;
  width: 10em;
  height: 10em;
  box-shadow: inset 0 0 0 1em;
  -webkit-transform: translateZ(0);
  -ms-transform: translateZ(0);
  transform: translateZ(0);
}
.loader:before,
.loader:after {
  position: absolute;
  content: '';
}
.loader:before {
  width: 5.2em;
  height: 10.2em;
  background: #0dc5c1;
  border-radius: 10.2em 0 0 10.2em;
  top: -0.1em;
  left: -0.1em;
  -webkit-transform-origin: 5.1em 5.1em;
  transform-origin: 5.1em 5.1em;
  -webkit-animation: load2 2s infinite ease 1.5s;
  animation: load2 2s infinite ease 1.5s;
}
.loader:after {
  width: 5.2em;
  height: 10.2em;
  background: #0dc5c1;
  border-radius: 0 10.2em 10.2em 0;
  top: -0.1em;
  left: 4.9em;
  -webkit-transform-origin: 0.1em 5.1em;
  transform-origin: 0.1em 5.1em;
  -webkit-animation: load2 2s infinite ease;
  animation: load2 2s infinite ease;
}
@-webkit-keyframes load2 {
  0% {
    -webkit-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@keyframes load2 {
  0% {
    -webkit-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}

</style>