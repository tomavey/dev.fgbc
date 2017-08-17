<cfoutput>
	<h2>Registrations through #monthasstring(month(now()))# #day(now())#</h2>
	<table class="table">
		<tr>
			<th>&nbsp;</th>
			<th>Northwest</th>
			<th>Central</th>
			<th>East</th>
			<th>Southwest</th>
			<th>South</th>
		</tr>
		<tr>
			<td>2016/17</td>
			<td>&nbsp;</td>
			<td>#regs.central16total#</td>
			<td>#regs.east16total#</td>
			<td>#regs.southwest17total#</td>
			<td>#regs.south17total#</td>

		</tr>
		<tr>
			<td>2015/16</td>
			<td>#regs.northwest15total#</td>
			<td>#regs.central15total#</td>
			<td>#regs.east15total#</td>
			<td>#regs.southwest16total#</td>
			<td>#regs.south16total#</td>

		</tr>
		<tr>
			<td>2014/15</td>
			<td>#regs.northwest14btotal#</td>
			<td>#regs.central14total#</td>
			<td>#regs.east14total#</td>
			<td>#regs.southwest15total#</td>
			<td>#regs.south15total#</td>

		</tr>
		<tr>
			<td>2013/14</td>
			<td>#regs.northwest14total#</td>
			<td>#regs.central13total#</td>
			<td>#regs.east13total#</td>
			<td>#regs.southwest14total#</td>
			<td>#regs.south14total#</td>

		</tr>
		<tr>
			<td>2012/13</td>
			<td>#regs.northwest13total#</td>
			<td>#regs.central12total#</td>
			<td>#regs.east12total#</td>
			<td>#regs.southwest13total#</td>
			<td>#regs.northwest13total#</td>
		</tr>
	</table>

</cfoutput>