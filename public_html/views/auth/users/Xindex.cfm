<!--- <cfdump var="#users#"><cfabort> --->
<div class="app container">
    <p>
        <input v-model="searchString" v-on:keyUp="onkeyup()" placeholder="Search for..." /></br>
        Search by Name, Username, Email
    </p>
    <p>Count: {{users_array.length}}</p>
    <table class="table table-striped">
    <tr>
            <th><a href="" @click.prevent="reSortBy('fullName')">Name</a></th>
            <th><a href="" @click.prevent="reSortBy('email')">Username</a></th>
            <th><a href="" @click.prevent="reSortBy('email')">EMail</a></th>
            <th><a href="" @click.prevent="reSortBy('lastLoginDate')">Last Login</a></th>
            <th><a href="" @click.prevent="reSortBy('createdDate')">Created</a></th>
            <th>&nbsp;</th>
        </tr>
        <tr v-for="user in users_array">
            <td width='30%'><a :href="showUser(user.id)">{{user.fullName}}</a></td>    
            <td>{{user.username | shorten}}</td>
            <td><a :href="mailTo(user.email)">{{user.email | shorten | lowerCase}}</a></td>
            <td>{{user.lastLoginDate}}</td>
            <td>{{user.createdDate}}</td>
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
        el: ".app",
        data: {
            message: "welcome",
            users: #users#,
            searchString: "",
            filterString: "",
            sortBy: "createdDate",
            sortOrder: "desc",
            showIcon: "<i class='fa fa-search'></i>",
            loginAsIcon: "<i class='fa fa-user-o'></i>",
            shortened: 20,
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
                    if(item.fullName.toLowerCase().indexOf(searchString) !== -1 ||
                        item.username.toLowerCase().indexOf(searchString) !== -1 ||
                        item.email.toLowerCase().indexOf(searchString) !== -1 ||
                        item.createdDate.toLowerCase().indexOf(searchString) !== -1 ||
                        item.lastLoginDate.toLowerCase().indexOf(searchString) !== -1 
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
                return "?controller=auth.users&action=show&key=" + user.id;
            },
            loginAsUser: function(user){
                return "?controller=auth.users&action=login-as-user&username=" + user.username + "&userid=" + user.id + "&email=" + user.email;
            },
            loginAsTitle: function(user) {
                return "Login as " + user.fname;
            }
        },
        filters: {
            shorten: function(string){
                return string.slice(0,this.shortened);
            },
            lowerCase: function(string){
                return string.toLowerCase();
            }
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