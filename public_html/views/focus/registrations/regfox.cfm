<!----------------------------------------->
<!----------------------------------------->
<!--- 
  This page is controlled by vue js.
  Event registrations on regfox and pushed to
  a firestore function endpoint (firebase) 
  and then accessed via vue js on this page.
  Registrants can be edited on this page but
  updates are not pushed back up to regFox.
  Created by Tom Avey - February 2021
 --->
<!----------------------------------------->
<!----------------------------------------->
<div id="regFox">

<!----the list of names--->
  <div id="list">
    <h2 v-if="filteredSortedSimpleRegs.length">{{formName}}</h2>    
    <h3 v-if="!filteredSortedSimpleRegs.length">No registrations yet!</h3>
    <p>Sort by: 
      <span @click="$sortBy('lastName')" :class="colHeaderclass('lastName')">Last Name</span> | 
      <span @click="$sortBy('firstName')" :class="colHeaderclass('firstName')">First Name</span> | 
      <span @click="$sortBy('timestamp')" :class="colHeaderclass('timestamp')">Date Registered</span>
      <i class="icon-arrow-up pointer" v-if="reverse" @click="$reverse"></i>
      <i class="icon-arrow-down pointer" v-if="!reverse" @click="$reverse"></i>
    </p>  
    <p>
      <input type="text" placeholder="Search" v-model="searchText" class="input-large search-query regFoxSearch" ref="search" @keyup="$onKeyUp">
    </p>
    <p>
      <li class="addIcon"><span v-if="showForm" @click="$showModal"><i class="icon-plus pointer"></i></span></li>
    </p>
    <ol v-if="filteredSortedSimpleRegs.length">
      <li v-for="(reg, index) in filteredSortedSimpleRegs" :key="index">
        {{reg.firstName}} 
        <span v-if="reg.spouse"> & {{reg.spouse}}</span> 
        <span v-if="!spouseNameContainsLastName(reg)">{{reg.lastName}}</span>
        <span v-if="showEmail">- <a :href="`mailto:${reg.email}`">{{reg.email}}</a></span> 
        <span v-if="showForm" @click="editReg(reg,index)"><i class="icon-edit pointer"></i></span>
        <span v-if="showForm" @click="deleteReg(reg,index)"><i class="icon-trash pointer"></i></span> 
      </li>
    </ol>
    <p>
      <li class="addIcon"><span v-if="showForm" @click="$showModal"><i class="icon-plus pointer"></i></span></li>
    </p>
    <p>
      <span v-if="showEmail"><a :href="`mailto:${allEmailsList}`">Email All</a></span>
      Total people registered (including spouses) = {{countNames}}
    </p>
  </div>

