<h1>Create new registrant</h1>

<cfoutput>

			#errorMessagesFor("registrant")#
	
			#startFormTag(action="create")#
		
				
						#textField(objectName='registrant', property='retreat', label='Retreat')#
					
						#textField(objectName='registrant', property='fname', label='First Name')#
					
						#textField(objectName='registrant', property='lname', label='Last Name')#
					
						#textField(objectName='registrant', property='sname', label='Spouse Name')#

						#textField(objectName='registrant', property='email', label='Email')#
					
						#textField(objectName='registrant', property='phone', label='Phone')#
					
						#textField(objectName='registrant', property='roommate', label='Roommate')#
					
						#textField(objectName='registrant', property='comment', label='Comment')#
					
						#dateTimeSelect(objectName='registrant', property='createAt', dateOrder='year,month,day', monthDisplay='abbreviations', label='Create At')#
					
						#dateTimeSelect(objectName='registrant', property='deleteAt', dateOrder='year,month,day', monthDisplay='abbreviations', label='Delete At')#
					

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
