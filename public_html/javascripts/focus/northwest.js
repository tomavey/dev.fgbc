const Northwest = {
  data () {
    return {
      message: 'Northwest Retreat...',
      menuname: 'Northwest'
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