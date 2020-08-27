 /* global Vue, firebase */
var db = firebase.initializeApp({
databaseURL: 'https://vivid-torch-5264.firebaseio.com/'
}).database()
var ministriesRef = db.ref('ministries')

Vue.component('my-component', {
template: '<div><a href="" @click.prevent="onAlert">My Component</a> {{message}} </div>',
data: function(){return {message:"Welcome to Component"}},
props: ['query'],
methods: {
    onAlert: function(){alert("Hi")},
}
})

function formatDate2(thisdate){
    var monthNames = [
        "Jan.", "Feb.", "Mar.",
        "Apr.", "May", "June", "July",
        "Aug.", "Sept.", "Oct.",
        "Nov.", "Dec."
      ];
    var date = new Date(thisdate);      
    var day = date.getDate();
    var monthIndex = date.getMonth();
    var year = date.getFullYear();
    var dateformatted = monthNames[monthIndex] + " " + day + ', ' + year;
    return dateformatted
}

function $_GET(q,s) {
    s = (s) ? s : window.location.search;
    var re = new RegExp('&amp;'+q+'=([^&amp;]*)','i');
    return (s=s.replace(/^\?/,'&amp;').match(re)) ?s=s[1] :s='';
}

var vm = new Vue({
    el: "#newMinistriesApp",
    firebase: {
        ministries: ministriesRef,
        },
    filters: {
        dateTimeFormat: function(value) {
            if (value) {
              var date = new Date(value);      
              return date.getDate()
            }
        },
        dateFormat: function(value){
            return this.formatDate2(value);
        },
    },
    computed: {
        ministriesArray: function(){return this.ministries.sort(this.compareValues(this.sortBy));
        },
        filteredMinistriesArray: function(){return this.filterMinistries(this.ministriesArray)},
        idFromParams: function(){
            return $_GET('reload');
        },
    },
    data: {
        message: "Welcome",
        ministry: {},
        ministryForm: {},
        url: "",
       pparams: "",
        query: "",
        filterString: "",
        sortBy: "name",
        sortOrder: "asc",
        id: "",
        questions: {
        "contactemail": "Your email address",
        "name": "Official Ministry Name",
        "address1": "Ministry Address",
        "address2": "Ministry Address",
        "city": "Ministry City",
        "state": "Ministry State",
        "zip": "Ministry Zip",
        "phone": "Ministry Phone",
        "email": "Ministry Email",
        "website": "Ministry Website",
        "officers": "List the present responsible officers of the ministry with titles:",
        "priorities": "Read the Charis Commitment to Common Ministry (<a href='http://fgbc.org/files/OurCommitmentToCommonMission.pdf' target='_new'>fgbc.org/files/OurCommitmentToCommonMission.pdf</a>).  Which of the listed ministry priorities does your ministry pursue? How?",
        "harmony": "Does your ministry agree to live harmoniously under the Covenant and Statement of Faith as found in Article III of the Constitution of the Fellowship of Grace Brethren Churches, Inc.?",
        "sponsored": "The FGBC Manual of Procedure says a cooperating ministry '... must be sponsored by at least four FGBC churches or controlled by members of FGBC churches.' List at least four FGBC churches that sponsor your ministry (ie: through gifts or active involvement) or describe how your ministry is controlled by members of FGBC churches (ie: board membership, or corporation membership).",
        "association": "Is this ministry a result of work or association with a current Grace Brethren Church, another FGBC National or Cooperating ministry, FGBC district or some other previous connection with FGBC churches? If so, describe that association.",
        "scope": "Does this ministry must have a scope of ministry broader than the immediate local church ministries? How does it serve multiple Grace Brethren Churches?",
        "greatcommission": "How does this ministry meet a recognized need related to the fulfilling of the Great Commission?",
        "unity": "Unity is imperative to the health of the FGBC family. With this in mind, is there any unhealthy, unresolved conflict in violation with the spirit of Ephesians 4:29-5:2 between your ministry or organization and any other individual, ministry organization, past employer or past partnership that ought to be reconciled?  If asked would any other FGBC individual, local church, district or cooperating ministry protest or disclose any unresolved conflict which would hinder your ability to function as a cooperating ministry in the future?  If so, are you open to working through resolution in the spirit of Matthew 18:15-20 as part of this application process?",
        "obligation": "In seeking to be a cooperating ministry of the Fellowship of Grace Brethren Churches, does this ministry recognize the obligation of mutual encouragement and cooperation with Grace Brethren churches, districts, national ministries and/or other cooperating ministries?",
        "review": "Please review the Constitution and Manual of Procedure for the Fellowship of Grace Brethren Churches. Note carefully ARTICLE II and ARTICLE III of the Constitution and ARTICLE VI of the Manual of Procedure, which deal with the cooperation ministry requirements.",
        "MOP": " If accepted by the procedures outlined in ARTICLE X, Section 2 of the Manual of Procedure and the ministry becomes recognized as cooperating ministry of the Fellowship of Grace Brethren Churches, Inc., does the ministry understand that :",
        "creation": "It is not a creation of the FGBC ? (Yes or No)",
        "integral": "It is not an integral part of the FGBC? (Yes or No)",
        "controlled": "It is not in any way controlled by the FGBC or Fellowship Conference? (Yes or No)",
        "report": "The Fellowship Conference asks for an annual report only as a courtesy?  (Yes or No)",
        "history": "Please provide brief history and description of the ministry:",
        "submit": "Submit"
        },
    },
    methods: {
        showForm: function(){
            return true
        },
        addMinistry: function(){
            console.log("worked")
        },
        mailTo: function(email){
            return "mailto:" + email
        },
        show: function(id){
            return "?controller=membership.newministries&action=show&$id=" + id
        },
        edit: function(id){
            return "?controller=membership.newministries&action=edit&$id=" + id
        },
        remove: function(id){
            return "?controller=membership.newministries&action=delete&$id=" + id
        },
        reSortBy: function(value){
            this.sortBy = value;
            if (this.sortOrder == 'desc')
                {this.sortOrder = 'asc'}
            else {this.sortOrder = 'desc'};
        },
        onMouseOver: function(){
            this.message = "Searching..."
        },
        onKeyUp: _.debounce(function(){
            this.filterString = this.query;
            console.log(this.filterString);
            this.message="Filtered list";
            },300),
        filterMinistries: function(){
            var searchString = this.filterString,
                ministries_array = this.ministries, 
                formatDate = this.formatDate;
            if(!searchString){
                return ministries_array;
            }
            searchString = searchString.trim().toLowerCase();

            ministries_array = ministries_array.filter(function(item){
                var dateFormatted = formatDate(item.datetime);
                var updatedAtFormatted = formatDate(item.updatedAt);

                if(item.name.toLowerCase().indexOf(searchString) !== -1 || 
                    item.contactemail.toLowerCase().indexOf(searchString) !== -1 ||
                    dateFormatted.toLowerCase().indexOf(searchString) !== -1 ||
                    updatedAtFormatted.toLowerCase().indexOf(searchString) !== -1 )
                    {
                    return item;
                }
            })

            return ministries_array;    

        },
        formatDate: function(value){
            var monthNames = [
              "Jan.", "Feb.", "Mar.",
              "Apr.", "May", "June", "July",
              "Aug.", "Sept.", "Oct.",
              "Nov.", "Dec."
            ];
          
            var date = new Date(value);      
            var day = date.getDate();
            var monthIndex = date.getMonth();
            var year = date.getFullYear();
          
            return monthNames[monthIndex] + " " + day + ', ' + year;
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
    created: function(){
        console.log(this.ministries);
    },
    mounted: function(){
        var pairs = location.search.slice(1).split('&');
        var result = {};
        pairs.forEach(function(pair){
            pair = pair.split('=');
            result[pair[0]] = decodeURIComponent(pair[1] || '');
        })

        this.params = JSON.parse(JSON.stringify(result));
    },
})
