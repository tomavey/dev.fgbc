


  <div id="regFox">
    <p>Sort by: <span @click="sortByLastName" class="pointer">Last Name</span> | <span @click="sortByFirstName" class="pointer">First Name</span></p>
    <ol>
      <li v-for="reg in sortedSimpleRegs">
        {{reg.firstName}} <span v-if="reg.spouse"> & {{reg.spouse}}</span> <span v-if="!spouseNameContainsLastName(reg)">{{reg.lastName}}</span>
        <span v-if="showEmail">- <a :href="`mailto:${reg.email}`">{{reg.email}}</a></span>
      </li>
    </ol>
    <p>
      <span v-if="showEmail"><a :href="`mailto:${allEmailsList}`">Email All</a></span>
    </p>

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

  //settings from coldfusion
  <cfoutput>
    var formName = '#regFoxFormName#'
    var showEmail = #showEmail#
  </cfoutput>

  const vm = new Vue({
    el: "#regFox",
    data() { return {
      message: "RegFox",
      registrations: [],
      simpleRegs: [],
      formName: formName,
      excludeLabels: ['Registration Options','Name of Spouse (for couple registration)', 'Church', 'Cell Phone Number', 'Roommate(s)'],
      sortOrder: "DESC",
      sortBy: "lastName",
      showEmail: showEmail,
      delimiter: '; '
      }
    },
    methods: {
      spouseNameContainsLastName: function(reg){
        if ( !reg.spouse ) { return false }
        if ( reg.spouse.includes(reg.lastName) ) { return true } else { return false }
      },
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
      sortedSimpleRegs: function() {
        return this.sortRegs(this.simpleRegs)
      },
      allEmailsArray: function() {
        return this.simpleRegs.map( el => el.email )
      },
      allEmailsList: function() {
        return this.allEmailsArray.join(this.delimiter)
      }
    },
    created(){
      db.collection("SimpleRegs").get().then( (snap) => {
        snap.forEach(doc => {
          if ( doc.data().formName === this.formName ) {
            console.dir(`${doc.lname} => ${doc.data()}`)
            this.simpleRegs.push(doc.data())
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