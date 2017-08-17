<h1>Editing handbookpersonupdate</h1>

<cfoutput>

			#errorMessagesFor("handbookpersonupdate")#
	
			#startFormTag(action="update", key=params.key)#
		
				
						#textField(objectName='handbookpersonupdate', property='personId', label='Person Id')#
					
						#textField(objectName='handbookpersonupdate', property='fname', label='Fname')#
					
						#textField(objectName='handbookpersonupdate', property='fnamegender', label='Fnamegender')#
					
						#textField(objectName='handbookpersonupdate', property='lname', label='Lname')#
					
						#textField(objectName='handbookpersonupdate', property='spouse', label='Spouse')#
					
						#textField(objectName='handbookpersonupdate', property='address1', label='Address1')#
					
						#textField(objectName='handbookpersonupdate', property='address2', label='Address2')#
					
						#textField(objectName='handbookpersonupdate', property='city', label='City')#
					
						#textField(objectName='handbookpersonupdate', property='stateid', label='Stateid')#
					
						#textField(objectName='handbookpersonupdate', property='zip', label='Zip')#
					
						#textField(objectName='handbookpersonupdate', property='country', label='Country')#
					
						#textField(objectName='handbookpersonupdate', property='phone', label='Phone')#
					
						#textField(objectName='handbookpersonupdate', property='phone2', label='Phone2')#
					
						#textField(objectName='handbookpersonupdate', property='skype', label='Skype')#
					
						#textField(objectName='handbookpersonupdate', property='fax', label='Fax')#
					
						#textField(objectName='handbookpersonupdate', property='email', label='Email')#
					
						#textField(objectName='handbookpersonupdate', property='email2', label='Email2')#
					
						#textField(objectName='handbookpersonupdate', property='web', label='Web')#
					
						#textField(objectName='handbookpersonupdate', property='position', label='Position')#
					
						#textField(objectName='handbookpersonupdate', property='pic_thumb', label='Pic_thumb')#
					
						#textField(objectName='handbookpersonupdate', property='pic_big', label='Pic_big')#
					
						#dateSelect(objectName='handbookpersonupdate', property='birthday', label='Birthday')#
					
						#textField(objectName='handbookpersonupdate', property='churchid', label='Churchid')#
					
						#textField(objectName='handbookpersonupdate', property='affiliation_id', label='Affiliation_id')#
					
						#textField(objectName='handbookpersonupdate', property='comment', label='Comment')#
					
						#textField(objectName='handbookpersonupdate', property='sortorder', label='Sortorder')#
					
						#textField(objectName='handbookpersonupdate', property='sendHandbook', label='Send Handbook')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
