<h1>Create user connection</h1>
<cfoutput>

<div class="eachItemShown new">

			#errorMessagesFor("user")#
			<cfif NOT flashIsEmpty()>
				<p id='flasherror'>#flash("error")#</p>
			</cfif>		
			#startFormTag(action="create")#
				
			#select(objectName='user', property='userid', label='User: ', options=auth_users, textField="selectname")#

			#select(objectName='user', property='familyid', label='Family: ', options=families, textField="fullNameLastFirstID")#
	
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</div>
</cfoutput>
