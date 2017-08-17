<div ng-app="lodgingRequestsApp">
<cfoutput>

<div ng-controller="indexController" class="row-fluid well contentStart contentBg">
<div class="form-group">
    <input ng-model="query" type="text" placeholder="Search" class="input-xlarge search-query"/>
</div>

<cfif gotRights("office")>
<p>&nbsp;</p>
#linkto(text="Start a New Request for Conference Lodging Assistance", controller="conference.lodgingRequests", action="new", class="btn btn-block")#
</cfif>

<p>&nbsp;</p>
<table class="table table-striped table-bordered table-hover" ng-init="lodgingRequests.total = {}">
<tr>
    <th><a href="" ng-click="sortField = 'name'; reverse=!reverse">Name</a></th>
    <th><a href="" ng-click="sortField = 'email'; reverse=!reverse">Email</a></th>
    <th><a href="" ng-click="sortField = 'phone'; reverse=!reverse">Comment</a></th>
    <th><a href="" ng-click="sortField = 'date'; reverse=!reverse">Created</a></th>
    <th><a href="" ng-click="sortField = 'officebudget'; reverse=!reverse">Budget</a></th>
    <th>&nbsp;</th>
</tr>
<tr ng-show='!lodgingRequests.length'><td>Loading...</td></tr>
<tr ng-repeat="lodgingRequest in lodgingRequests | filter:query | orderBy:sortField:reverse">
    <td ng-init="lodgingRequests.total.name = lodgingRequests.total.name + 1">
        <a href="/index.cfm/conference.lodgingRequests/show?id={{lodgingRequest.$id}}">{{lodgingRequest.name}}</a>
    </td>
    <td>
        <a href="mailto:{{lodgingRequest.email}}">{{lodgingRequest.email}}</a>
    </td>
    <td ng-bind-html="lodgingRequest.officecomments">
    </td>
    <td>
        {{lodgingRequest.datetime | date:'MM/dd/yyyy @ h:mma'}}
    </td>
    <td ng-init="lodgingRequests.total.officebudget = lodgingRequests.total.officebudget + lodgingRequest.officebudget">
        {{lodgingRequest.officebudget}}
    </td>
    <td><a href="/index.cfm/conference.lodgingRequests/show?id={{lodgingRequest.$id}}">Show</a>
    <cfif gotRights("office")>
         | <a href="/index.cfm/conference.lodgingRequests/new?id={{lodgingRequest.$id}}">Edit</a> | <a href="" ng-click="removeLodgingRequest(lodgingRequest)">Delete</a> | <a href="mailto:{{lodgingRequest.email}}&body=Information%20about%20your%20lodging%20assistance%20request%20(see%20the%20comments%20box):%20http://www.fgbc.org/conference.lodgingrequests/show%3Fid={{lodgingRequest.$id}}&subject=Your%20Vision%20Conference%20Lodging">Email</a>
     </cfif>
    </td>
</tr>
<tr>
    <td>
        {{lodgingRequests.total.name}}
    </td>
    <td>
        &nbsp;
    </td>
    <td>
        &nbsp;
    </td>
    <td>
        &nbsp;
    </td>
    <td>
        {{lodgingRequests.total.officebudget}}
    </td>
    <td>
        &nbsp;
    </td>
</tr>
</table>
</div>
</div>

#includePartial("scripts")#

</cfoutput>

</div>

