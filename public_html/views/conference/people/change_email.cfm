<cfoutput>
<div class="eachItemShown">
Contact information for #people.fullname#

			#errorMessagesFor("people")#
	
			#startFormTag(action="updateEmail", key=params.key)#
			
			#textField(objectName='people', property='email', label='Email: ')#
				
			#textField(objectName='people', property='phone', label='Phone: ')#

			#submitTag()#
				
			#endFormTag()#
</div>			
</cfoutput>
