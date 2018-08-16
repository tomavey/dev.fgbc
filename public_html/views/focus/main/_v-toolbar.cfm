<!-- Tool Bar at the top -->    
 <v-toolbar>
      <v-toolbar-side-icon @click="sideNav = !sideNav"></v-toolbar-side-icon>
      <v-toolbar-title><img src="https://charisfellowship.us/images/focus/forward60x.png"></v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items class="hidden-xs-only">
        <v-btn flat v-for="retreat in retreats" :key="retreat.id">
            {{ retreat.menuname }}
        </v-btn>
        <v-btn flat @click="onLogout" v-if=userIsAuthenticated>
            Logout
        </v-btn>
      </v-toolbar-items>
    </v-toolbar>