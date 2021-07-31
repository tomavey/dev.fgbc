<h1>Downloads:</h1>
<cfoutput>
<p>#linkto(text="Member Churches", controller="handbookOrganizations", action="downloadMemberChurches")#</p>
<p>#linkto(text="Handbook people(church staff, national ministry staff, missionaries)", controller="handbookPeople", action="downloadstaff")#</p>
<cfif gotRights("superadmin,office")>
<p>#linkto(text="Links to handbook review pages", controller="handbook-organizations", action="updatelinks")#</p>
</cfif>
</cfoutput>