<!-- Nav drawer - comes up from left side -->
   <v-navigation-drawer
      v-model="sideNav"
      absolute
      temporary
      class="white"
    >
      <v-list class="pa-1">
        <v-list-tile avatar>
          <v-list-tile-avatar>
            <img src="https://charisfellowship.us/images/focus/forward100x.png">
          </v-list-tile-avatar>

          <v-list-tile-content>
            <v-list-tile-title>John Leider</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>

      <v-list class="pt-0" dense>
        <v-divider></v-divider>

        <v-list-tile
          v-for="retreat in retreats"
          :key="retreat.id"
          @click=""
        >

          <v-list-tile-content>
            <v-list-tile-title>{{ retreat.menuname }}</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>
    
