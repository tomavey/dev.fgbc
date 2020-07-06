<cfoutput>
<h1>Listing registrants since </h1>

<table>
	<tr>
		<th>
			Name
		</th>
		<th>
			Email
		</th>
		<th>
			Phone
		</th>
		<th>
			Roommate
		</th>
		<th>
			&nbsp;
		</th>
	</tr>
	<cfloop query="registrants">
		<tr>
			<td>
				#lname#, #fname#
			</td>
			<td>
				#mailto(email)#
			</td>
			<td>
				#phone#
			</td>
			<td>
				#roommate#
			</td>
			<td>
				#editTag()# 
				#deleteTag()# 
				#showtag()#
			</td>
		</tr>
	</cfloop>
</table>

	<p>#linkTo(text="New registrant", action="new")#</p>
</cfoutput>
