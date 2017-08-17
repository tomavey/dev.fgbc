</div>
<div id="navigation" class="menu">
    <p>Main Menu</p>
    
    <ul>
        <cfinvoke component="control" method="get_content_natmin" returnvariable="menuitems"/>
        <cfoutput>
        	<li><a href="#fbx('content')#&id=20">Main</a></li>
        	<li><a href="#fbx('Teams')#">Teams Roster</a></li>
        	<li><a href="#fbx('addnewpage')#">Add a new page</a></li>
        	<li><a href="#fbx('abstracts')#">Files</a></li>
		</cfoutput>

        <cfoutput query="menuitems">
			<cfif name is not "Main">
                <li><a href="#fbx('content')#&id=#id#">#description#</a></li>
            </cfif>
        </cfoutput>

        <cfif session.auth.email is "tomavey@fgbc.org">
	        <li><a href="<cfoutput>#fbx('contenttable')#</cfoutput>">Content Table</a></li>
        </cfif>
    </ul>
</div>
