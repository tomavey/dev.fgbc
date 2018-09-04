const Announcements = {
  mixins: [mixins],
  data () {
    return {
      message: 'Announcements',
      menuname: 'Announcements',
      announcements: [],
      chatroom: []
    }
  },
  computed: {
  },
  methods: {
    snapshotToArray: function (snapshot) {
      var returnArr = []
      snapshot.forEach(function (childSnapshot) {
        var item = childSnapshot.val()
        item.key = childSnapshot.key
        returnArr.push(item)
      })
      return returnArr
    },
    postAnnouncement: function () {
      let obj = {}
      obj.chat = this.announcement
      obj.datetime = Date.now()
      obj.reverseDatetime = -Date.now()
      firebase.database().ref('announcements').push(obj).then(console.log('pushed')).catch((error) => console.log(error))
    }
  },
  created () {
    const obj = {"txt": "tst"}
    firebase.database().ref('announcements').orderByChild('reverseDatetime').limitToFirst(100).on('value', (snapshot) => {
      console.log(snapshot)
      this.chatroom = this.snapshotToArray(snapshot)
    })
  },  
  template: `<div>
      <h1>{{message}}</h1>
      {{chatroom}}
    </div>`
  }