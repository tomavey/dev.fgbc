<cfoutput>
<div class="row-fluid well contentStart contentBg">

<div class="span12"><h1>Listing users</h1>

	[#linkTo(text="Groups", controller="auth.groups", action="index")#]
	[#linkTo(text="Rights", controller="auth.rights", action="index")#]

	<p>#addTag()#</p>

	#includePartial("/_shared/paginationlinks")#

	<div class="well">

			#startFormTag(action="search")#

			#textFieldTag(name="search", placeholder="Search")#

			#endFormTag()#
	</div>


<table class="table">
<tr>
	<th>
		Username
	</th>
	<th>
		Last Name
	</th>
	<th>
		First Name
	</th>
	<th>
		Date
	</th>
	<th>
		Last Login
	</th>
	<th>
		&nbsp;
	</th>
</tr>
<cfoutput query="users">
<tr>
	<td>
		<span>#username#</span>
	</td>
	<td>
		#lname#
	</td>
	<td>
		#fname#
	</td>
	<td>
		#dateformat(createdAt)#
	</td>
	<td>
		#dateformat(lastloginAt)#
	</td>
	<td>
		#showTag()#
		#editTag()#
		#deleteTag(class="noajax")#
		#linkTo(text="login as #fname#", action="loginAsUser", params="username=#username#&userid=#id#&email=#email#")#
	</td>
</tr>
</cfoutput>
</table>
	#includePartial("/_shared/paginationlinks")#

	<p>#addTag()#</p>
	<p>#linkTo(text="Duplicate Emails Used", action="findDuplicatesByEmail")#</p>
</div>
</div>
</cfoutput>
