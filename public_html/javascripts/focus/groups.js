const Groups = {
  mixins: [mixins],
  data () {
    return {
      message: 'Groups',
      menuname: 'Groups',
      groups: [],
      searchLabel: 'Search',
      searchString: '',
      showSearchInput: true
    }
  },
  computed: {
    filteredGroups: function() {
      const data  = this.groups.filter(
        (el) => { if (el.content.toLowerCase().includes(this.searchString.toLowerCase()) ||
          el.name.toLowerCase().includes(this.searchString.toLowerCase()) ||
          el.subject.toLowerCase().includes(this.searchString.toLowerCase())
          ) { return true } }
      )
      return data
    }
 },
  methods: {
    snapshotToArray: function (snapshot) {
      var returnArr = []
      snapshot.forEach(function (childSnapshot) {
        var item = childSnapshot.val()
        item.key = childSnapshot.key
        returnArr.push(item)
      })
      return returnArr
    },
    postGroup: function () {
      let obj = {}
      obj.uid = this.$store.getter(user).uid
      obj.content = this.content
      obj.datetime = Date.now()
      obj.reverseDatetime = -Date.now()
      firebase.database().ref('groups').push(obj).then(console.log('pushed')).catch((error) => console.log(error))
    },
    setSearchString: function(text) {
      this.searchString = text
    },
    clearSearchString: function (){
      this.searchString = ''
    }
  },
  created () {
    firebase.database().ref('groups').orderByChild('reverseDatetime').limitToFirst(100).on('value', (snapshot) => {
      console.log(snapshot)
      this.groups = this.snapshotToArray(snapshot)
    })
  },  
  template: `<div>
  <v-container>

<!-- Search Input -->
  <v-layout row wrap>
    <v-flex xs8>
      <v-text-field
        id='search-groups'
        name='search--groups-input'
        :label='searchLabel'
        v-model='searchString'
        v-show='showSearchInput'
      >
      </v-text-field>
      <span @click="clearSearchString" style="cursor:pointer" v-if="searchString.length">Clear Search</span>
    </v-flex>          
  </v-layout>  

<!-- List of Group Sessions -->
  <v-layout row wrap>
    <v-flex xs12 v-for='group in filteredGroups' :key='group.id'>
      <v-card color='orange darken-4' class='white--text'>
        <v-card-title primary-title>
          <div class="headline">
            {{ group.subject }}
          </div>
        </v-card-title>
        <v-card-text v-html='group.content'>
        </v-card-text>
        <v-card-text>
          posted by <span @click="setSearchString(group.name)" style="cursor:pointer">{{group.name}}</span> on {{fbDateFormat(group.datetime)}}
        </v-card-text>
      </v-card>
    </v-flex>
    <v-card-text @click="goTo('groupsDialog')">
      ------      
    </v-card-text>
    </v-layout>
</v-container>  
</div>`
  }