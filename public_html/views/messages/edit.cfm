<div class="postbox" id="#params.controller##params.action#">

<h1>Editing message</h1>

<cfoutput>

			#errorMessagesFor("message")#
	
			#startFormTag(action="update", key=params.key)#
		
				
						#textField(objectName='message', property='name', label='Name')#
					
						#textField(objectName='message', property='email', label='Email')#
					
						#textArea(objectName='message', property='message', label='Message', rows="10", cols="75")#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>