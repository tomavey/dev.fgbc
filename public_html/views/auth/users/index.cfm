<!--- <cfdump var="#users#"><cfabort> --->
<!--- <p>Is this showing?</p> --->
<div class="container" id="usersApp">
    <p>
        <input v-model="searchString" v-on:keyUp="onkeyup()" placeholder="Search for..." /></br>
        Search by Name, Username, Email
    </p>
    <p>Count: {{users_array.length}}</p>
    {{searchString}}{{filterString}}
    {{users[0]}}
    <table class="table table-striped">
    <tr>
            <th><a href="" @click.prevent="reSortBy('FULLNAME')">Name</a></th>
            <th><a href="" @click.prevent="reSortBy('USERNAME')">Username</a></th>
            <th><a href="" @click.prevent="reSortBy('EMAIL')">EMail</a></th>
            <th><a href="" @click.prevent="reSortBy('LASTLOGINAT')">Last Login</a></th>
            <th><a href="" @click.prevent="reSortBy('CREATEDAT')">Created</a></th>
            <th>&nbsp;</th>
        </tr>
        <tr v-for="user in users_array" :key=user.EMAIL>
            <td width='30%'><a :href="showUser(user.ID)">{{user.FULLNAME}}</a></td>    
            <td>{{user.USERNAME | shorten}}</td>
            <td><a :href="mailTo(user.EMAIL)">{{user.EMAIL | shorten | lowerCase}}</a></td>
            <td>{{fbDateFormat(user.LASTLOGINAT)}}</td>
            <td>{{fbDateFormat(user.CREATEDAT)}}</td>
            <td>
                <a :href="showUser(user)" v-html="showIcon"></i></a>
                <a :href="loginAsUser(user)" v-html="loginAsIcon" :title="loginAsTitle(user)"></i></a>
            </td>
        </tr>
    </table>

</div>

<cfoutput>

<script>
    var vm = new Vue({
        el: "##usersApp",
        data() { 
            return {
                message: "welcome",
                users: #users#,
                searchString: "",
                filterString: "",
                sortBy: "createdDate",
                sortOrder: "desc",
                showIcon: "<i class='fa fa-search'></i>",
                loginAsIcon: "<i class='fa fa-user-o'></i>",
                shortened: 20,
                months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
            }
        },
        methods: {
            onkeyup: _.debounce(function(){
                this.filterString = this.searchString;
                this.columnsClass = "";
            },200),
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
            filterUsers: function(){
                var searchString = this.filterString,
                    users_array = this.users
                if(!searchString){
                    return users_array;
                }
                searchString = searchString.trim().toLowerCase();
                    users_array = users_array.filter(function(item){
                    if(item.FULLNAME.toLowerCase().indexOf(searchString) !== -1 ||
                        item.USERNAME.toLowerCase().indexOf(searchString) !== -1 ||
                        item.EMAIL.toLowerCase().indexOf(searchString) !== -1 ||
                        item.CREATEDAT.toLowerCase().indexOf(searchString) !== -1 ||
                        item.LASTLOGINAT.toLowerCase().indexOf(searchString) !== -1 
                        ){
                        return item
                    }
                    })
                    return users_array;
            },
            sortUsers: function(){return this.users.sort(this.compareValues(this.sortBy));
            },
            reSortBy: function(value){
                this.sortBy = value;
                if (this.sortOrder == 'desc')
                    {this.sortOrder = 'asc'}
                else {this.sortOrder = 'desc'};
            },
            mailTo: function(email){
                return "mailto:" + email
            },
            showUser: function(user){
                return "?controller=auth.users&action=show&key=" + user.ID;
            },
            loginAsUser: function(user){
                return "?controller=auth.users&action=login-as-user&username=" + user.USERNAME + "&userid=" + user.ID + "&email=" + user.EMAIL;
            },
            loginAsTitle: function(user) {
                return "Login as " + user.FNAME;
            },
            formatDate: function (value) {
                let months = this.months
                let oldDate = value.toString()
                oldDate = oldDate.replace('{ts ', '').replace('}', '').replace(' 00:00:00', '')
                var d = new Date(oldDate)
                console.log(months[d.getMonth()])
                return months[d.getMonth()] + d.getDate() + d.getFullYear()
            },
            fbDateFormat: function (date) {
                const d = new Date(date)
                let m = this.months
                return m[d.getMonth()] + ' ' + d.getDate() + ', ' + d.getFullYear()
            },
        },
        filters: {
            shorten: function(string){
                return string.slice(0,this.shortened);
            },
            lowerCase: function(string){
                return string.toLowerCase();
            },
        },
        computed: {
            users_array: function(){
                var array = [];
                array = this.sortedUsers;
                array = this.filterUsers(array);
                return array;
            },
            filteredUsers: function(){
                return this.filterUsers();
            },
            sortedUsers: function(){
                return this.sortUsers();
            }    
        }
    })

</script>

</cfoutput>