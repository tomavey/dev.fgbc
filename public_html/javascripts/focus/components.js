Vue.component('retreat-info', {
  props: ['retreat','message', 'cardcolors'],
  mixins: [mixins],
  methods: {
  },
  template: `
  <div>
  <v-container fluid grid-list-lg>
  <v-layout row wrap>
    <v-flex xs12> 
      <v-card class="blue-grey darken-4 menuname white--text">
        <v-card-title primary-title>
          <h2>{{message}}</h2>
        </v-card-title>
        <v-card-text>{{formatDateSpan(retreat.startat, retreat.endat)}}</v-card-text>
      </v-card>
    </v-flex>
    <v-flex xs12> 
      <v-card class="comments" color='blue-grey lighten-5'>
        <v-card-text v-html="retreat.registrationcomments">
        </v-card-text>
      </v-card>
    </v-flex>
    <v-flex xs12> 
        <v-card class="schedule" color='blue-grey lighten-4'>
        <v-card-text v-html="retreat.schedule">
        </v-card-text>
      </v-card>
    </v-flex>
    <v-flex xs12> 
        <v-card class="location" color='blue-grey lighten-3'>
        <v-card-text v-html="retreat.location">
        </v-card-text>
      </v-card>
    </v-flex>
  </v-layout>
  </v-container>
  </div>
  `
})