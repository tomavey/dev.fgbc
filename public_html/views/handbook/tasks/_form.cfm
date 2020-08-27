<cfoutput>				
																
				
<!---					
						#textField(objectName='handbooktask', property='parenttaskId', label='Parenttask Id')#
																
--->				
						#textField(objectName='handbooktask', property='title', label='Title: ')#
																
					
						#textArea(objectName='handbooktask', property='task', label='Task', class="ckeditor")#
																
				
					
						#textField(objectName='handbooktask', property='assignedto', label='Assigned to:')#
																
				
					
						#textField(objectName='handbooktask', property='assignedby', label='Assigned by:')#
																
				
						Due: 
						#dateSelect(objectName='handbooktask', property='dueAt', dateOrder='year,month,day', monthDisplay='abbreviations', label='', includeBlank="-Select-")#
																
				
					
						#textField(objectName='handbooktask', property='status', label='Status: ', class="ckeditor")#
																
				
					
						#textArea(objectName='handbooktask', property='notes', label='Notes: ', class="ckeditor")#
																
				
					Completed: 
						#dateSelect(objectName='handbooktask', property='completedAt', dateOrder='year,month,day', monthDisplay='abbreviations', label='', class="input_small", includeBlank="-Select-")#
																
				
</cfoutput>																
				
																
				
																
				

