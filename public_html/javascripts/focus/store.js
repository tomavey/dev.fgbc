const store = new Vuex.Store(
  {
    state: {
      storeMessage: "Store Message2",
      months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
      retreats: retreats
    },
    getters: {
      storeMessage: state => state.storeMessage,
      months: state => state.months,
      retreats: state => state.retreats,
      retreat: (state) => (menuname) => {
        return state.retreats.filter(el => {
          if (el.menuname === menuname) {return true}
        })[0]
      }
    }
  }
)