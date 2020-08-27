<cfparam name="reportTitle" default="Listing Registrations:">
<cfoutput>
	<h1>#reportTitle#</h1>
</cfoutput>

<table>
	<cfoutput query="registrations" group="itemid">
		<tr>
			<td colspan="2">
				<h2>#linkTo(text=description, controller="focus", action="registrations", params="itemid=#itemid#")#</h2>
			</td>
		</tr>
		<cfset count=0>
		<cfoutput>
			<cfset count = count +1>
			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					#fname# #lname# 
					<cfif len(roommate)>
					<span class="roommate"><i>[#roommate#]</i></span>
					</cfif>
				</td>
			</tr>	
		</cfoutput>
			<tr>
				<td>
					Count= #count#
				</td>
				<td>
					&nbsp;
				</td>
			</tr>	
			
	</cfoutput>
	</table>


