const Central = {
  props: ['cardcolors'],
  data () {
    return {
      message: 'Central Retreat...',
      retreats: retreats,
      menuname: 'Central'
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
    <retreat-info :retreat=retreat :message=message :cardcolors=cardcolors></retreat-info>
    </div>`
  }