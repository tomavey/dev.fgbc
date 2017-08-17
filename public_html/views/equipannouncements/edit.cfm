<h1>Editing equipannouncement</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			#errorMessagesFor("equipannouncement")#
	
			#startFormTag(action="update", key=params.key)#
		
				
															
				
					
						#textField(objectName='equipannouncement', property='uuid', label='Uuid')#
															
				
					
						#textField(objectName='equipannouncement', property='event', label='Event')#
															
				
					
						#textField(objectName='equipannouncement', property='subject', label='Subject')#
															
				
					
						#textField(objectName='equipannouncement', property='content', label='Content')#
															
				
					
						#textField(objectName='equipannouncement', property='link', label='Link')#
															
				
					
						#textField(objectName='equipannouncement', property='author', label='Author')#
															
				
					
						#textField(objectName='equipannouncement', property='approved', label='Approved')#
															
				
					
						#dateTimeSelect(objectName='equipannouncement', property='postAt', dateOrder='year,month,day', monthDisplay='abbreviations', label='Post At')#
															
				
					
						#textField(objectName='equipannouncement', property='sendType', label='Send Type')#
															
				
					
						#dateTimeSelect(objectName='equipannouncement', property='sentAt', dateOrder='year,month,day', monthDisplay='abbreviations', label='Sent At')#
															
				
															
				
															
				
															
				
				
				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
