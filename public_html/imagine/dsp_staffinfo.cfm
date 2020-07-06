	<cfoutput query="staffdata">
	<div class="staffinfo"><span class="fname">#fname# #lname#</span><br/>
	<cfif address1 is not "">#address1#<br></cfif>
	<cfif address2 is not "">#address2#<br></cfif>
	#city#, #state#, #zip#<br>
	<cfif email is not ""><a href="mailto:#email#">#email#</a><br></cfif>
	<cfif phone is not "">Home Phone:#phone#<br></cfif>
	<p class="churchinfo">#cname#<br>
	#caddress1#<br>
	<cfif address2 is not "">#caddress2#<br></cfif>
	#ccity#, #cstate#, #czip#<br>
	<cfif cemail is not ""><a href="mailto:#cemail#">#cemail#</a><br></cfif>
	Church Phone #cphone#<br></p></div>
	</cfoutput>
