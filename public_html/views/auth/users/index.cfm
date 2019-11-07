<cfoutput>
<div class="container">

<h1>Listing users</h1>

	[#linkTo(text="Groups", controller="auth.groups", action="index")#]
	[#linkTo(text="Rights", controller="auth.rights", action="index")#]

	<p>#addTag()#</p>

	<div class="well">

			#startFormTag(action="search")#

			#textFieldTag(name="search", placeholder="Search")#

			#endFormTag()#
	</div>


	<table class="table">
	<cfoutput>
		<tr>
			<th>
				#linkto(text="Username", params="orderby=username")#
			</th>
			<th>
				#linkto(text="Last Name", params="orderby=lname")#
			</th>
			<th>
				#linkto(text="First Name", params="orderby=fname")#
			</th>
			<th>
				#linkto(text="Created", params="orderby=createdAt DESC")#
			</th>
			<th>
				#linkto(text="Last Login", params="orderby=lastloginAt DESC")#		
			</th>
			<th>
				&nbsp;
			</th>
		</tr>
	</cfoutput>
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

	<p>#addTag()#</p>
	<p>#linkTo(text="Duplicate Emails Used", action="findDuplicatesByEmail", params="orderBy=email")#</p>

</div>
</cfoutput>
