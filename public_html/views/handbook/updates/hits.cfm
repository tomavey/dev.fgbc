<cfparam name="params.previouspage" default=0>
<cfparam name="params.nextpage" default=0>

<cfoutput>			
<cfif isDefined("params.email")>		
<h3>Page Views for #mailto(params.email)#</h1>
<cfelse>
<h3>All Page Views</h1>
<p>Click on a Use email to see all page views by that person.</p>
</cfif>

		#includePartial(partial="/_shared/paginationlinks")#


</cfoutput>

<table class="table">
<tr>
<th>
Date
</th>
<th>
User
</th>
<th>
Controller
</th>
<th>
Action
</th>
<th>
Key
</th>
</tr>
<cfoutput query="hits">
<tr>
<td>
#dateformat(createdAt)#
</td>
<td>
#linkTo(text=email, action="hits", params="email=#email#")#
</td>
<td>
#controller#
</td>
<td>
#action#
</td>
<td>
#paramskey#
</td>
<td>
#linkTo(text="<i class='icon-share'></i>", controller=#controller#, action=#action#, key=#paramskey#, class="tooltipside", title="View this page")#
</td>
</tr>
</cfoutput>
</table>
