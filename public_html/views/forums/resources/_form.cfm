<cfoutput>				
				<cfif isdefined("session.auth.forumid") and len(session.auth.forumid)>		
					#hiddenFieldTag(name="forumresource[forumid]", value="#session.auth.forumid#")#
				<cfelse>	
					#Select(objectName='forumresource', property='forumid', label='Forumid', options=forums)#
				</cfif>					
						#fileField(objectName='forumresource', property='file', label='File: ')#
					
						#textArea(objectName='forumresource', property='description', label='Description: ')#

				<cfif isdefined("session.auth.email")>					
					#hiddenFieldTag(name="forumresource[createdby]", value="#session.auth.email#")#
				<cfelse>	
					#textField(objectName='forumresource', property='createdby', label='Createdby')#
				</cfif>	
</cfoutput>