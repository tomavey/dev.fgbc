<div id="inspireApp">

  <v-app id="inspire" v-cloak>
  <v-container>
    <v-card v-if="showSecretInput">
      <v-text-field
        v-model="secretPhrase"
        single-line
        hide-details
        placeholder="Enter the secret phrase here and all will be revealed!"
        id="inspireSecret"
      > 
      </v-text-field>
      <div id="inspirePNG" v-if="!hideImage">
      <img src="/images/handbook/inspire2.png" />
      </div>
      <div id="inspirePNG" v-if="hideImage" transition="slide-x-transition">
      <h2>"And let us consider how we may spur one another on toward love and good deeds, not giving up meeting together, as some are in the habit of doing, but encouraging one another—and all the more as you see the Day approaching."</h>
      </div>

    </v-card>
    <v-card v-if="showData">
      <v-card-title>
      <img src="/images/handbook/inspire2.png" width="200" />
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
        <td class="text-xs-right">{{ props.item.district }}</td>
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
  </v-container>
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
      showSecretInput: true,
      cursorHighlight: "none",
      secretPhrase: '',
      headers: [
        {
          text: 'Last Name',
          align: 'center',
          value: 'lname'
        },
        { text: 'First Name', align: 'center', value: 'fname' },
        { text: 'Church', align: 'center', value: 'name' },
        { text: 'City', align: 'center', value: 'org_city' },
        { text: 'State', align: 'center', value: 'state' },
        { text: 'District', align: 'center', value: 'district' }
      ]
    }
  },
  methods: {
    setLoading: function(){ this.loading = true },
    offLoading: function(){ this.loading = false },
    goToPerson: function(id){ 
      let newl = 'https://charisfellowship.us/handbook/people/' + id
      window.open(newl)
      },
    highlightRow: function() {
      this.cursorHighlight = "off"
    }
  },
  computed: {
    showData: function(){
      let secret = this.secretPhrase.replace(' ','')
      secret = secret.toLowerCase()
      if (secret === "inspiretoday") {
        localStorage.setItem("secret", secret.toLowerCase())
        this.showSecretInput = false
        return true
      } else {
        return false
      }
    },
    hideImage: function() {
      if (this.secretPhrase.length < 8 ) {
        return false
      } else {
        return true
      }
    }
  },
  created(){
    let self = this 
    this.setLoading()
    if ( localStorage.getItem("inspireData") ) {
      try {
        self.people = JSON.parse(localStorage.getItem("inspireData"))
        console.log("got data from localstorare")
        self.offLoading()
      } catch(err) {
        console.log(err)
      }
    }
    axios
      .get('https://charisfellowship.us/api/agbmmembers')
      .then(function(response){
        // console.log(response.data)
        localStorage.setItem("inspireData", JSON.stringify(response.data))
        self.people = response.data
        console.log("got data from api")
        self.offLoading()
      })
    if ( localStorage.getItem("secret") ) {
      this.secretPhrase = localStorage.getItem("secret")
    }  
  }
})

</script>

<style scoped>
#inspireApp {margin-left:10px};
.v-progress-circular {
    margin: 1rem
  }
tr:hover {
  background-color: #E1DADA;
}  

#inspirePNG, #inspireSecret {
  text-align: center;
}

[v-cloak] { display:none; }

</style>