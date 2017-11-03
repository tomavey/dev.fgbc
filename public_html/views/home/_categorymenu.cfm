<cfset menucount = 0>
<cfset officemenucount = 0>

<cfoutput>
<div class="container card card-charis card-charis-square">
    <div class="span3">
        &nbsp;
    </div>

    <div class="span9">
<h2>
	<cfif gotRights("Handbook")>
		FGBC Ministry Staff Menu:
	<cfelse>
		Members Menu: 
	</cfif>
</h2>	

<cfloop query ="menu">
    <cfif gotrights(rightsrequired) and category is "office">
    	<cfset officemenucount = officemenucount + 1>
    </cfif>
    <cfif gotrights(rightsrequired) and category NEQ "office">
    	<cfset menucount = menucount + 1>
    </cfif>
</cfloop>

<cfoutput query="menu" group="category">
<cfset rowcount = 0>
	<ul class="categorymenulist">
	<cfoutput>
       	<cfif gotrights(rightsrequired)>
			<cfset rowcount = rowcount + 1>
       		<li>#createLink(text=name, link=link, controller=controllerr, action=actionn, key=keyy)#		
			</li>
        </cfif> 
		<!---Create a column break--->
		<cfif rowcount is int((officemenucount)/2)>
			</ul>
			<ul class="categorymenulist">
		</cfif>
					
	</cfoutput>
	</ul>
</cfoutput>
</div>
</div>
</cfoutput>
