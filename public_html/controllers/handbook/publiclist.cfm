<ul>
<cfoutput query="ministerium" group="personid">
<li>#name# #lname# - #name#, #org_city#, #org_state#, (#district#)</li>
</cfoutput>
</ul>