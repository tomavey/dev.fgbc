<cfoutput>

	#ckeditor()#
	
	<fieldset>
		<legend>#editButton("leadershipinfo")##getQuestion("leadershipinfo")#</legend>

			<div class="offset1">

				<cfloop list="principle_leader,leader_address,leader_city" index="i">
						#textFieldQuestionWEditButton(i)#
					
				</cfloop>

						#editbutton('stateid')#	
						#select(
							objectName='membershipapplication', 
							property='stateid', 
							label=getQuestion('stateid'),
							options=states, 
							includeBlank=getQuestion('selectstate'),
							class="input-xlarge"
							)#

				<cfloop list="leader_zip,leader_phone,leader_email" index="i">
						
						#textFieldQuestionWEditButton(i,'input-medium')#
					
				</cfloop>

						#textAreaQuestionWEditButton('officers')#
				
			</div>

	</fieldset>			
</cfoutput>