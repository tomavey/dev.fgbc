<div class="container">

<h1>Listing Announcements</h1>
<cfoutput>
	<p>#addTag()#</p>
	<p>
		<cfif isDefined("params.showall")>
			#linkto(text="Show Current", params="")#
			&nbsp;|&nbsp;
		<cfelse>
			#linkto(text="Show All", params="showall=1")#
			&nbsp;|&nbsp;
		</cfif>	
		<cfif !isDefined("params.announcements")>
			#linkto(text="Show Current Web Site Announcements", params="announcements=1")#
			&nbsp;|&nbsp;
		</cfif>	
		<cfif !isDefined("params.feeds")>
			#linkto(text="Show All News Feeds", params="feeds=1")#
			&nbsp;|&nbsp;
		</cfif>
			#linkto(text="RSS Feed", controller="announcements", action="rss")#
	</p>	
</cfoutput>

<table class="table">
	<tr>
		<th>
			Title
		</th>
		<th>
			Link
		</th>
		<th>
			Begin
		</th>
		<th>
			End
		</th>
		<th>
			Type
		</th>
		<th>
			&nbsp;
		</th>		
	</tr>
	
	<cfoutput query="announcements">
			<tr>
				<td>
					#Title#
				</td>
				<td>
					#linkto(text=left(link,15), href=link)#
				</td>
				<td>
					#dateformat(startAt)#
				</td>
				<td>
					#dateformat(endAt)#
				</td>
				<td>
					#type#
				</td>	
				<td>
					#showTag()# #editTag()# #deleteTag(class="noAjax")# #copyTag()#
					<cfif type NEQ "Announcement Only">
						#linkto(text="rss", controller="announcements", action="rss", params="id=#id#")#
					</cfif>
				</td>
			</tr>
	
	</cfoutput>
	
</table>	


</div>