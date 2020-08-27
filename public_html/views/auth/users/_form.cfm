<cfoutput>
						#textField(objectName='user', property='username', label='Username: ')#

						#hiddenTagForKeyy()#

				<cfif params.action is "new" or params.action is "create">					
						#passwordField(objectName='user', property='password', label='Password: ')#
				</cfif>	
						#textField(objectName='user', property='fname', label='First Name: ')#
					
						#textField(objectName='user', property='lname', label='Last Name: ')#
					
						#textField(objectName='user', property='email', label='Email: ')#
					

</cfoutput>