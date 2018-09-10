const Signin = {
  mixins: [mixins],
  data () {
    return {
      message: 'Welcome to Sign In',
      email: '',
      password: '',
      alert: true
    }
  },
  computed: {},
  methods: {},
  template: `
  <v-container>
    <v-layout row>
      <v-flex xs12 sm6 offset-sm3>
        <v-alert :value="true" type="error" v-model="alert" dismissible v-if="error">
          {{ error }}
        </v-alert>
      </v-flex>
    </v-layout>
    <v-layout row>
      <v-flex xs12 sm6 offset-sm3>
        <v-card>
          <v-card-text>
            <v-container>
              <form @submit.prevent="onSignin">
                <v-layout row>
                  <v-flex xs12>
                    <v-text-field
                      name="email"
                      label="Email"
                      id="email"
                      v-model="email"
                      type="email"
                      required></v-text-field>    
                  </v-flex>
                </v-layout>
                <v-layout row>
                  <v-flex xs12>
                    <v-text-field
                      name="password"
                      label="Password"
                      id="password"
                      v-model="password"
                      type="password"
                      required></v-text-field>    
                  </v-flex>
                </v-layout>
                <v-layout>
                  <v-flex xs12>
                    <v-btn type="submit" :disabled="loading" :loading="loading">
                      Sign In
                      <span slot="loader" class="custom-loader">
                        <v-icon light>cached</v-icon>
                      </span>
                    </v-btn>
                  </v-flex>
                </v-layout>
              </form>
                <v-layout>
                  <v-flex xs12 sm4 text-xs-center>
                    <v-btn @click="goTo('signup')" flat small>Create a new user</v-btn>
                  </v-flex>
                </v-layout>
            </v-container>
          </v-card-text>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
    `
}
  
  
  

