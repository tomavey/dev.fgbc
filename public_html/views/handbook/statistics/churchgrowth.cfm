<cfparam name="params.year1" default="#year(now())-1#">
<cfparam name="params.year2" default="#year(now())-6#">
<cfparam name="params.delta" default="10">

<cfset countgrowing = 0>
<cfset countdeclining = 0>
<cfset countstatic = 0>
<cfset countna = 0>
<h2>Numerical Church Growth by Attendance</h2>
<p>"Static" means less than growth or decline of less than (percent):
	<cfoutput>
			#startFormTag(action="churchgrowth", method="get")#
			#textFieldTag(name="delta", value=params.delta, class="input-mini")# 
			#hiddenFieldTag(name="year1", value=params.year1)#
			#hiddenFieldTag(name="year2", value=params.year2)#
			#endFormTag()#
	</cfoutput>		
</p>

<table class="table">

<cfoutput>
	<tr>
		<th>Church</th>
		<th>
			#startFormTag(action="churchgrowth", method="get")#
			#textFieldTag(name="year1", value=params.year1, class="input-mini")#
			#hiddenFieldTag(name="year2", value=params.year2)#
			#hiddenFieldTag(name="delta", value=params.delta)#
			#endFormTag()#
		</th>
		<th>
			#startFormTag(action="churchgrowth", method="get")#
			#textFieldTag(name="year2", value=params.year2, class="input-mini")#
			#hiddenFieldTag(name="year1", value=params.year1)#
			#hiddenFieldTag(name="delta", value=params.delta)#
			#endFormTag()#
		</th>
		<th>Change</th>
		<th>Growing?</th>
		<th&nbsp;</th>
	</tr>	
</cfoutput>	

<cfoutput query="churches" group="state">
		<tr>
			<td colspan="6">
				<br/>
				<h2>#state#</h2>
			</td>
		</tr>
	
		<cfset countgrowingstate = 0>
		<cfset countdecliningstate = 0>
		<cfset countstaticstate = 0>
	
	<cfoutput>	
	
		<cfset growth = thisChurchesGrowth(churchid=id,year1=params.year1,year2=params.year2,delta=params.delta)>	
		
		<cfif growth contains "Declining">
			<cfset countdeclining = countdeclining + 1>
			<cfset countdecliningstate = countdecliningstate + 1>
		</cfif>
		<cfif growth contains "Growing">
			<cfset countgrowing = countgrowing + 1>
			<cfset countgrowingstate = countgrowingstate + 1>
		</cfif>
		<cfif growth contains "Static">
			<cfset countstatic = countstatic + 1>
			<cfset countstaticstate = countstaticstate + 1>
		</cfif>
		<cfif growth contains "Na">
			<cfset countna = countna + 1>
		</cfif>
		
			<tr>
				<td>#linkto(text=selectname, controller="handbook.organizations", action="show", key=id)#</td>
				#growth#
				<td>#linkTo(text="Stats", action="show", key=id)#</td>
			</tr>
	
	</cfoutput>	
	
		<tr>
			<td>&nbsp;</td>
			<td colspan="5">
				#state# summary: Growing = #countgrowingstate#; Declining = #countdecliningstate#; Static = #countstaticstate# 
			</td>
			
		</tr>
	
	</cfoutput>

</table>

<cftry>
<cfoutput>
	<cfset totalcount = countdeclining + countgrowing + countstatic>
	<p>Growing = #countgrowing#&nbsp;/&nbsp;#numberFormat(countgrowing/totalcount*100)#%</p>
	<p>Static = #countstatic#&nbsp;/&nbsp;#numberFormat(countstatic/totalcount*100)#%</p>
	<p>Declining = #countdeclining#&nbsp;/&nbsp;#numberFormat(countdeclining/totalcount*100)#%</p>
	<p>NA = #countna#</p>
</cfoutput>
<cfcatch>Summary not available</cfcatch>
</cftry>
<p>Note: if statistics were not recorded for the year, a previous or next year may be used in its place.</p>