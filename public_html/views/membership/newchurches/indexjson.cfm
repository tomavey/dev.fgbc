 <link rel="stylesheet" type="text/css" href="bootstrap.css">
 <link rel="stylesheet" type="text/css" href="angular-tooltips.min.css">
 <div ng-app="crudApp">
    <div class="row-fluid well contentStart contentBg" ng-controller="indexController">

        <div class="form-group">
            <input ng-model="query" type="text" placeholder="Search" class="input-xlarge search-query"/>

    <cfif gotRights("office")>
        <cfoutput>
            #linkto(text="New", controller="crud", action="new", class="btn pull-right")#
        </cfoutput>
    </cfif>
        </div>
        <div>&nbsp;</div>

            <table class="table">
        <tr>
            <th>
                <a href="" ng-click="sortField = 'name'; reverse=!reverse">Name <span ng-show="sortField==='name'"><i  class="icon-arrow-down" ng-show="!reverse"></i><i  class="icon-arrow-up" ng-show="reverse"></i></span></a>
             </th>
            <th>
                <a href="" ng-click="sortField = 'datetime'; reverse=!reverse">Date <span ng-show="sortField==='datetime'"><i  class="icon-arrow-down" ng-show="!reverse"></i><i  class="icon-arrow-up" ng-show="reverse"></i></span></a>
             </th>
             <th>
                <a href="" ng-click="sortField = 'email'; reverse=!reverse">Email <span ng-show="sortField==='email'"><i  class="icon-arrow-down" ng-show="!reverse"></i><i  class="icon-arrow-up" ng-show="reverse"></i></span></a>
             </th>
             <th>
                &nbsp;
             </th>
          </tr>
          <tr ng-repeat="answer in answers | filter:query | orderBy:sortField:reverse">
            <td>
                {{answer.name}}
             </td>
             <td>
                {{answer.date}}
             </td>
             <td>
                {{answer.email}}
             </td>
            <td>
                <a href="/index.cfm/crud/show?id={{answer.$id}}"><i class="icon-search"></i></a>&nbsp;
                <cfif gotRights("office")>
                     <a href="/index.cfm/crud/new?id={{answer.$id}}"><i class="icon-edit"></i></a>&nbsp;<a href="" ng-click="removeAnswer(answer)"><i class="icon-trash"></i></a>&nbsp;<a href="mailto:{{answer.email}}&body=http://www.fgbc.org/crud/new%3fid={{answer.$id}}"><i class="icon-envelope"></i></a>
                 </cfif>
            </td>
           </tr>
           </table>
    </div>
</div>
<cfoutput>
    #includePartial('scripts')#
</cfoutput>
