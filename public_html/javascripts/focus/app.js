var vm = new Vue({
  el:'.app',
  router,
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
    },
    goTo
  }
})