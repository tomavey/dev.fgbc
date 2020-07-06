<cfparam name="tag" type="string">
<cfif isDefined("url.tag")>
    <cfset tag = url.tag>
</cfif>
<cfinvoke component="control" method="getcommission" tag="#tag#" returnvariable = "commission">
<cfset emailall = "">
<table style="width:90%">
<cfoutput query="commission">
	<tr>
		<td style="width:30%"><a href="/index.cfm/handbook/people/#personid#" target="_new">#fname# #lname#</a></td>
		<td style="width:30%"><a href="mailto:#email#">#email#</a></td>
		<td>
			<span><a href="skype:+1-#phone#?call" onclick="return skypeCheck();">#phone#</a></span>
			<cfif len(phone2)>
				<span><a href="skype:+1-#phone2#?call" onclick="return skypeCheck();">Cell: #phone2#</a></span>
			</cfif>
		</td>
	</tr>
			<cfif email is not "">
				<cfset emailall = #emailall# & "; " & #email#>
			</cfif>
</cfoutput>
</table>	

<cfif emailall is not "">
    <cfset emailall = removechars(emailall,1,2)>
</cfif>	

<cfoutput><p class="emailall">Email this commission:<a href="mailto:#emailall#" class="emaillink">#emailall#</a></p></cfoutput>
