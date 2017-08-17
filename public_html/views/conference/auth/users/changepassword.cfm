<div class="postbox" id=#params.controller#.#params.action#>
<cfoutput>
<h1>Edit Account for Username: "#user.username#"</h1>

			#errorMessagesFor("user")#

			#startFormTag(action="update", key=params.key)#

			#putFormTag()#

			#passwordField(objectName='user', property='password', label='Password: ')#

			#hiddenField(objectName='user', property='username')#

			#hiddenField(objectName='user', property='token')#

			#textField(objectName='user', property='fname', label='First Name: ')#

			#textField(objectName='user', property='lname', label='Last Name: ')#

			#textField(objectName='user', property='email', label='Email: ')#

			#submitTag()#

			#endFormTag()#
</cfoutput>

</div>