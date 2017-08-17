<div class="row-fluid well contentStart contentBg">

<div class="span12"><h1>Listing FGBC Ministries</h1>

<table class="table table-striped">
	<tr>
		<th>
			Name
		</th>
		<th>
			Web
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
		<td>	<cfif len(webaddress)>
			#linktoUrl(webaddress)#
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
</div>