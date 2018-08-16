<cfoutput>

<div class="app">

#includePartial('v-navigation-drawer')#

#includePartial('v-toolbar')#

</div>

<script>

var vm = new Vue({
  el:'.app',
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
      retreats: #retreats#
    }
  },
  methods: {
    onLogout() {
      alert("logout")
    },
    returnHome () {
      alert('return home')
    }
  }
})
</script> 
</cfoutput>