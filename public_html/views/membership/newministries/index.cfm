<div id="newMinistriesApp" class="container">
<p>{{message}}</p>
<cfoutput>

<div class="row-fluid well contentStart contentBg">

<my-component></my-component>    

<div class="form-group">
    <input v-model="query" @keyup="onKeyUp" type="text" placeholder="Search" class="input-xlarge search-query"/>
</div>

<cfif gotRights("office")>
    <p>&nbsp;</p>
    #linkto(text="Start a New Cooperating Ministry Application", controller="membership.newministries", action="new", class="btn btn-block")#
</cfif>

<p>&nbsp;</p>
<table class="table table-striped table-bordered table-hover">
<tr>
    <th ><a href="" @click.prevent="reSortBy('name')">Ministry Name</a></th>
    <th><a href="" @click.prevent="reSortBy('email')">Contact Email</a></th>
    <th><a href="" @click.prevent="reSortBy('datetime')">Created</a></th>
    <th><a href=""  @click.prevent="reSortBy('updatedAt')">Updated</a></th>
    <th>&nbsp;</th>
</tr>
<tr v-show='!ministries.length'><td>Loading...</td></tr>
<tr v-for="ministry in filteredMinistriesArray">
    <td>
        <a :href="show(ministry['.key'])">{{ministry.name}}</a>
    </td>
    <td>
        <a :href="mailTo(ministry.contactemail)">{{ministry.contactemail}}</a>
    </td>
    <td>
        {{ministry.datetime | dateFormat}}
    </td>
    <td>
        {{ministry.updatedAt | dateFormat}}
    </td>
    <td><a :href="show(ministry['.key'])">Show</a>
    <cfif gotRights("office")>
         | <a :href="edit(ministry['.key'])">Edit</a> | 
         <a :href="remove(ministry['.key'])">Delete</a> | 
         <a :href="mailTo(ministry.contactemail)">Email</a>
     </cfif>
    </td>
</tr>
</table>
</div>
</div>

#includePartial("scripts")#

</cfoutput>

</div>

