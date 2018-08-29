const Central = {
  data () {
    return {
      message: 'Central Retreat...',
      retreats: retreats
    }
  },
  computed: {
    retreat: function () {
      return this.retreats.filter(el => {
        if (el.menuname === "Central") {return true}
      })[0]
    }
  },
  methods: {
    formatDate: function (value) {
      let oldDate = value.toString()
      oldDate = oldDate.replace('{ts ', '').replace('}', '').replace(' 00:00:00', '')
      var d = new Date(oldDate)
      console.log(months[d.getMonth()])
      return months[d.getMonth()] + d.getDate() + d.getFullYear()
    },
    formatDateSpan: function(start,end) {
      let formatedStart = this.formatDate(start)
      let formatedEnd = this.formatDate(end)
      return formatedStart + ' - ' + formatedEnd
    }
  },
  template: `<div>
    <h1 v-html="retreat.menuname"></h1>
    <p v-html="retreat.registrationcomments"></p>
    <p v-html="retreat.schedule"></p>
    <p>{{formatDateSpan(retreat.startat, retreat.endat)}}</p>
    {{retreat}}
    </div>`
  }