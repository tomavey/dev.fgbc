<cfparam name="route" default="">
<div class="container">

<h1>Listing Menus</h1>

<table class="table">
<tr>
	<th>
		Name
	</th>
	<th>
		Link
	</th>
	<th>
		Rights Required
	</th>
	<th>
		&nbsp;
	</th>
</tr>

<cfoutput query="menus" group="category">
	<tr>
		<td colspan="5">
			<h2 class="menuCategory">#category#</h2>
		</td>
	</tr>
	<cfoutput>
	<tr>
		<td>
			#name#
		</td>
		<td>
			#createLink(text=name, link=link, controller=controllerr, action=actionn, key=keyy, route=route)#
		</td>
		<td>
			<span class="expand">#left(rightsrequired,50)#</span>
		</td>
		<td>
			<cfif gotRights("superadmin,office")>
				#editTag()##ShowTag()##DeleteTag(class="noajax")#
			</cfif>
		</td>
	</tr>
	</cfoutput>
</cfoutput>
</table>
<cfif gotRights("superadmin,office")>
	<cfoutput>
		<p>#addTag()#</p>
	</cfoutput>
</cfif>
<cfoutput>
#gotRights("superadmin")#
</cfoutput>

</div>