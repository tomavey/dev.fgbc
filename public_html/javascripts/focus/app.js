const appView = `
<div>
<v-app>
<!-- Tool Bar at the top --> 
<v-toolbar>
    <v-toolbar-side-icon @click="sideNav = !sideNav"></v-toolbar-side-icon>
    <v-toolbar-title @click="goTo('welcome')" style="cursor:pointer"><img src="https://charisfellowship.us/images/focus/forward60x.png"></v-toolbar-title>
    <v-spacer></v-spacer>
    <v-toolbar-items class="hidden-xs-only">
    <v-btn flat v-for="retreat in retreats" :key="retreat.id" @click="goTo(retreat.menuname)">
        {{ retreat.menuname }}
    </v-btn>
    </v-toolbar-items>
</v-toolbar>

<router-view></router-view>

<!-- Nav drawer - comes up from left side -->
   <v-navigation-drawer
      v-model="sideNav"
      absolute
      temporary
      class="white"
    >
      <v-list class="pa-1">
        <v-list-tile @click="goTo('welcome')" style="cursor:pointer">
            <img src="https://charisfellowship.us/images/focus/forward40x.png">
        </v-list-tile>
      </v-list>

      <v-list class="pt-0" dense>
        <v-divider></v-divider>

        <v-list-tile
          v-for="retreat in retreats"
          :key="retreat.id"
          @click="goTo(retreat.menuname)"
          style="cursor:pointer"
        >

          <v-list-tile-content>
            <v-list-tile-title>{{ retreat.menuname }}</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile
          @click="goTo('groups')"
          style="cursor:pointer"
        >

          <v-list-tile-content>
            <v-list-tile-title>Groups</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>

    <!-- Footer Nav Bar -->
    <v-bottom-nav :value='true' fixed color="white" height="50px">
        <v-btn
        flat
        router
        :to="'groups'"
      >
        Groups
      </v-btn>
      <v-tooltip top>
      <v-btn
        slot="activator" 
        flat
        @click="returnBack"
      >
        <v-icon large dark>arrow_back</v-icon>
      </v-btn>
      <span>Navigate Back</span>
      </v-tooltip>
      <v-tooltip top>
      <v-btn
        slot="activator" 
        flat
        @click="returnHome"
      >
        <v-icon large dark>home</v-icon>
      </v-btn>
      <span>Home</span>
      </v-tooltip>
      <v-btn
        flat
        router
        :to="'groups'"
      >
        Announcements
      </v-btn>
     </v-bottom-nav>
</v-app>     
</div>
`

var vm = new Vue({
  el:'.app',
  template: appView,
  router,
  store,
  data () {
    return {
      message: 'Welcome to Focus Retreats App',
      sideNav: false,
      userIsAuthenticated: false    
    }
  },
  methods: {
    onLogout() {
      alert("logout")
    }
  },
  computed: {
    retreats: function () {
      return this.$store.getters.retreats
    }
  },
  mixins: [mixins],
  created () {
    let self = this
    firebase.initializeApp({
      apiKey: "AIzaSyDLJT6DHPgRK89NKPyd1FSjUqMn44XhGC4",
      authDomain: "focus-retreats.firebaseapp.com",
      databaseURL: "https://focus-retreats.firebaseio.com",
      projectId: "focus-retreats",
      storageBucket: "focus-retreats.appspot.com",
      messagingSenderId: "134917343853"
    })
    this.$store.dispatch('getRetreats')
    firebase.auth().signInAnonymously().catch(function(error) {
      let errorCode = error.code
      let errorMessage = error.message
      console.log("Error code: " + error.code)
      console.log("Error message: " + error.message)
    })
    firebase.auth().onAuthStateChanged(function(user) {
      if (user) {
        let obj = {
          type: user.isAnonymous,
          uid: user.uid  
        }
        self.$store.commit("updateUser",obj)
      } else {
        console.log("Something whent wrong when saving user obj")
      }
    })
  }
})