<h1>Create a new Church or Organization</h1>

<cfoutput>

			#errorMessagesFor("handbookorganization")#
	
			#startFormTag(action="create")#

			#hiddenFieldTag(name="handbookorganization[createdBy]", value=session.auth.email)#

			#hiddenFieldTag(name="handbookorganization[updatedBy]", value=session.auth.email)#
		
			#includePartial(partial="form")#					

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
