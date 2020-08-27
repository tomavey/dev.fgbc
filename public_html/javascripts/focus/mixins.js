const mixins = {
  data() {
    return {
    }
  },
  computed: {
    months: function() {return this.$store.getters.months}
  },
  methods: {
    convertDateToString: function (date) {
      return date.toString().replace('{ts ', '').replace('}', '').replace(' 00:00:00', '')
    },
    formatDate: function (value) {
      let months = this.months
      let oldDate = value.toString()
      oldDate = oldDate.replace('{ts ', '').replace('}', '').replace(' 00:00:00', '')
      var d = new Date(oldDate)
      console.log(months[d.getMonth()])
      return months[d.getMonth()] + d.getDate() + d.getFullYear()
    },
    fbDateFormat: function (date) {
      const d = new Date(date)
      let m = this.months
      return m[d.getMonth()] + ' ' + d.getDate() + ', ' + d.getFullYear()
    },
    formatDateSpan: function(start,end) {
      let months = this.months
      let d1 = new Date(this.convertDateToString(start))
      let d2 = new Date(this.convertDateToString(end))
      let m1 = months[d1.getMonth()]
      let m2 = months[d2.getMonth()]
      let dd1 = d1.getDate()
      let dd2 = d2.getDate()
      let y = d1.getFullYear()
      if (m1 === m2) { 
        md1 = m1 + ' ' + dd1 + '-' + dd2 
      } else {
        md1 = m1 + ' ' + dd1 + '-' + m2 + '-' + dd2
      }
      return md1 + ', ' + y
    },
    goTo: function(menuName) {
      this.$router.push('/' + menuName)
    },
    returnBack () {
      this.$router.go(-1)
    },
    returnHome () {
      this.$router.push('/')
    }
  }
}




