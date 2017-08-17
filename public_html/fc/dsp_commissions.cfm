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

<br/>
<cfinvoke component="control" method="getcommission" tag="fc" returnvariable = "commission">

<h2>Cell Phone List</h2>
<table style="width:50%">
<cfoutput query="commission">
	<tr>
		<td style="width:30%"><a href="/index.cfm/handbook/people/#personid#" target="_new">#fname# #lname#</a></td>
		<td>
			<cfif len(phone2)>
				<span><a href="skype:+1-#phone2#?call" onclick="return skypeCheck();">#phone2#</a></span>
			</cfif>
		</td>
	</tr>
</cfoutput>
</table>	
