<table class="table table-stripped">
<tr>
<th>File</th>
<th>Size</th>
</tr>
<cfoutput query="images">
<tr>
	<td>#linkto(href="/images/conference/speakers/2016/#name#", text=name)#</td>
	<td>#size#</td>
</tr>
</cfoutput>
</table>
