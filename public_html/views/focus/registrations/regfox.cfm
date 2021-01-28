


  <div id="regFox">
    <p>Sort by: <span @click="sortByLastName" class="pointer">Last Name</span> | <span @click="sortByFirstName" class="pointer">First Name</span></p>
    <ul>
      <li v-for="reg in regs">
        {{reg.firstName}} {{reg.lastName}} - 
        <a :href="`mailto:${reg.email}`">{{reg.email}}</a>
      </li>
    </ul>
  </div>

<script>
  var firebaseConfig = {
      apiKey: "AIzaSyCcxsgcoP11wa5WMZpz0OPKE3lG0EI03XQ",
      authDomain: "charis-focus-retreats.firebaseapp.com",
      projectId: "charis-focus-retreats",
      storageBucket: "charis-focus-retreats.appspot.com",
      messagingSenderId: "867220567479",
      appId: "1:867220567479:web:bacb6e916ac2378209e432",
      measurementId: "G-Y78ZMM11F1"
    };

  firebase.initializeApp(firebaseConfig)

  var db = firebase.firestore()

  const vm = new Vue({
    el: "#regFox",
    data() { return {
      message: "RegFox",
      registrations: [],
      formName: "2021 South Focus Retreat",
      excludeLabels: ['Registration Options','Name of Spouse (for couple registration)', 'Church', 'Cell Phone Number', 'Roommate(s)'],
      sortOrder: "DESC",
      sortBy: "lastName"
      }
    },
    methods: {
      sortByLastName: function() {
        this.sortBy = "lastName"
      },
      sortByFirstName: function() {
        this.sortBy = "firstName"
      },
      getDataStringFromRegistrantData: function(registrantData){
        let dataString = ""
        if ( registrantData.label !== undefined && registrantData.value && (!this.excludeLabels.includes(registrantData.label)) ) { dataString = dataString + registrantData.value}
        return this.linkIfEmail(dataString)
      },
      validateEmail: function(email) {
        var re = /\S+@\S+\.\S+/;
        return re.test(email);
      },
      linkIfEmail: function(str){
        if ( this.validateEmail(str) ) {
          return '<a href="mailto:' + str + '">' + str + '<a>'
        } else { return str }
      },
      sortRegs: function(sortableRegs){return sortableRegs.sort(this.compareValues(this.sortBy));
            },
      compareValues: function(key, order=this.sortOrder) {
        return function(a, b) {
          if(!a.hasOwnProperty(key) || !b.hasOwnProperty(key)) {
          // property doesn't exist on either object
              return 0; 
          }

          const varA = (typeof a[key] === 'string') ? 
          a[key].toUpperCase() : a[key];
          const varB = (typeof b[key] === 'string') ? 
          b[key].toUpperCase() : b[key];

          let comparison = 0;
          if (varA > varB) {
          comparison = 1;
          } else if (varA < varB) {
          comparison = -1;
          }
          return (
          (order == 'desc') ? (comparison * -1) : comparison
          );
        };
      },
    },
    computed: {
      regs: function() {
        let sortableRegs = []
        //loop through registrations
        for ( let i = 0; i < this.registrations.length; i++ ) {
          //loop through each registrant - there can me multiple registrants in one registratrion
          for ( let ii = 0; ii < this.registrations[i].registrants.length; ii++) {
            var registrant = {}
            //Look through the data for each registrant
            for ( let iii = 0; iii < this.registrations[i].registrants[ii].data.length; iii++ ) {
              let registrantData = this.registrations[i].registrants[ii].data[iii]
              var registrantObj = {}

              //collect needed data for list  
              if ( registrantData.label === 'Email' ) { registrantObj.email = registrantData.value }
              if ( registrantData.label === 'Cell Phone Number' ) { registrantObj.phone = registrantData.value }
              if ( registrantData.label === 'Church' ) { registrantObj.church = registrantData.value }
              if ( registrantData.label === 'Roommate(s)' ) { registrantObj.roommate = registrantData.value }

              try {
                if ( registrantData.first.label === 'First Name' ) { registrantObj.firstName = registrantData.first.value }
                if ( registrantData.last.label === 'Last Name' ) { registrantObj.lastName = registrantData.last.value }
              } catch (err) {
                console.log(err)
              }
              // console.log("NewObj: ",newObj)
              if ( Object.keys(registrantObj).length !== 0 ) {
                registrant = Object.assign(registrant,registrantObj)
              }
            }
            sortableRegs.push(registrant)
          }
          // sortableRegs.push(array1)
        }
        return this.sortRegs(sortableRegs)
      }
    },
    created(){
      db.collection("Regs").get().then( (snap) => {
        snap.forEach(doc => {
          if ( doc.data().data.formName === this.formName ) {
            console.dir(`${doc.id} => ${doc.data().data}`)
            this.registrations.push(doc.data().data)
          }
        });
      }
      )
    }
  })
</script>

<style>
  .pointer {
    cursor: pointer 
  }
</style>