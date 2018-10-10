<cfoutput>		
				

						<cfif isDefined("params.keyy") && len(params.keyy)>
							#hiddenFieldTag(name='params.keyy', value=params.keyy)#
						</cfif>

						#textField(objectName='setting', property='name', label='Setting name: ')#
					
						#textField(objectName='setting', property='value', label='Setting Value: ')#
						<cfif isDefined("setting.name")>
						<p>Default Setting Value is "#application.wheels[setting.name]#"</p>
						</cfif>
						#textArea(objectName='setting', property='description', label='Description')#
																
						#textField(objectName='setting', property='category', label='Category')#
				
</cfoutput>																
				
																
				
																
