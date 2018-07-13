<cfset thisDirectory=GetDirectoryFromPath(GetBaseTemplatePath())>
<cfdirectory action="list" directory="#thisDirectory#\images\program_ads\" name="items">
<ul>
<cfoutput query="items">

	<li>#items.name#</li>
</cfoutput>
</ul>
