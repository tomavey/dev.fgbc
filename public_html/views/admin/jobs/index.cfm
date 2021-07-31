<div class="container">

<h1>Listing Jobs</h1>

<cfif gotrights("superadmin,office")>
	<cfoutput>
		<p>#addtag()#</p>
	</cfoutput>
</cfif>

<table class="table">
	<tr>
		<th>
			Title
		</th>
		<th>
			Approved?
		</th>
		<th>
			Contact Email
		</th>
		<th>
			Expires
		</th>
		<th>
			&nbsp;
		</th>
	</tr>
<cfoutput query="jobs">
	<tr>
		<td>
			#title#
		</td>
		<td>
			#approved#
		</td>
		<td>
			#mailTo(emailaddress=contactemail, name=contactemail)#
		</td>
		<td>
			#dateformat(expirationdate)#
		</td>
		<td>
			<cfif gotrights("superadmin,office")>
				#editTag()# #showTag()# #deleteTag(class="notAjaxDelete")#
			</cfif>
		</td>
	</tr>
	<tr>
</cfoutput>
</table>

<cfif gotrights("superadmin,office")>
	<cfoutput>
		<p>#addtag()#</p>
	</cfoutput>
</cfif>

</div>