<div ng-app="newMinistriesApp">
<cfoutput>

<div ng-controller="indexController" class="row-fluid well contentStart contentBg">
<div class="form-group">
    <input ng-model="query" type="text" placeholder="Search" class="input-xlarge search-query"/>
</div>

<cfif gotRights("office")>
<p>&nbsp;</p>
#linkto(text="Start a New Cooperating Ministry Application", controller="membership.newministries", action="new", class="btn btn-block")#
</cfif>

<p>&nbsp;</p>
<table class="table table-striped table-bordered table-hover">
<tr>
    <th><a href="" ng-click="sortField = 'name'; reverse=!reverse">Ministry Name</a></th>
    <th><a href="" ng-click="sortField = 'contactemail'; reverse=!reverse">Contact Email</a></th>
    <th><a href="" ng-click="sortField = 'date'; reverse=!reverse">Created</a></th>
    <th><a href="" ng-click="sortField = 'updatedAt'; reverse=!reverse">Updated</a></th>
    <th>&nbsp;</th>
</tr>
<tr ng-show='!ministries.length'><td>Loading...</td></tr>
<tr ng-repeat="ministry in ministries | filter:query | orderBy:sortField:reverse">
    <td>
        <a href="/index.cfm/membership.newministries/show?id={{ministry.$id}}">{{ministry.name}}</a>
    </td>
    <td>
        <a href="mailto:{{ministry.contactemail}}">{{ministry.contactemail}}</a>
    </td>
    <td>
        {{ministry.datetime | date:'MM/dd/yyyy @ h:mma'}}
    </td>
    <td>
        {{ministry.updatedAt | date:'MM/dd/yyyy @ h:mma'}}
    </td>
    <td><a href="/index.cfm/membership.newministries/show?id={{ministry.$id}}">Show</a>
    <cfif gotRights("office")>
         | <a href="/index.cfm/newministry?id={{ministry.$id}}">Edit</a> | <a href="" ng-click="removeMinistry(ministry)">Delete</a> | <a href="mailto:{{ministry.contactemail}}&body=http://www.fgbc.org/newministry/new%3fid={{ministry.$id}}">Email</a>
     </cfif>
    </td>
</tr>
</table>
</div>
</div>

#includePartial("scripts")#

</cfoutput>

</div>

