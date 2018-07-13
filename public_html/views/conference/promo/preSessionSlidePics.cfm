<cfset thisDirectory=GetDirectoryFromPath(GetBaseTemplatePath())>
<cfdirectory action="list" directory="#thisDirectory#\images\conference\exhibitors\pre-session_slides\" name="items">
<div class="container">
<h1>Pre-session slide images</h1>
<ul>

<cfquery dbtype="query" name="items">
  SELECT *
  FROM items
  ORDER BY name
</cfquery>

<cfoutput query="items">

	<li>#linkto(text=items.name, href="https://charisfellowship.us/images/conference/exhibitors/pre-session_slides/#items.name#")#</li>
</cfoutput>
</ul>
</div>