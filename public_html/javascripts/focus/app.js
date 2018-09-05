var vm = new Vue({
  el:'.app',
  router,
  store,
  data () {
    return {
      message: 'Welcome to Focus Retreats App',
      sideNav: false,
      userIsAuthenticated: false,
      retreats: retreats
    }
  },
  methods: {
    onLogout() {
      alert("logout")
    },
    returnHome () {
      alert('return home')
    }
  },
  mixins: [mixins],
  created () {
    firebase.initializeApp({
      apiKey: "AIzaSyDLJT6DHPgRK89NKPyd1FSjUqMn44XhGC4",
      authDomain: "focus-retreats.firebaseapp.com",
      databaseURL: "https://focus-retreats.firebaseio.com",
      projectId: "focus-retreats",
      storageBucket: "focus-retreats.appspot.com",
      messagingSenderId: "134917343853"
    })
    this.$store.dispatch('getRetreats')
  }
})