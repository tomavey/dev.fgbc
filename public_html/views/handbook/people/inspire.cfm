<link href='https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons' rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vuetify/1.1.12/vuetify.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue-router/3.0.1/vue-router.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vuex/3.0.1/vuex.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.min.js"></script>

<div id="inspireApp">

  <v-app id="inspire">
    <v-card>
      <v-card-title>
       Inspire Membership
        <v-spacer></v-spacer>
        <v-text-field
          v-model="search"
          append-icon="search"
          single-line
          hide-details
        ></v-text-field>
      </v-card-title>
    <v-data-table
      :headers="headers"
      :items="people"
      class="elevation-1"
      :search="search"
      :rows-per-page-items=[25,50,100,{"text":"$vuetify.dataIterator.rowsPerPageAll","value":-1}]
    >
      <template slot="items" slot-scope="props">
      <tr @click="goToPerson(props.item.personid)" @mouseover="highlightRow" style="cursor:pointer" :class="cursorHighlight">
        <td class="text-xs-right">{{ props.item.lname }}</td>
        <td class="text-xs-right" >{{ props.item.fname }}</td>
        <td class="text-xs-right">{{ props.item.name }}</td>
        <td class="text-xs-right">{{ props.item.org_city }}</td>
        <td class="text-xs-right">{{ props.item.state }}</td>
      </tr>  
      </template>
        <v-alert slot="no-results" :value="true" color="error" icon="warning">
          Your search for "{{ search }}" found no results.
        </v-alert>
      </v-data-table>
        <v-progress-circular
          :size="50"
          color="primary"
          indeterminate
          v-show="loading"
        >Loading</v-progress-circular>
   </v-card> 
  </v-app>
</div>

<script>

new Vue({
  el: '#inspireApp',
  data () {
    return {
      people: [],
      search: '',
      loading: false,
      cursorHighlight: "none",
      headers: [
        {
          text: 'Last Name',
          align: 'left',
          sortable: true,
          value: 'lname'
        },
        { text: 'First Name', value: 'fname' },
        { text: 'Church', value: 'name' },
        { text: 'City', value: 'org_city' },
        { text: 'State', value: 'state' }
      ]
    }
  },
  methods: {
    setLoading: function(){ this.loading = true },
    offLoading: function(){ this.loading = false },
    goToPerson: function(id){ location.href= 'https://charisfellowship.us/handbook/people/' + id },
    highlightRow: function() {
      this.cursorHighlight = "off"
    }
  },
  created(){
    let self = this 
    this.setLoading()
    axios
      .get('https://charisfellowship.us/api/agbmmembers')
      .then(function(response){
        console.log(response.data)
        self.people = response.data
        self.offLoading()
      })
  }
})

</script>

<style scoped>
#inspireApp {margin-left:10px};
.v-progress-circular {
    margin: 1rem
  }
.shaded td {
  background-color: #E1DADA;
  }
</style>