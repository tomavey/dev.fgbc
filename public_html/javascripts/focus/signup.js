const Signup = {
  mixins: [mixins],
  data () {
    return {
      message: 'Welcome to Signup',
      email: '',
      password: '',
      alert: true,
      confirmPassword: '',
      displayName: '',
      phoneNumber: ''
    }
  },
  computed: {
    comparePasswords () {
      return this.password !== this.confirmPassword ? 'Passwords do not match' : ''
    },
    user () {
      return this.$store.getters.user
    }
  },
  methods: {
    onSignup () {
      const newUser = {
        email: this.email,
        password: this.password,
        displayName: this.displayName,
        phoneNumber: this.phoneNumber
      }
      console.log('New User: ' + JSON.stringify(newUser))
      alert("signup")
    }
  },
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
              <form @submit.prevent="onSignup">
                <v-layout row>
                  <v-flex xs12>
                    <v-text-field
                      name="email"
                      label="Email"
                      id="email"
                      v-model="email"
                      type="email"
                      required>
                    </v-text-field>    
                  </v-flex>
                </v-layout>
                <v-layout row>
                  <v-flex xs12>
                    <v-text-field
                      name="displayName"
                      label="Display Name"
                      id="displayName"
                      v-model="displayName"
                      type="text"
                      required>
                    </v-text-field>    
                  </v-flex>
                </v-layout>
                <v-layout row>
                  <v-flex xs12>
                    <v-text-field
                      name="phoneNumber"
                      label="Phone Number"
                      id="phoneNumber"
                      v-model="phoneNumber"
                      type="text">
                    </v-text-field>    
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
                <v-layout row>
                  <v-flex xs12>
                    <v-text-field
                      name="confirmPassword"
                      label="Confirm Password"
                      id="confirmPassword"
                      v-model="confirmPassword"
                      type="password"
                      :rules="[comparePasswords]"
                      ></v-text-field>    
                  </v-flex>
                </v-layout>
                <v-layout>
                  <v-flex xs12>
                    <v-btn type="submit" :disabled="loading" :loading="loading">
                      Sign Up
                      <span slot="loader" class="custom-loader">
                        <v-icon light>cached</v-icon>
                      </span>
                    </v-btn>
                  </v-flex>
                </v-layout>
              </form>
            </v-container>
          </v-card-text>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
 `
}
  
  
  

