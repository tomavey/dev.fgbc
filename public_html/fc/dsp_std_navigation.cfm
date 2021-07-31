</div>
<div id="navigation" class="menu">
<p>Main Menu</p>
<ul>
	<cfinvoke component="control" method="get_content_fc" returnvariable="menuitems"/>

	<cfoutput query="menuitems">
		<cfif name does not contain "inactive">
			<cfif name is "forum">
				<li><a href="http://www.fgbc.org/forum/constitution/">#description#</a></li>
			<cfelse>
				<li><a href="#fbx('content')#&id=#id#">#description#</a></li>
			</cfif>
		</cfif>
	</cfoutput>

	<li><a href="<cfoutput>#fbx('commissions')#</cfoutput>">Commissions</a></li>
	<li><a href="<cfoutput>#fbx('abstracts')#</cfoutput>">Documents<br/>(upload & download)</a></li>
	<li><a href="<cfoutput>#fbx('addnewpage')#</cfoutput>">Add a new page</a></li>

	<cfif gotrights("superadmin")>
		<li><a href="<cfoutput>#fbx('contenttable')#</cfoutput>">Content Table</a></li>
		<li><a href="<cfoutput>#fbx('pdfReports')#</cfoutput>">PDF Reports</a></li>
	</cfif>
</ul>
</div>
