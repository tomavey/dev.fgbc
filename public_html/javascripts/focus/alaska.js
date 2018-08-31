const Alaska = {
  data () {
    return {
      message: 'Alaska Retreat...',
      retreats: retreats,
      menuname: 'Alaska'
    }
  },
  computed: {
    retreat: function () {
      return this.retreats.filter(el => {
        if (el.menuname === this.menuname) {return true}
      })[0]
    }
  },
  methods: {
    formatDate,
    formatDateSpan,
  },
  template: `<div>
    <retreat-info :retreat=retreat :message=message></retreat-info>
    </div>`
  }