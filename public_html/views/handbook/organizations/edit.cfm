<h1>Editing <cfoutput>#handbookorganization.name#</cfoutput></h1>

<cfoutput>

			#errorMessagesFor("handbookorganization")#
	
			#startFormTag(action="update", key=params.key)#
			
			#hiddenFieldTag(name="handbookorganization[updatedBy]", value=session.auth.email)#

			#putFormTag()#

			#includePartial("form")#
		
			#submitTag()#
				
			#endFormTag()#
			

</cfoutput>
