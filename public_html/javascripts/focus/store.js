const store = new Vuex.Store(
  {
    state: {
      storeMessage: "Store Message2",
      months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
      retreats: [],
      retreatsApi: 'https://charisfellowship.us/api/retreats'
    },
    getters: {
      storeMessage: state => state.storeMessage,
      months: state => state.months,
      retreats: state => state.retreats,
      retreatsApi: state => state.retreatsApi,
      retreat: (state) => (menuname) => {
        return state.retreats.filter(el => {
          if (el.menuname === menuname) {return true}
        })[0]
      }
    },
    mutations: {
      updateRetreats (state,payload) {
        state.retreats = payload
      }
    },
    actions: {
      getRetreats (context) {
        const api = this.getters.retreatsApi
        axios
          .get(api)
          .then(response => {
            context.commit('updateRetreats', response.data)
            console.log('Resource updated from online: ' + response.data)
          })
          .catch(() => {
            console.log("something did not work")
          })
      }
    }
  }
)