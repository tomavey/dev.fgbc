<ul>
<cfoutput query="ministerium" group="personid">
<li>#name# #alias('lname',lname,id)# - #name#, #org_city#, #org_state#, (#district#)</li>
</cfoutput>
</ul>