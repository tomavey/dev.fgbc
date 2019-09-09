<cfparam name="asof" default="#now()#">
<cfparam name="year" default = "#year(now())#">

<cfoutput>
	<h2>Registrations through #monthasstring(month(asof))# #day(asof)#</h2>
	<table class="table">
		<tr>
			<th>&nbsp;</th>
			<th>Central</th>
			<th>East</th>
			<th>Southwest</th>
			<th>South</th>
			<th>Northwest</th>
		</tr>
		<tr>
			<td>2019/20</td>
			<td>#regs.central19total#</td>
			<td>#regs.east19total#</td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td>2018/19</td>
			<td>#regs.central18total#</td>
			<td>#regs.east18total#</td>
			<td>#regs.southwest19total#</td>
			<td>#regs.south19total#</td>
			<td>#regs.northwest19total#</td>
		</tr>
		<tr>
			<td>2017/18</td>
			<td>#regs.central17total#</td>
			<td>#regs.east17total#</td>
			<td>#regs.southwest18total#</td>
			<td>#regs.south18total#</td>
			<td>#regs.northwest18total#</td>

		</tr>
		<tr>
			<td>2016/17</td>
			<td>#regs.central16total#</td>
			<td>#regs.east16total#</td>
			<td>#regs.southwest17total#</td>
			<td>#regs.south17total#</td>
			<td>#regs.northwest17total#</td>

		</tr>
		<tr>
			<td>2015/16</td>
			<td>#regs.central15total#</td>
			<td>#regs.east15total#</td>
			<td>#regs.southwest16total#</td>
			<td>#regs.south16total#</td>
			<td>#regs.northwest15total#</td>

		</tr>
		<!--- <tr>
			<td>2014/15</td>
			<td>#regs.central14total#</td>
			<td>#regs.east14total#</td>
			<td>#regs.southwest15total#</td>
			<td>#regs.south15total#</td>
			<td>#regs.northwest14btotal#</td>

		</tr>
		<tr>
			<td>2013/14</td>
			<td>#regs.central13total#</td>
			<td>#regs.east13total#</td>
			<td>#regs.southwest14total#</td>
			<td>#regs.south14total#</td>
			<td>#regs.northwest14total#</td>

		</tr>
		<tr>
			<td>2012/13</td>
			<td>#regs.central12total#</td>
			<td>#regs.east12total#</td>
			<td>#regs.southwest13total#</td>
			<td>#regs.northwest13total#</td>
			<td>#regs.northwest13total#</td>
		</tr> --->
	</table>

#linkTo(text="Total Regs for completed retreats", action="summary", params="asof=July 1, #year+1#")# |
#linkTo(text="Regs through Today", action="summary")#

<!---
| 
#linkTo(text="February  1", action="summary", params="asof=February 1, #year#")# | 
#linkTo(text="April  1", action="summary", params="asof=April 1, #year#")# |
#linkTo(text="June  1", action="summary", params="asof=June 1, #year#")# 
--->
</cfoutput>