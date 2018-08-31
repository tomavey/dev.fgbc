Vue.component('retreat-info', {
  props: ['retreat','message'],
  methods: {
    formatDateSpan
  },
  template: `
  <div>
  <v-container>
  <v-layout row wrap>
    <v-flex xs12> 
      <v-card>
        <v-card-title primary-title>
          <h2>{{message}}</h2>
        </v-card-title>
        <v-card-text>{{formatDateSpan(retreat.startat, retreat.endat)}}</v-card-text>
        </v-card>
      <v-card>
        <v-card-text v-html="retreat.registrationcomments">
        </v-card-text>
      </v-card>
      <v-card>
        <v-card-text v-html="retreat.schedule">
        </v-card-text>
      </v-card>
      <v-card>
        <v-card-text v-html="retreat.location">
        </v-card-text>
      </v-card>
    </v-flex>
  </v-layout>
  </v-container>
  </div>
  `
})