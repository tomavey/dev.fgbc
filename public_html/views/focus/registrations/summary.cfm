<cfparam name="asof" default="#now()#">
<cfparam name="year" default = "#year(now())#">
<cfoutput>
	<cfif isBefore(asof)>
		<h2>Total Registrations for completed retreats:</h2>
	<cfelse>	
		<h2>Registrations through #monthasstring(month(asof))# #day(asof)#:</h2>
	</cfif>
	<!--- <cfdump var="#regs#"> --->
	<table class="table">
		<tr>
			<th>&nbsp;</th>
			<th>#linkto(text="Central", controller="focus.registrations", action="index", params="menuName=central")#</th>
			<th>#linkto(text="East", controller="focus.registrations", action="index", params="menuName=east")#</th>
			<th>#linkto(text="Southwest", controller="focus.registrations", action="index", params="menuName=southwest")#</th>
			<th>#linkto(text="South", controller="focus.registrations", action="index", params="menuName=south")#</th>
			<th>#linkto(text="Northwest", controller="focus.registrations", action="index", params="menuName=northwest")#</th>
		</tr>
		<tr>
			<td>2020/21</td>
			<td>#regs.central20total#</td>
			<td>#regs.east20total#</td>
			<td>#regs.southwest21total#</td>
			<td>#regs.south21total#</td>
			<td>#regs.northwest21total#</td>
		</tr>
		<tr>
			<td>2019/20</td>
			<td>#regs.central19total#</td>
			<td>#regs.east19total#</td>
			<td>#regs.southwest20total#</td>
			<td>#regs.south20total#</td>
			<td>#regs.northwest20total#</td>
		</tr>
		<tr>
			<td>2018/19</td>
			<td>#regs.central18total#</td>
			<td>#regs.east18total#</td>
			<td>#regs.southwest19total#</td>
			<td>#regs.south19total#</td>
			<td>#regs.northwest19total#</td>
		</tr>
	</table>
<cfif asOf IS now()>
	#linkTo(text="View total regs for completed retreats", action="summary", params="asof=July 1, #year+1#", class="btn")#
<cfelse>
	#linkTo(text="View regs through #monthasstring(month(now()))# #day(now())#", action="summary", class="btn")#
</cfif>

<!---
| 
#linkTo(text="February  1", action="summary", params="asof=February 1, #year#")# | 
#linkTo(text="April  1", action="summary", params="asof=April 1, #year#")# |
#linkTo(text="June  1", action="summary", params="asof=June 1, #year#")# 
--->
</cfoutput>