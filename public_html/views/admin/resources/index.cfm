<cfscript>
	sortBys = ['description', 'createdAt DESC', 'createdAt ACS','author', 'file']
</cfscript>

<div class="container">

	<h1>Listing resources</h1>

	<cfoutput>
		#startFormTag(method="get", class="form-search")#
		#textFieldTag(name="search", placeholder="search", class="span2 search-query", style="border-radius:10px; padding-left:5px")#
		#endFormTag()#
	</cfoutput>

	<p>
		Sort by: 
		<cfoutput>
			<cfloop index="i" from="1" to=#arrayLen(sortBys)#  >
				#linkto(text=sortBys[i], controller="admin.resources", action="index", params="orderBy=#sortBys[i]#")# |
			</cfloop>
		</cfoutput>
	</p>
	<cfoutput>
		<p>#linkTo(text="Add a new resource", action="new")#</p>
	</cfoutput>

	<table class="table table-striped">
		<tr>
			<th>
				Description
			</th>
			<th>
				Author
			</th>
			<th>
				File	
			</th>
			<th>
				Created
			</th>
			<th>
				&nbsp;
			</th>
		<tr>
		<cfoutput query="resources">
			<tr>
				<td>
					#description#
					<cfif len(summary)>	
						<span class="expand">#summary#</span></li>
					</cfif>
				</td>
				<td>
					#author#
				</td>
				<td>
					<cfif len(file)>
						#linkto(text=file, href="#application.wheels.webpath#files/#file#")#
					<cfelseif len(webaddress)>
						#linkto(text=webaddress, href=webaddress)#
					<cfelse>
					</cfif>	
				</td>
				<td>
					#dateformat(createdAt)#
				</td>
				<td>
					#showTag()# #editTag()# #deleteTag(class="noajax")#
				</td>
			</tr>
		</cfoutput>
	</table>	

	<cfoutput>
		<p>#linkTo(text="Add a new resource", action="new")#</p>
	</cfoutput>

</div>