<!---the modal to add and edit names--->
  <transition name="fade" appear>
    <div class="modal-overlay" v-if="showModal" @click="closeModal">
    </div>
  </transition>
  <transition name="slide" appear>
    <div class="modal" v-if="showModal">
      <h1>{{formTitle}}</h1>
      <div>
        <label>First Name</label>
        <input type="text" placeholder="First Name" v-model="registrant.firstName" ref="lName">
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
        <input value="Submit" type="submit" class="btn btn-large btn-block btn-primary" @click="addOrUpdateReg(registrant.index)" />
      </div>
      <p class="closeModal pointer" @click="closeModal">
        &#10060;
      </p>
    </div>
  </transition>

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
  var RegsRef = db.collection("Regs")  
  //settings from coldfusion
  <cfoutput>
    var formName = '#regFoxFormName#'
    var showEmail = #showEmail#
    var showForm = #showForm#
  </cfoutput>

  const vm = new Vue({
    el: "#regFox",
    data() { return {
      Regs: [],
      simpleRegs: [],
      formName: formName,
      sortBy: "lastName",
      reverse: false,
      showEmail: showEmail,
      showForm: showForm,
      showModal: false,
      delimiter: '; ',
      registrant: {},
      formTitle: "For Office Only: Add a new person to this list",
      searchText: ""
      }
    },
    methods: {
      $reverse: function(){
        this.reverse = !this.reverse
      },
      $onKeyUp: function(){
        if ( this.searchText === "CHARISFELLOWSHIP!" ) {
          this.showEmail = true
        }
      },
      ///////////
      //CRUD
      //////////
      editReg: function(reg,index){
        //Show the modal, create a form title, and create this registrant for form
        this.$showModal()
        //Used in the head of the edit form
        this.formTitle="Edit " + reg.firstName
        //add the index to the reg object
        reg.index = index
        //reference this.registrant used in form v-models
        this.registrant = reg
      },
      deleteReg: function(reg,index) {
        //Confirm deletion
        let r = confirm("Are you sure that you want to remove " + reg.firstName + " from this list? \nClick either OK or Cancel.")
        if (r) {
          //Delete the reg from database
          simpleRegsRef.doc(reg.docId).set({formName: "Deleted"}, {merge: true})
        }
      },
      addOrUpdateReg: function (index) {
        //this is a switch to choose addReg or updateReg
        this.$showModal()
        if ( !this.registrant.docId ) { this.addReg() } else { this.updateReg(index) }
      },
      addReg: function(){
        //add formName and timestamp to registrant object
        this.registrant.formName = this.formName
        let dateVar = new Date();
        this.registrant.timestamp = dateVar
        //add the registrant object
        simpleRegsRef.add(this.registrant)
        //then clear out the registraion and close modal
        .then( () => {
          this.registrant = {}
          this.showModal = false
        })
      },
      updateReg: function(index){
        //update the database
        simpleRegsRef.doc(this.registrant.docId).set(this.registrant, {merge:true})
        //then clear out the registraion and close modal
        .then( () => {
          this.registrant = {}
          this.showModal = false
        })
      },

      /////////// 
      //Sorting and filtering methods
      /////////// 

      //used by computed property
      sortRegs: function(sortableRegs){return sortableRegs.sort(this.compareValues(this.sortBy));
      },
      //used by computed property
      filterRegs: function(filterableRegs){return filterableRegs.filter( e => {
          //I want to search on both first name and last name          
          let searchString = e.lastName.toUpperCase() + e.firstName.toUpperCase()
          //make sure the cursor stays in the search box
          this.$nextTick(() => this.$refs.search.focus())
          //if there is not searchText, include everything
          if ( !this.searchText.length || this.searchText === "CHARISFELLOWSHIP!" ) { return true }
          //if there is a searchText only include matches
          if ( searchString.includes(this.searchText.toUpperCase()) ) { return true }
          return false
        });
      },
      //used in sorts  
      compareValues: function(key, order=this.reverse) {
        return function(a, b) {
          if(!a.hasOwnProperty(key) || !b.hasOwnProperty(key)) {
          // property doesn't exist on either object
              return 0; 
          }
          //turns each item key compared to uppercase unless it is a number  
          const varA = (typeof a[key] === 'string') ? 
          a[key].toUpperCase() : a[key];
          const varB = (typeof b[key] === 'string') ? 
          b[key].toUpperCase() : b[key];
          //set the comparison variable based on > or <
          let comparison = 0;
          if (varA > varB) {
          comparison = -1;
          } else if (varA < varB) {
          comparison = 1;
          }
          return (
          //reverse the retuned result based on the reverse data item  
          (order == false) ? (comparison * -1) : comparison
          );
        };
      },
      $sortBy: function(sortBy){
        this.reverse = (this.sortBy == sortBy) ? ! this.reverse : false;
        this.sortBy = sortBy
      },


      //////////////////
      //Modal controlls
      //////////////////

      $showModal: function() {
        this.showModal = true
        this.$nextTick(() => this.$refs.lName.focus())
      },
      closeModal: function(){
        this.showModal = false
        this.registrant = {}
      },

      ////////////////
      //Helpers
      ///////////////

      //used by the column header to set bold if selected
      colHeaderclass: function(fieldName) {
        if ( fieldName === this.sortBy ) { return "pointer bold"}
        return "pointer"
      },
      //used to make sure the last name is not repeated if the spouses full name was entered into registration
      spouseNameContainsLastName: function(reg){
        if ( !reg.spouse ) { return false }
        if ( reg.spouse.includes(reg.lastName) ) { return true } else { return false }
      },
      //Turns a valid email into a mailto link
      linkIfEmail: function(str){
        if ( this.validateEmail(str) ) {
          return '<a href="mailto:' + str + '">' + str + '<a>'
        } else { return str }
      },
      //validate email address
      validateEmail: function(email) {
        var re = /\S+@\S+\.\S+/;
        return re.test(email);
      },

      //////////////////
      //Used by created()
      //////////////////

      //Get simple regs from firestore and store them in this.simpleRegs
      getSimpleRegs: function() {
        simpleRegsRef.where("formName", "==", this.formName)
        .onSnapshot( (snap) => {
          this.simpleRegs = []
          snap.forEach( doc => {
            let obj = doc.data()
            obj.docId = doc.id
            // if ( !this.showEmail ) { obj.email = "" }
            this.simpleRegs.push(obj)
          })
        })
        return null
      },
      //Get simple regs from firestore and store them in this.simpleRegs
      getRegs: function() {
        RegsRef.onSnapshot( (snap) => {
          this.Regs = []
          snap.forEach( doc => {
            let obj = doc.data()
            obj.docId = doc.id
            this.Regs.push(obj)
          })
        })
        return null
      },
    },
    computed: {
      //filter on this.selectText then sort on this.sortBy - is used in the v-for list
      filteredSortedSimpleRegs: function() {
        return this.filterRegs(this.sortRegs(this.simpleRegs))
      },
      //create a list of email addresses for the Email All mailto link
      allEmailsList: function() {
        let allEmailsArray = this.simpleRegs.map( el => el.email )
        return allEmailsArray.join(this.delimiter)
      },
      countNames: function(){
        let spouseCount = 0
        this.filteredSortedSimpleRegs.forEach(element => {
          if ( element.spouse ) {
            spouseCount ++ 
          }
        })
        return this.simpleRegs.length + spouseCount
      }
    },
    created(){
      //get the simpleRegs on initial load
      this.getSimpleRegs()
      // this.getRegs()
    }
  })
