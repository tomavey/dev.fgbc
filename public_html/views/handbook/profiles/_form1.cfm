<cfoutput>
						<cfif isdefined("handbookprofile.personid")>
							#hiddenField(objectName='handbookprofile', property='personid', label='Personid')#
						</cfif>
						
						#hiddenField(objectName='handbookprofile', property='createdby')#
						
						#textField(objectName='handbookprofile', property='name', label='Name: ')#
					
						#textField(objectName='handbookprofile', property='phone', label='Preferred Phone: ')#
					
						#textField(objectName='handbookprofile', property='email', label='Email Address: ')#
					
						<p>Birthday: #dateSelect(objectName='handbookprofile', property='birthday', label='', startyear=year(now())-10, endyear=year(now())-100, class="input-small", includeBlank="---")#</p>
					
						#textField(objectName='handbookprofile', property='wife', label="Spouses' Name: ")#
					
						<p>Spouses' Birthday: #dateSelect(objectName='handbookprofile', property='wifesbirthday', label="", startyear=year(now())-10, endyear=year(now())-100, class="input-small", includeBlank="---")#</p>
					
						<p>Anniversary: #dateSelect(objectName='handbookprofile', property='anniversary', label='', startyear=year(now()), endyear=year(now())-80, class="input-small", includeBlank="---")#</p>
					
						#textField(objectName='handbookprofile', property='children', label='Names/ages of children: ')#
					
						#textField(objectName='handbookprofile', property='facebook', label='Facebook Address: ')#
					
						#textField(objectName='handbookprofile', property='twitter', label='Twitter Address: ')#
					
						#textField(objectName='handbookprofile', property='linkedin', label='Linkedin Address: ')#
					
						#textField(objectName='handbookprofile', property='othersocial', label='Other Social Media: ')#
						
</cfoutput>