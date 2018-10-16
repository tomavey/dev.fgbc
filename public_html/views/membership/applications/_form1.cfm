<cfoutput>
	<fieldset>
		<legend>#editButton('churchinfo')##getQuestion("churchinfo")#</legend>

			#hiddenTagForKeyy()#

			<div class="offset1">
						
				<cfloop list="name_of_church,mailing_address" index="i">
						#textFieldQuestionWEditButton(i,"input-xlarge")#
					
				</cfloop>		

						#textFieldQuestionWEditButton('city',"input-medium")#
												
						#editButton('stateid')#		
						#select(
							objectName='membershipapplication', 
							property='stateid', 
							label=getQuestion('stateid'),
							options=states, includeBlank=getQuestion("selectstate"),
							class="input-xlarge"
							)#

				<cfloop list="zip,country,phone,email,web_site" index="i">

						#textFieldQuestionWEditButton(i,"input-medium")#
					
				</cfloop>			
					
						#textFieldQuestionWEditButton('meeting_place',"input-xlarge")#

				<cfloop list="incorporated,insurance" index="i">

						#selectYesNoQuestionWEditButton(i)#					
				</cfloop>		

			</div>				

	</fieldset>			
</cfoutput>