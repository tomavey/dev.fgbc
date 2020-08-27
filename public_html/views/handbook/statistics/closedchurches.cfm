<cfoutput>
<h2>Churches that changed from membership status to another status since August 1, #year(now())-1#</h2>
</cfoutput>

<table class="table table-striped">
<thead>
<tr>
<th>&nbsp;</th>
<th>Church</th>
<th>New Status</th>
<th>Date</th>
</thead>
<tbody>
<cfoutput query="churches">
<tr>
<td>#currentRow#</td>
<td>#selectName#</td>
<td>#getStatus(newdata)#</td>
<td>#dateformat(createdAt)#</td>
</tr>
</cfoutput>
<tbody>
</table>
<p>Note: Some changes may be due to re-designation of lead campus (ie: Grace Church, Norton in 2012)</p>