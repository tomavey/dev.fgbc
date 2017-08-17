<cfparam name="count" default="0">
<cfoutput>
	#linkto(text="<i class='icon-download-alt'></i>", action="list", params="download=1&excel=1", class="tooltipleft btn download", title="Download this list as an excel spreadsheet after review")#
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
				Phone
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
				Church State
			</th>
			<th>
				Church Zip
			</th>
			<th>
				Started in Ministry
			</th>
			<th>
				For certificate
			</th>
		</tr>
	</thead>

	<tbody>
		<cfoutput query="people">
    		#includePartial("downloadtable")#
			<cfset count = count + 1>
		</cfoutput>
	</tbody>
</table>
Count= #count#
</cfoutput>
<script>
alert("Use block-all (ctrl-A) then copy (ctrl-C) then paste (ctrl-V) in your spreadsheet.");
</script>
