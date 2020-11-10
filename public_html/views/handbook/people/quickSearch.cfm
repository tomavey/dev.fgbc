<!--- <cfparam name="params.previouspage" default=0>
<cfparam name="params.nextpage" default=0>
<cfparam name="handbookpeople" type="query">
<cfparam name="allhandbookpeople" type="query"> --->

<div class="peopleList">


<h1 v-if="loading">Loading Names</h1>
<h1 v-if="!loading" @click="changeListOrientation" @mouseover="showToolTip('Change list orientation')" @mouseLeave="clearTooltip" class="pointer">People{{dataSource}}</h1>
<span @click="alphaFilter=''" class="pointer" @mouseover="showToolTip('Click to show everyone!')" @mouseLeave="clearTooltip" >All&nbsp;|&nbsp;</span>
<span v-if="!loading" v-for="alpha in alphabetArray" :key=alpha @click="alphaFilter = alpha" class="pointer" @mouseover="showAlphaTooltip(alpha)" @mouseLeave="clearTooltip">{{alpha}}&nbsp;|&nbsp;</span>
<span @click="goToPositions()" @mouseover="showToolTip('List people by ministry type.')" @mouseLeave="clearTooltip" class="pointer">
	[*]
	<span v-if="showPositionsTooltip" >
		View people by ministry types
	</span>
</span>

	<div v-if="!loading" class="flex-container">
		<p><input v-model="searchString" placeholder="Quick search..." class="search-input" @mouseover="showToolTip('Really FAST search. Just start typing')" @mouseLeave="clearTooltip" @input="showSearchTooltip"/></p>
		<p class="tip" v-html="tooltip" ></p></br>
	</div>

	<p v-if="loading" class="loader">Loading...</p>

	<div :class="namesListClass">
		<p v-for="person in cleanFilteredSortedPeople" :key=person.id class="person">
			<span v-html="person.selectnamestate" @click="goToPerson(person.id)" @mouseover="showPersonTooltip(person.selectnamestate)" @mouseLeave="clearTooltip" style="cursor:pointer"></span>
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
			dataSource: "",
			showPositionsTooltip: false,
			namesListClass: "columns-container",
			defaultNamesListClass: "columns-container",
			tooltip: ""
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
						people_array = people_array.filter(person => person.alpha === self.alphaFilter)
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
						.replace(" , "," ")
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
			clearTooltip: function() {this.tooltip = ""},
			showPersonTooltip: function (selectnamestate) {
				this.tooltip = "Click to view " + selectnamestate
			},
			showAlphaTooltip: function (alpha) {
				this.tooltip = "Click to list all the " + alpha +"'s'"
			},
			showSearchTooltip: function () {
				this.tooltip = "Listing all containing " + this.searchString +"'.'"
			},
			showToolTip: function(tip) {
				this.tooltip = tip
			},
			changeListOrientation: function(){
				if ( this.namesListClass === "grid-container" ) { 
					this.namesListClass = "columns-container"; 
					localStorage.setItem("handbookpeopleorientation","columns-container"); 
					return}
				if ( this.namesListClass === "columns-container" ) { 
					this.namesListClass = "grid-container"; 
					localStorage.setItem("handbookpeopleorientation","grid-container"); 
					return}
			},
			goToPositions: function(){
				window.location.href="/handbook/positions/listpeople"
			},
			goToPerson: function(id) {
				let href = "/handbook/people/" + id
				window.location.href=href
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
			getHandbookPeopleFromLocalStorage: function ( name = 'HandbookPeople') {
				var data = JSON.parse(localStorage.getItem(name))
				if ( data ) {
					this.people = data
					this.dataSource = ":"
				}
    	},
			getHandbookPeopleFromApi: function(api = '/api/people', name = 'HandbookPeople' ) {
				let self = this
				axios.get(api)
				.then(function(res){
					localStorage.setItem(name, JSON.stringify(res.data))
					self.people = res.data
					self.dataSource = "::"
				})
			},
			setListOrientationFromLocalStorage: function (){
				let namesListClass = localStorage.getItem("handbookpeopleorientation")
				console.log(namesListClass)
				if ( namesListClass.length ) { this.namesListClass = namesListClass }
			}
		},
		created: function(){
			this.getHandbookPeopleFromLocalStorage()
			this.getHandbookPeopleFromApi()
			this.setListOrientationFromLocalStorage()
		}
	})
</script>

<style>
.tip {
	width:100%;
	text-align:center;
	font-size:1.2em;
	font-weight: bold;
	color:red;

}
.flex-container {
	display:flex
}
.grid-container {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	grid-auto-rows: minmax(10px, auto);
	align-content: stretch;
	margin: 10px 10px;
}

@media (min-width:900px) {
	.columns-container {
		margin: 10px 10px;
		column-count:2
	}
}

@media (min-width:1200px) {
	.columns-container {
		margin: 10px 10px;
		column-count:3
	}
}

.pointer {
	cursor:pointer
}

.peopleList {
	margin-left:10px;
	width:110%
}

/* for loader spinner */
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