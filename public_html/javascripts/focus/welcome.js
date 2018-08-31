const Welcome = {
  data () {
    return {
      message: 'Welcome to the Focus Retreats App',
      retreats: retreats,
    }
  },
  computed: {
    showMenuItem: function () {return true}
  },
  methods: {
    formatDate,
    formatDateSpan,
    goTo
  },
  template: `<div>
  <v-layout column>
  <v-flex xs12 sm6>
   
    <v-card>
      <v-container grid-list-md>
        <v-layout row wrap>
          <v-flex
            v-for="retreat in retreats"
            v-bind="xs6"
            :key="retreat.menuname"
            @click='goTo(retreat.menuname)' 
            style='cursor:pointer'
            v-if='showMenuItem'
          >
            <v-card color="blue accent-4">
                <v-container fill-height fluid>
                  <v-layout fill-height>
                    <v-flex xs12 align-end flexbox>
                      <span class="headline white--text display-3" v-text="retreat.menuname"></span>
                      <p class="white--text" v-text="formatDateSpan(retreat.startat, retreat.endat)"></p>
                    </v-flex>
                  </v-layout>
                </v-container>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-card>
  </v-flex>
</v-layout>
</div>`
  }