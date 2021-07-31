<div class="row-fluid well contentStart contentBg">

<div class="span12"><h1>Listing Blogs</h1>

<cfoutput>
	<p>#addTag()#</p>
</cfoutput>


<table class="table">
	<tr>
		<th>
			Title
		</th>
		<th>
			Blog
		</th>
		<th>
			Active
		</th>
		<th>
			&nbsp;	
		</th>
	</tr>
	<cfoutput query="blogs">
	<tr>
		<td>
			#title#
		</td>
		<td>
			#linkTo(href=blogaddress)#
		</td>
		<td>
			#active#	
		</td>
		<td>
			#showTag()# #editTag()# #deleteTag()#
		</td>
		
	</tr>	
	</cfoutput>	
</table>
<cfoutput>
[#linkTo(controller="blogs", action="undelete", text="unDelete All")#]
</cfoutput>
</div>