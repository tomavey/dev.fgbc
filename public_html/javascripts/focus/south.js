const South = {
  data () {
    return {
      message: 'South Retreat...',
      menuname: 'South'
    }
  },
  computed: {
    retreat: function () {
      return this.$store.getters.retreat(this.menuname)
    }
  },
  mixins: [mixins],
  template: `<div>
    <retreat-info :retreat=retreat :message=message></retreat-info>
    </div>`
  }