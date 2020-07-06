<cfoutput>
<div>
	#linkto(text="use #params.key-1# stats", class="btn", action="sizeByPercent", key=#params.key-1#)#
</div>	
</cfoutput>
<table class="table">
<cfoutput>
	<tr>
		<td>
			XX Large churches (top 10% / #attributes.xxlarge.count#)
		</td>
		<td>
			#numberformat(attributes.xxlarge.total,",")#
		</td>
	</tr>
	<tr>
		<td>
			XLarge (next 10%)
		</td>
		<td>
			#numberformat(attributes.xlarge.total)#
		</td>
	</tr>
	<tr>
		<td>
			Large (next 30%)
		</td>
		<td>
			#numberformat(attributes.large.total)#
		</td>
	</tr>
	<tr>
		<td>
			Medium  (next 25%)
		</td>
		<td>
			#numberformat(attributes.medium.total)#
		</td>
	</tr>
	<tr>
		<td>
			Smaller Churches (next 25%)
		</td>
		<td>
			#numberformat(attributes.small.total)#
		</td>
	</tr>
	<tr>
		<td>
			Total attendance
		</td>
		<td>
			#numberFormat(attributes.xxlarge.total +
							attributes.xlarge.total +
							attributes.large.total +
							attributes.medium.total +
							attributes.small.total,",")#
		</td>
	</tr>
	<tr>
		<td>
			Total Count =
		</td>
		<td>
			#attributes.all.recordcount#
		</td>
	</tr>
</cfoutput>
</table>
<table class="table">
	<thead>
		<tr>
			<td>&nbsp;</td>
			<td>
				Church
			</td>
			<td>
				Attendance
			</td>
		</tr>
	</thead>
	<tbody>
		<cfoutput query="attributes.all">
			<tr>
				<td>#currentrow#</td>
				<td>#linkTo(text="#name#; #org_city#, #state_mail_abbrev#", controller="handbook.organizations", action="show", key=organizationid)#</td>
				<td>#att#</td>
			</tr>
		</cfoutput>
	</tbody>
</table>
