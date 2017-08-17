<div class="row-fluid well contentStart contentBg">

<div class="span12">

<h1>Listing groups</h1>

<cfoutput>
	[#linkTo(text="Rights", controller="auth.rights", action="index")#]
	[#linkTo(text="Users", controller="auth.users", action="index")#]
</cfoutput>

<table class="table">
	<tr>
		<th>
			Name
		</th>
		<th>
			Description
		</th>
		<th>
			&nbsp;
		</th>
	</tr>
<cfoutput query="groups">
	<tr>
		<td>
			#name#
		</td>
		<td>
			#description#
		</td>
		<td>
			#editTag()##ShowTag()##DeleteTag()#		
		</td>
	</tr>
</cfoutput>	
</table>

<cfoutput>
	<p>#addTag()#</p>
</cfoutput>
</div>
</div>