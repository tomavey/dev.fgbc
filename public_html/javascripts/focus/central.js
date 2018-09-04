const Central = {
  mixins: [mixins],
  data () {
    return {
      message: 'Central Retreat...',
      menuname: 'Central'
    }
  },
  computed: {
    retreat: function () {
      return this.$store.getters.retreat(this.menuname)
    }
  },
  methods: {
  },
  template: `<div>
    <retreat-info :retreat=retreat :message=message></retreat-info>
    </div>`
  }