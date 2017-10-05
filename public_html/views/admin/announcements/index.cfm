<div class="row-fluid well contentStart contentBg">

<div class="span12"><h1>Listing Announcements</h1>
<cfoutput>
	<p>#addTag()#</p>
	<cfif isDefined("params.showall")>
		<p>#linkto(text="Show Current", params="")#</p>
	<cfelse>
		<p>#linkto(text="Show All", params="showall=1")#</p>
	</cfif>	
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
					#showTag()# #editTag()# #deleteTag(class="noAjax")# #copyTag()#
				</td>
			</tr>
	
	</cfoutput>
	
</table>	


</div></div>