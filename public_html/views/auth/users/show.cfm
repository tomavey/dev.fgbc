<cfoutput>
<div class="container">

	<h1>Showing user</h1>

	<cfif flashKeyExists("error")>
		<h3 class="well">
				#flash("error")#
		</h3>
	</cfif>

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
			#linkTo(text=name, controller="auth.groups", action="show", key=auth_groupsid)#-#linkTo(text="x", controller="auth.users", action="removeFromGroup", params="groupId=#auth_groupsid#&userid=#params.key#")#
		</cfloop>

		#startFormTag(action="addToGroup", key=params.key)#

			#hiddenFieldTag(name="username", value=user.username)#

			#selectTag(label="Add to group: ", name="groupid", options=allgroups)#

			#submitTag()#

		#endFormTag()#

	</p>

	<p><label>Rights:</label>
		<cfloop query="rights">
			#linkTo(text=name, controller="auth.rights", action="show", key=ID)#,
		</cfloop>
	</p>

	#linkTo(text='<i class="fa fa-list" aria-hidden="true"></i>', title="Return to list", action="index")#
	#editTag(id=user.id, title="Edit #user.fname#")#
	#deleteTag(title="delete #user.fname#", class="noajax", id=user.id)#
	#linkTo(text="<i class='fa fa-user-o'></i>", title="login as #user.fname#", action="loginAsUser", params="username=#user.username#&userid=#user.id#&email=#user.email#")#

</div>

</cfoutput>
