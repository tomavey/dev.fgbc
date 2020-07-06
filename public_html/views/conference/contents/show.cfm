<h1>Showing Content</h1>

<div class="eachItemShown">
<cfoutput>

					<p><span>Id: </span> 
						#content.id#</p>
				
					<p><span>Name: </span> 
						#content.name#</p>
				
<br>			
					<p>#content.content#</p>
<br>				
					<p><span>Created: </span> 
						#dateformat(content.createdat)#</p>
				
					<p><span>Updated: </span> 
						#dateformat(content.updatedat)#</p>
				

#linkTo(text="#imageTag('list-icon.png')#", action="index", title="List")#  #linkTo(text="#imageTag('edit-icon.png')#", action="edit", key=content.id, title="Edit")#
</cfoutput>
</div>
