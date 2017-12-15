<div class="container">

<h1>Listing FGBC Ministries</h1>

<cfif gotRights("superadmin,office")>
	<cfoutput>
		<p>#addTag()#</p>
	</cfoutput>
</cfif>

<table class="table table-striped">
	<tr>
		<th>
			Name
		</th>
		<th>
			Web/Phone
		</th>
		<th>
			Summary
		</th>
		<th>
			&nbsp;
		</th>
	</tr>
<cfoutput query="ministries" group="category">
<tr>
<td colspan="3">
<h3>#category#</h3>
</td>
</tr>
<cfoutput>
	<tr>
		<td>
			#left(name,30)#<br/>
			<span style="font-size:.8em">&nbsp;&nbsp;[#status#]</span>
		</td>
		<td>	
			<cfif len(webaddress)>
				#linktoUrl(webaddress)#<br/>
			</cfif>
			<cfif len(phone)>
				#fixphone(phone)#
			</cfif>
		</td>
		<td>
			#summary#
		</td>
		<td>
			<cfif gotRights("superadmin,office")>
				#edittag()##Showtag()##DeleteTag()#
			</cfif>
		</td>
</cfoutput>
</cfoutput>
</table>

<cfif gotRights("superadmin,office")>
	<cfoutput>
		<p>#addTag()#</p>
	</cfoutput>
</cfif>

</div>