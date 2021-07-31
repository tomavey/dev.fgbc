<cfparam name="count" default="0">
<cfparam name="hideLastPayment" default=false>
<cfif isDefined("params.hideLastPayment")>
	<cfset hideLastPayment = true>
</cfif>

<cfoutput>

	#linkToPlus(
		text="DOWNLOAD AS EXCEL", 
		addParams="excel=true", 
		class="tooltipleft btn download", 
		title="Download this list as an excel spreadsheet after review",
		showIf=!isDefined("params.excel")
		)#
<br/>
	<cfif gotRights("superadmin,agbmadmin")>
	#linkToPlus(
		text="Hide Last Payment Column", 
		addParams="hideLastPayment=true", 
		class="tooltipleft btn download", 
		title="Hide Last Payment Column ",
		showIf=!isDefined("params.hideLastPayment")
		)#
	</cfif>	
	
			<table class="table table-stripped">
	<thead>
		<tr>
			<th>
				Inspire ID
			</th>
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
				Church Email
			</th>
			<th>
				Started in Ministry
			</th>
			<cfif showAge>
			<th>
				BirthYear
			</th>
			</cfif>
			<th>
				For certificate
			</th>
			<th>
				Category
			</th>
			<cfif gotRights("superadmin,agbmadmin") && ! hideLastPayment>
				<th>
					Last Payment
				</th>
			</cfif>
		</tr>
	</thead>

	<tbody>
		<cfoutput query="people">
    		#includePartial(partial="downloadtable")#
			<cfset count = count + 1>
		</cfoutput>
	</tbody>
</table>
Count= #count#
</cfoutput>
<script>
alert("If DOWNLOAD AS EXCEL does not work properly, use block-all (ctrl-A) then copy (ctrl-C) then paste (ctrl-V) in your spreadsheet.");
</script>
