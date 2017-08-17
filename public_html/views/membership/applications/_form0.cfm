<cfoutput>
	<fieldset>
		<legend>#editButton('started')##getQuestion("started")#</legend>

			<div class="offset1">
						
						#editButton('useremail')#
						#textField(
							objectName='membershipapplication', 
							property='useremail', 
							label=getQuestion('useremail'), class="input-xlarge"
							)#
																
						#editButton('language')#
						#select(
							objectName='membershipapplication', 
							property='language', options="English,Spanish,French", 
							label=getQuestion('language'), class="input-xlarge"
							)#
			</div>				

	</fieldset>			
</cfoutput>