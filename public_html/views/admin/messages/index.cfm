<cfoutput>
<div class="container">

<h1>Listing messages</h1>

<form>
	<input type="text" placeholder="Search" name="search">
</form>
#linkto(text="Show All", params="showall=true")#

<table class="table">
	<tr>
		<th>
			Name
		</th>
		<th>
			Email
		</th>
		<th>
			Message
		</th>
		<th>
			Date
		</th>
		<th>
			&nbsp;
		</th>
	</tr>
<cfoutput query="messages">
	<tr>
		<td>
			#name#
		</td>
		<td>#mailto(email)#</td>
		<td>#left(message,20)#
		</td>
		<td>
			#dateFormat(updatedAt)#
		</td>
		<td>
			#editTag()##ShowTag()##DeleteTag()#
		</td>
	</tr>
</cfoutput>
</table>

	<p>#addTag()#</p>

</div>
</cfoutput>
