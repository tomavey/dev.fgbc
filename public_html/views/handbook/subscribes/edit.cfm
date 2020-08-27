<h1>Editing a handbook subscription</h1>

<cfoutput>

			#errorMessagesFor("handbooksubscribe")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#
		
<cfif len(handbooksubscribe.handbookemail)>
	<cfset handbooksubscribe.email = handbooksubscribe.handbookemail>
</cfif>
				
						#textField(objectName='handbooksubscribe', property='email', label='Email')#
					
						#select(objectName='handbooksubscribe', property='handbookid', label='Handbook ID', options=handbookpeople, textField="selectnameId", includeBlank="---Select Name---")#

						#textField(objectName='handbooksubscribe', property='type', label='Type')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
