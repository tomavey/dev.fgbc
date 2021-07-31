<cfoutput>
<ul>
<cfloop collection=#params.handbookperson# item="i">
<cftry>
<li>#i# = #params.handbookperson[i]#</li>
<cfcatch></cfcatch></cftry>
</cfloop>
<cfloop collection=#params.handbookperson.handbookprofile# item="i">
<cftry>
<li>#i# = #params.handbookperson.handbookprofile[i]#</li>
<cfcatch></cfcatch></cftry>
</cfloop>
</ul>
</cfoutput>