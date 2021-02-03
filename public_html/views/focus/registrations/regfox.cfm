


  <div id="regFox">
    <div id="form" v-if="showForm && showModal">
      <p class="closeModal pointer" @click="showModal = false">CLOSE</p>
      <legend>{{formTitle}}</legend>
      <label>First Name</label>
      <input type="text" placeholder="First Name" v-model="registrant.firstName">
      <label>Last Name</label>
      <input type="text" placeholder="Last Name" v-model="registrant.lastName">
      <label>Email</label>
      <input type="text" placeholder="Email" v-model="registrant.email">
      <label>Church</label>
      <input type="text" placeholder="Church" v-model="registrant.church">
      <label>Spouse first name</label>
      <input type="text" placeholder="Spouse first name" v-model="registrant.spouse">
      <label>Phone</label>
      <input type="text" placeholder="Phone" v-model="registrant.phone"><br/>
      <button type="submit" class="btn btn-large btn-block btn-primary" @click="addOrUpdateReg">Submit</button>
      <p class="closeModal pointer" @click="showModal = false">CLOSE</p>
    </div>

    <div id="list">
      <h2 v-if="sortedSimpleRegs.length">{{formName}}</h2>    
      <h3 v-if="!sortedSimpleRegs.length">No registrations yet!</h3>
      <p>Sort by: 
        <span @click="sortByLastName" class="pointer">Last Name</span> | 
        <span @click="sortByFirstName" class="pointer">First Name</span> | 
        <span @click="sortByDate" class="pointer">Date Registered</span>
      </p>  
      <p>
        <li class="addIcon"><span v-if="showForm" @click="showModal = true"><i class="icon-plus pointer"></i></span></li>
      </p>
      <ol v-if="sortedSimpleRegs.length">
        <li v-for="reg in sortedSimpleRegs">
          {{reg.firstName}} 
          <span v-if="reg.spouse"> & {{reg.spouse}}</span> 
          <span v-if="!spouseNameContainsLastName(reg)">{{reg.lastName}}</span>
          <span v-if="showEmail">- <a :href="`mailto:${reg.email}`">{{reg.email}}</a></span> 
          <span v-if="showForm" @click="editReg(reg)"><i class="icon-edit pointer"></i></span>
          <span v-if="showForm" @click="deleteReg(reg)"><i class="icon-trash pointer"></i></span> 
        </li>
      </ol>
      <p>
        <li class="addIcon"><span v-if="showForm" @click="showModal = true"><i class="icon-plus pointer"></i></span></li>
      </p>
      <p>
        <span v-if="showEmail"><a :href="`mailto:${allEmailsList}`">Email All</a></span>
      </p>
    </div>


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
  var simpleRegsRef = db.collection("SimpleRegs")  
  //settings from coldfusion
  <cfoutput>
    var formName = '#regFoxFormName#'
    var showEmail = #showEmail#
    var showForm = #showForm#
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
      showForm: showForm,
      showModal: false,
      delimiter: '; ',
      registrant: {},
      registrantToEdit: {},
      formTitle: "For Office Only: Add a new person to this list"
      }
    },
    methods: {
      editReg: function(reg){
        //Show the modal, create a form title, and create this registrant for form
        this.showModal = true
        this.formTitle="Edit " + reg.firstName
        this.registrant = reg
      },
      deleteReg: function(reg) {
        //Confirm deletion
        let r = confirm("Are you sure that you want to remove " + reg.firstName + " from this list? \nClick either OK or Cancel.")
        if (r) {
          //Delete the reg from database
          simpleRegsRef.doc(reg.docId).set({formName: "Deleted"}, {merged: true})
          //then remove the reg from simpleRegs array
          .then( () => {
            let removeIndex = this.simpleRegs.map(function(item) { return item.docId; }).indexOf(reg.docId);
            this.simpleRegs.splice(removeIndex,1)
          })
        }
      },
      addOrUpdateReg: function () {
        //this is a switch to choose addReg or updateReg
        this.showModal = true
        if ( !this.registrant.docId ) { this.addReg() } else { this.updateReg() }
      },
      addReg: function(){
        //add formName and timestamp to registrant object
        this.registrant.formName = this.formName
        let dateVar = new Date();
        this.registrant.timestamp = dateVar
        //add the registrant object
        simpleRegsRef.add(this.registrant)
        //then get the new doc id and add to the registrant object then push to the simpleRegs array 
        .then( ( docRef ) => {
          console.log(docRef.id)
          this.registrant.docId = docRef.id
          console.log(this.registrant)
          this.simpleRegs.push(this.registrant)
        })
        //then clear out the registrant object and hide modal
        .then( () => {
          this.registrant = {}
          this.showModal = false
        })
      },
      updateReg: function(){
        //update the database
        simpleRegsRef.doc(this.registrant.docId).set(this.registrant, {merge:true})
        //then clear registrant and hide modal
        .then( () => {
          this.registrant = {}
          this.showModal = false
        })
      },
      spouseNameContainsLastName: function(reg){
        //used to make sure the last name is not repeated if the spouses full name was entered into registration
        if ( !reg.spouse ) { return false }
        if ( reg.spouse.includes(reg.lastName) ) { return true } else { return false }
      },
      sortByLastName: function() {
        this.sortBy = "lastName"
      },
      sortByFirstName: function() {
        this.sortBy = "firstName"
      },
      sortByDate: function() {
        this.sortBy = "timestamp"
      },
      // getDataStringFromRegistrantData: function(registrantData){
      //   let dataString = ""
      //   if ( registrantData.label !== undefined && registrantData.value && (!this.excludeLabels.includes(registrantData.label)) ) { dataString = dataString + registrantData.value}
      //   return this.linkIfEmail(dataString)
      // },
      //used by linkIfEmail()
      validateEmail: function(email) {
        var re = /\S+@\S+\.\S+/;
        return re.test(email);
      },
      //Turns a valud email into a mailto link
      linkIfEmail: function(str){
        if ( this.validateEmail(str) ) {
          return '<a href="mailto:' + str + '">' + str + '<a>'
        } else { return str }
      },
      //used by computed property
      sortRegs: function(sortableRegs){return sortableRegs.sort(this.compareValues(this.sortBy));
        },
      //used in sorts  
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
      //used in created function
      getSimpleRegs: function(){
        simpleRegsRef.where("formName", "==", this.formName).get().then( (docs) => {
        docs.forEach(doc => {
          console.dir(`${doc.lname} => ${doc.data()}`)
          let obj = doc.data()
          obj.docId = doc.id
          this.simpleRegs.push(obj)
        });
          }
          ).then( () =>
            {
              this.loading = false  
            }
          )
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
      // var dateVar = new Date();
      // console.log(dateVar)
      this.loading = true
      this.getSimpleRegs()
    }
  })
</script>

<style>
  .pointer {
    cursor: pointer 
  }
  #form {
    border: solid 2px grey;
    border-radius: 20px;
    padding:20px;
    background-color: Ivory;
    position: absolute;
    margin:auto;
    text-align: center;
  }
  .closeModal {
    text-align:right
  }
  .addIcon {
    list-style:none
  }

</style>