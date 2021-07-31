<div class="postbox" id="#params.controller##params.action#">

<h1>Listing messages</h1>

<table>
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
			<span class="expand">
				#message#
			</span>
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

<cfoutput>
	<p>#addTag()#</p>
</cfoutput>

</div>