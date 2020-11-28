<div class="container" ng-app="sendEmailApp">
<h1>Listing Send-emails</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

	<p>#linkTo(text="New Message", action="new")#</p>

	<div class="well">
<cfif usetestlist()>
	<h3>In Test Mode</h3>
	<p>using #testlist()#</p>
	<p>#linkto(text="turn off test mode", action="turnOffTestList", class="btn")#</p>
<cfelse>
	<h3>In Live Mode</h3>
	<p>will send to live list</p>
	<p>#linkto(text="turn off live mode", action="turnOnTestList", class="btn")#</p>
</cfif>
	</div>

<div ng-controller="indexController">

<div class="form-group">
	<input ng-model="query" type="text" placeholder="Search" class="input-xlarge search-query"/>
</div>

<p>&nbsp;</p>

<table class="table table-striped table-bordered table-hover">
<tr>
	<th><a href="" ng-click="sortField = 'subject'; reverse=!reverse">Subject</a></th>
	<th><a href="" ng-click="sortField = 'fromemail'; reverse=!reverse">From Email</a></th>
	<th><a href="" ng-click="sortField = 'fromname'; reverse=!reverse">From name</a></th>
	<th><a href="" ng-click="sortField = 'tags'; reverse=!reverse">Sent to Tags</a></th>
	<th><a href="" ng-click="sortField = 'strsentat'; reverse=!reverse">Sent</a></th>
	<th><a href="" ng-click="sortField = 'strcreatedat'; reverse=!reverse">Created</a></th>
	<th>&nbsp;</th>
<tr ng-repeat="message in messages | filter:query | orderBy:sortField:reverse">
	<td>
		{{message.subject}}
	</td>
	<td>
		{{message.fromemail}}
	</td>
	<td>
		{{message.fromname}}
	</td>
	<td>
		{{message.tags}}
	</td>
	<td>
		{{message.strsentat | date:'medium'}}
	</td>
	<td>
		{{message.strcreatedat}}
	</td>
	<td>#linkTo(text='Show', action='show', key='{{message.id}}')# | #linkTo(text='Edit', action='edit', key='{{message.id}}')# | #linkTo(text='Copy', action='copy', key='{{message.id}}')# | #linkTo(text='Delete', action='delete', key='{{message.id}}', confirm='Are you sure?')# | #linkTo(text='Send', action='send', key='{{message.id}}', confirm='Are you sure?')#
	</td>
</tr>
</table>
</div>
</cfoutput>


<script src="/javascripts/angular.min.js"></script>
<script src="/javascripts/sendemailsapp.js"></script>
<script src="/javascripts/sendemailscontrollers.js"></script>
<script src="/javascripts/sendemailsservices.js"></script>

</div>