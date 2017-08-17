<cfoutput>
	
</cfoutput>
<div class="row-fluid well contentStart contentBg">

<div class="span12"><h1>Listing resources</h1>

<table>
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
	<p>#linkTo(text="New resource", action="new")#</p>
</cfoutput>
</div>
</div>
