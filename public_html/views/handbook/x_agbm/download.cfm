<cfparam name="count" default="0">
<cfoutput>
<table class="table table-stripped">
	<thead>
		<tr>
			<th>
				First Name
			</th>
			<th>
				Last Name
			</th>
			<th>
				Address1
			</th>
			<th>
				Address2
			</th>
			<th>
				City
			</th>
			<th>
				State
			</th>
			<th>
				Zip
			</th>
			<th>
				Email
			</th>
			<th>
				Email2
			</th>
			<th>
				Phone
			</th>
			<th>
				Phone2
			</th>
			<th>
				District
			</th>
			<th>
				Church
			</th>
			<th>
				Church Address1
			</th>
			<th>
				Church Address2
			</th>
			<th>
				Church City
			</th>
			<th>
				Birthday
			</th>
			<th>
				Birthyear
			</th>
		</tr>
	</thead>

	<tbody>
		<cfoutput query="people">
    		#includePartial(partial="downloadtable")#
		</cfoutput>
	</tbody>
</table>
Count= #count#
</cfoutput>