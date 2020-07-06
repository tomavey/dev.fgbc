<cfoutput>
	
	#ckeditor()#
	
	<fieldset>

		<legend>For Office only: </legend>					

			<div class="offset1">

						#textField(objectName='membershipapplication', property='assignedTo', label='Assigned To')#
																
				
					
						#textField(objectName='membershipapplication', property='interviewedAt', label='Date of Interview')#
																
				
					
						#textArea(objectName='membershipapplication', property='interview_comments', label='Interview comments: ', class="ckeditor")#
							
				</p>												
				Approved by membership commission:
						#dateSelect(objectName='membershipapplication', property='approved_by_commission', dateOrder='year,month,day', monthDisplay='abbreviations', class="input-small", includeblank="---")#
				</p>
					
				<p>	
				Approved by Fellowship Council:
						#dateSelect(objectName='membershipapplication', property='approved_by_fc', dateOrder='year,month,day', monthDisplay='abbreviations', class="input-small", includeblank="---")#
				</p>												

				<p>				
				Approved by delegates:	
						#dateSelect(objectName='membershipapplication', property='approved_by_delegates', dateOrder='year,month,day', monthDisplay='abbreviations', class="input-small", includeblank="---")#
				</p>												
				
				<p>	
				Membership fee recieved: 
						#dateSelect(objectName='membershipapplication', property='fee_recievedAt', dateOrder='year,month,day', monthDisplay='abbreviations', class="input-small", includeblank="---")#
				</p>												
				
				<p>	
				Handbook Link: 
						#select(objectName='membershipapplication', property='handbookId', options=churches, textField="selectNameCity", includeBlank="---select one---")#
				</p>												
					
						#textarea(objectName='membershipapplication', property='comments', label='Comments: ', class="ckeditor")#

			</div>
			
		</fieldset>				

</cfoutput>