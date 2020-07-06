<div class="postbox">
<h1>Editing group</h1>

<cfoutput>

			#errorMessagesFor("group")#
	
			#startFormTag(action="update", key=params.key)#
		
			#putFormTag()#		

						#textField(objectName='group', property='name', label='Name')#
					
						#textField(objectName='group', property='description', label='Description')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>
