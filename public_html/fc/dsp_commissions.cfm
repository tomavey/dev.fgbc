<script type="text/javascript"
src="http://download.skype.com/share/skypebuttons/js/skypeCheck.js">
</script>
<cfset emailall = "">

<h2>Membership Commission</h2>
<cfset tag = "fc_membership">
<cfinclude template="dsp_commission.cfm">

<h2>Structures Commission</h2>
<cfset tag = "fc_structures">
<cfinclude template="dsp_commission.cfm">


<h2>Finance Commission</h2>
<cfset tag = "fc_finance">
<cfinclude template="dsp_commission.cfm">

<h2>Position Statements</h2>
<p>Appointed by the Executive Director</p>
<cfset tag = "fc_positions">
<cfinclude template="dsp_commission.cfm">

<br/>
<cfinvoke component="control" method="getcommission" tag="fc" returnvariable = "commission">

<h2>Cell Phone List2</h2>
<table style="width:50%">
<cfset phoneList = "">
<cfoutput query="commission">
	<cfset phoneList = phoneList & " " & #phone2#>
	<tr>
		<td style="width:30%"><a href="/index.cfm/handbook/people/#personid#" target="_new">#fname# #lname#</a></td>
		<td>
			<cfif len(phone2)>
				<span><a href="skype:+1-#phone2#?call" onclick="return skypeCheck();">#phone2#</a></span>
			</cfif>
		</td>
	</tr>
</cfoutput>
<tr>
	<td colspan="2">
	</td>
</tr>
<tr>
	<td colspan="2">
		All cell numbers: <cfoutput>#replace(phoneList,"","","one")#</cfoutput> 
	</td>
</tr>
</table>	


