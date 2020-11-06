<cfparam name="params.previouspage" default=0>
<cfparam name="params.nextpage" default=0>
<cfparam name="handbookpeople" type="query">
<cfparam name="allhandbookpeople" type="query">

<div class="peopleList">


<h1>People</h1>

	<p>
		<input v-model="searchString" placeholder="Quick search..." /></br>
	</p>

	<div class="names-list">
		<p v-for="person in uniquePeople" :key=person.id>
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
			searchString: ""
			}
		},
		computed: {
			sortedPeople: function(){return this.people.sort(this.compareValues(this.sortBy))},
			filteredPeople: function(){
				var searchString = this.searchString.toLowerCase(),
						people_array = this.sortedPeople
					if(!searchString){
						return people_array;
					}
				return people_array.filter(person => person.selectnamestate.toLowerCase().includes(searchString))
			},
			uniquePeople: function() {
				let uniquePeople = this.filteredPeople
				uniquePeople = [...new Set(uniquePeople)]
				return uniquePeople
			},
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

.names-list {
	width:90%;
	column-count:2
}
.peopleList {
	margin-left:10px;
	width:110%

}
</style>