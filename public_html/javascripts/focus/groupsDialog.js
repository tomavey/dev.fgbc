const GroupsDialog = {
  mixins: [mixins],
  data () {
    return {
      message: 'Groups Dialog Page',
      content: ''
    }
  },
  computed: {
    uid: function () {
      return this.$store.getters.user.uid
    }
  },
  methods: {
    update: function () {
      alert(this.content)
    },
    postGroup: function () {
      let obj = {}
      obj.uid = this.uid
      obj.name = this.name
      obj.content = this.content
      obj.subject = this.subject
      obj.datetime = Date.now()
      obj.reverseDatetime = -Date.now()
      console.log(obj)
      firebase.database().ref('groups').push(obj).then(console.log('pushed')).catch((error) => console.log(error))
      this.$router.push('/groups')
    }
  },
  template: `
  <div>
    <v-container>
    <v-form ref="form" v-model="valid" lazy-validation>
        <v-text-field
          v-model="name"
          label="Name"
          required
        ></v-text-field>
        <v-text-field
          v-model="subject"
          label="Subject"
          required
        ></v-text-field>
        <v-textarea
          name="content"
          label="Group questions or instructions:"
          v-model="content"
          hint="Let's talk about..."
        ></v-textarea>
        <v-btn
          :disabled="!valid"
          @click="postGroup"
        >
          submit
        </v-btn>
      </v-form>
    </v-container>
  </div>`
}