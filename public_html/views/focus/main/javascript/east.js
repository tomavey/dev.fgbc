const East = {
  data () {
    return {
      message: 'East Retreat...',
      retreats: retreats,
      menuname: 'East'
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