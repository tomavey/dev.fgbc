<cfoutput>
<div class="container">

	<h1>Showing user</h1>


	<p><label>Username: </label>
		#user.username#</p>

	<p><label>Last Name: </label>
		#user.lname#</p>

	<p><label>First Name: </label>
		#user.fname#</p>

	<p><label>Email: </label>
		#mailTo(user.email)#</p>

	<p><label>Date Added: </label>
		#dateformat(user.createdAt, "short")#</p>

	<p><label>Last Login: </label>
		#dateformat(user.lastloginat, "short")#</p>

	<p>
		<label>Groups:</label>
		<cfloop query="groups">
			<cftry>
			#linkTo(text=name, controller="auth.groups", action="show", key=auth_groupsid)#-#linkTo(text="x", controller="auth.users", action="removeFromGroup", params="groupId=#auth_groupsid#&userid=#params.key#")#
				<cfcatch></cfcatch>
			</cftry>
		</cfloop>

		#startFormTag(action="addToGroup", key=params.key)#

			#selectTag(label="Add to group: ", name="groupid", options=allgroups)#

			#submitTag()#

		#endFormTag()#

	</p>

	<p><label>Rights:</label>
		<cfloop query="rights">
			#linkTo(text=name, controller="auth.rights", action="show", key=ID)#,
		</cfloop>
	</p>

	#buttonTo(text="Return to the listing", action="index")#
	#buttonTo(text="Edit this user", action="edit", key=user.id)#
	#buttonTo(text="Login as this user", action="loginAsUser", params="username=#user.username#&userid=#user.id#&email=#user.email#")#

</div>

</cfoutput>
