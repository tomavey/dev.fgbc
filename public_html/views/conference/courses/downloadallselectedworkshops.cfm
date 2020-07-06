<table class="table">
    <tr>
    <cfoutput query="workshops" group="title">
        <td>#title#</td>
    </cfoutput>
    </tr>
    <tr>
    <cfoutput query="workshops" group="title">
        <td>#subType#</td>
    </cfoutput>
    </tr>
</table>

<table class="table">
    <tr>
        <th>Title</th>
        <th>Person</th>
        <th>Email</th>
    </tr>
    <cfoutput query="workshops">
    <tr>
        <td>#title#</td>
        <td>#cleanname(lname)#, #cleanname(fname)#</td>
					<cfif len(conferencepersonemail)>
						<cfset thisemail = Conferencepersonemail>
					<cfelseif len(getSpouseEmail(equip_peopleid))>
						<cfset thisemail = getSpouseEmail(equip_peopleid)>
					</cfif>
        <td>#thisemail#</td>
    </tr>
    </cfoutput>
</table>
