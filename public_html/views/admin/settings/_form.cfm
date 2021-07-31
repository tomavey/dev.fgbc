<cfoutput>		
				
						#textField(objectName='setting', property='name', label='Setting name: ', class="form-control form-control-lg")#
					
						#textArea(objectName='setting', property='value', label='Setting Value (255 chars max): ', class="form-control form-control-lg")#
						<cftry>
							<p>Default Setting Value is "#application.wheels[setting.name]#"</p>
						<cfcatch></cfcatch>
						</cftry>
						
						#textArea(objectName='setting', property='description', label='Description', class="form-control", rows="5" )#
																
						#textField(objectName='setting', property='category', label='Category')#
				
</cfoutput>																
				
																
				
																
