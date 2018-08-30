<cfoutput>

<div class="app">

#includePartial('v-navigation-drawer')#

#includePartial('v-toolbar')#

<router-view></router-view>

</div>

<script>
const retreats = #retreats#
const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

var vm = new Vue({
  el:'.app',
  router,
  data () {
    return {
      message: 'Welcome to Vue',
      sideNav: false,
      userIsAuthenticated: false,
      additionalDrawerItems: [
        {
          title: "Whatever"
        },
        {
          title: "Whichever"
        }
      ],
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
    goTo (menuName) {
      this.$router.push('/' + menuName)
    }
  }
})
</script> 
</cfoutput>