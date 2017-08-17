<cfoutput>
<div class="row-fluid well contentStart contentBg">

<div class="span12">
<h1>Editing message</h1>

			#errorMessagesFor("message")#
	
			#startFormTag(action="update", key=params.key)#
		
						#putFormTag()#		
	
						#textField(objectName='message', property='name', label='Name')#
					
						#textField(objectName='message', property='email', label='Email')#
					
						#textArea(objectName='message', property='message', label='Message', rows="10", cols="75")#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</div>
</div>
</cfoutput>