</script>

<style scoped>
  .pointer {
    cursor: pointer 
  }
  .bold {
    font-weight: bold
  }
  .closeModal {
    text-align:right
  }
  .addIcon {
    list-style:none
  }
  .regFoxSearch {
    height:25px
  }
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  body {
    font-family: 'montserrat', sans-serif;
  }

  #app {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100vw;
    min-height: 100vh;
    overflow-x: hidden;
  }

  .button {
    appearance: none;
    outline: none;
    border: none;
    background: none;
    cursor: pointer;
    
    display: inline-block;
    padding: 15px 25px;
    background-image: linear-gradient(to right, #CC2E5D, #FF5858);
    border-radius: 8px;
    
    color: #FFF;
    font-size: 18px;
    font-weight: 700;
    
    box-shadow: 3px 3px rgba(0, 0, 0, 0.4);
    transition: 0.4s ease-out;
    
    &:hover {
      box-shadow: 6px 6px rgba(0, 0, 0, 0.6);
    }
  }

  .modal-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 98;
    background-color: rgba(0, 0, 0, 0.3);
  }

  .modal {
    position: fixed;
    top: 50%;
    left: 50%;
    margin: auto;
    transform: translate(-50%, -50%);
    z-index: 99;
    
    width: 100%;
    max-width: 400px;
    background-color: #FFF;
    border-radius: 16px;
    
    padding: 25px;
    
    h1 {
      color: #222;
      font-size: 32px;
      font-weight: 900;
      margin-bottom: 15px;
    }
    
    p {
      color: #666;
      font-size: 18px;
      font-weight: 400;
      margin-bottom: 15px;
    }
  }

  .fade-enter-active,
  .fade-leave-active {
    transition: opacity .5s;
  }

  .fade-enter,
  .fade-leave-to {
    opacity: 0;
  }

  .slide-enter-active,
  .slide-leave-active {
    transition: transform .5s;
  }

  .slide-enter,
  .slide-leave-to {
    transform: translateY(-50%) translateX(-100vw);
  }

</style>