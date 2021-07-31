<script type="text/javascript"
src="http://download.skype.com/share/skypebuttons/js/skypeCheck.js">
</script>
<cfinvoke component="control" method="getteam" tag="evlc_churchplanting" returnvariable = "churchplanting">
<cfinvoke component="control" method="getteam" tag="evlc_leadershipdevelopment" returnvariable = "leadershipdevelopment">
<cfinvoke component="control" method="getteam" tag="evlc_integratedministry" returnvariable = "integratedministry">
<cfset emailall = "">
<h2>Church Planting</h2>
<cfset emailall = "">
<cfset team = "churchplanting">
<ul class="commissionlist">
<cfoutput query="#team#">
	<li><span>#fname# #lname#</span> 
		<span><a href="mailto:#email#">#email#</a></span>
		<span><a href="skype:+1-#phone#?call" onclick="return skypeCheck();">#phone#</a></span>
        <cfif isdefined("phone2") and len(phone2)>
			<span><a href="skype:+1-#phone2#?call" onclick="return skypeCheck();">#phone2#</a></span>
        </cfif>
	</li>
<cfif email is not "">
	<cfset emailall = #emailall# & "; " & #email#>
</cfif>
</cfoutput>
</ul>	
<cfif emailall is not "">
	<cfset emailall = removechars(emailall,1,2)>
</cfif>	
<cfoutput><p class="emailall">Email the Church Planting team:<a href="mailto:#emailall#" class="emaillink">#emailall#</a></p></cfoutput>

<h2>Leadership Development</h2>
<cfset emailall = "">
<cfset team = "leadershipdevelopment">
<ul class="commissionlist">
<cfoutput query="#team#">
	<li><span>#fname# #lname#</span> 
		<span><a href="mailto:#email#">#email#</a></span>
		<span><a href="skype:+1-#phone#?call" onclick="return skypeCheck();">#phone#</a></span>
        <cfif isdefined("phone2") and len(phone2)>
			<span><a href="skype:+1-#phone2#?call" onclick="return skypeCheck();">#phone2#</a></span>
        </cfif>
	</li>
<cfif email is not "">
	<cfset emailall = #emailall# & "; " & #email#>
</cfif>
</cfoutput>
</ul>	
<cfif emailall is not "">
	<cfset emailall = removechars(emailall,1,2)>
</cfif>	
<cfoutput><p class="emailall">Email the Leadership Development team:<a href="mailto:#emailall#" class="emaillink">#emailall#</a></p></cfoutput>

<h2>Intergrated Ministry</h2>
<cfset emailall = "">
<cfset team = "integratedministry">
<ul class="commissionlist">
<cfoutput query="#team#">
	<li><span>#fname# #lname#</span> 
		<span><a href="mailto:#email#">#email#</a></span>
		<span><a href="skype:+1-#phone#?call" onclick="return skypeCheck();">#phone#</a></span>
        <cfif isdefined("phone2") and len(phone2)>
			<span><a href="skype:+1-#phone2#?call" onclick="return skypeCheck();">#phone2#</a></span>
        </cfif>
	</li>
<cfif email is not "">
	<cfset emailall = #emailall# & "; " & #email#>
</cfif>
</cfoutput>
</ul>	
<cfif emailall is not "">
	<cfset emailall = removechars(emailall,1,2)>
</cfif>	
<cfoutput><p class="emailall">Email the Intergrated Ministry team:<a href="mailto:#emailall#" class="emaillink">#emailall#</a></p></cfoutput>
