<cfoutput>		
#ckeditor()#
					<cfif showsubjectfield>
						#textField(objectName='forumpost', property='subject', label='Subject: ')#
					<cfelse>				
						#hiddenField(objectName='forumpost', property='subject')#
					</cfif>				

						#hiddenField(objectName='forumpost', property='createdBy')#
				
						#textArea(objectName='forumpost', class="ckeditor", property='post', label='')#
					
					<cfif isdefined("params.forumid")>
						#hiddenFieldTag(name="forumPost[forumid]", value=params.forumid)#
					<cfelse>	
						#select(objectName='forumPost', property='forumId', label='Forum: ', options=forums)#
					</cfif>

					<cfif isdefined("params.parentid")>
						#hiddenFieldTag(name="forumPost[parentid]", value=params.parentid)#
					</cfif>
					
					<cfif gotRights("superadmin")>
						#textField(objectName='forumpost', property='sortorder', label='Sortorder: ')#
					</cfif>
</cfoutput>