<cfoutput>
	<fieldset id="contactinfo">
		<legend>Contact Information:</legend>
						#textField(objectName='home', property='lname', label='Last Name:')#
					
						#textField(objectName='home', property='fname', label='First Name:')#
					
						#textField(objectName='home', property='sname', label='Spouses Name:')#
					
						#textField(objectName='home', property='address', label='Address:')#
					
						#textField(objectName='home', property='city', label='City:')#
					
						#textField(objectName='home', property='state', label='State:')#
					
						#textField(objectName='home', property='zip', label='Zip:')#
					
						#textField(objectName='home', property='hphone', label='Home Phone:')#
					
						#textField(objectName='home', property='cphone', label='Cell Phone:')#
					
						#textField(objectName='home', property='email', label='Email:')#
	</fieldset>					

	<fieldset id="hostingneed">
		<legend>Hosting Request:</legend>
					
						#textField(objectName='home', property='dates', label='For which dates would you like housing?')#
					
						#textField(objectName='home', property='agerange', label='Approximate age of the adults:')#
					
						#textField(objectName='home', property='children', label="Children's Names:")#
					
						#textField(objectName='home', property='ages', label="Children's Ages - use same order as names:")#
					
						#textField(objectName='home', property='gender', label="Children's Gender:")#
					
						#textField(objectName='home', property='allergies', label='Allergies:')#
					
						#textField(objectName='home', property='cribs', label='Do you need cribs? If so how many?')#
					
						#textArea(objectName='home', property='special', label='Special Needs')#

	</fieldset>					
					
	<fieldset id="extra">
		<legend>Getting to know you better:</legend>
					
						#textField(objectName='home', property='missionary', label='Are you a missionary? If so which country?')#
					
						#textField(objectName='home', property='national', label='Are you an international? Is so which country?')#
					
						#textField(objectName='home', property='delegate', label='Which church are you from?')#
					
						#textField(objectName='home', property='pastor', label='Are you a pastor? Is so, give title and location.')#
		</fieldset>				
					
</cfoutput>