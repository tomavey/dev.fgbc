<cfoutput>

					<h2 style="text-align:center">#content.name#</h2>
				
					<p>#content.content#</p>
				
					<p>Created by #content.author# on #dateformat(content.createdAt,"medium")#</p>
					#linkto(text="<i class='fa fa-pencil-square'></i>", controller='focus.contents', action='edit', params='keyy=#content.id#')#
				
</cfoutput>
