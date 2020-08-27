<cfparam name="params.key" default="att">

<cfoutput>
	<cfif params.key is "att">
		<h1>History for attendance</h1>
	<cfelseif params.key is "ss">
		<h1>History for small groups</h1>
	<cfelse>
		<h1>History for #params.key#</h1>
	</cfif>
	<p>
		Change report to:
		[#linkTo(Text="Attendance", key="att")#]&nbsp;
		[#linkTo(Text="Small Group/SS", key="ss")#]&nbsp;
		[#linkTo(Text="Conversion", key="conversions")#]&nbsp;
		[#linkTo(Text="Membership", key="members")#]&nbsp;
		[#linkTo(Text="Baptism", key="baptisms")#]&nbsp;
	</p>
</cfoutput>

<table class="table table-striped">
	<cfoutput>
		<tr>
			<th>Church</th>
			<cfloop list="#years#" index="i">
				<th>#i#</th>
			</cfloop>
		</tr>
	</cfoutput>

	<cfoutput query="churches" group="state_mail_abbrev">
		<tr><td colspan="8"><h2>#State#</h2></td></tr>
		<cfoutput group="id">
		<tr>
			<td>#linkTo(text=selectname, action="show", key=id)#</td>

			<cfloop list="#years#" index="i">
				<td>#churches[i]#</td>
			</cfloop>

		</tr>
		</cfoutput>
	</cfoutput>
</table>