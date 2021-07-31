<div class="row-fluid well contentStart contentBg">

<div class="span12">
<h1>Editing right</h1>

<cfoutput>

			#errorMessagesFor("right")#
	
			#startFormTag(action="update", key=params.key)#
		
			#putFormTag()#		

						#textField(objectName='right', property='name', label='Name')#
					
						#textField(objectName='right', property='description', label='Description')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>
</div>