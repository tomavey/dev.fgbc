<cfoutput>

<div class="postbox" id=#params.controller##params.action#>

<h1>Editing #handbookgrouptype.title#:</h1>


			#errorMessagesFor("handbookgrouptype")#
	
			#startFormTag(action="update", key=params.key)#
		
				
						#textField(objectName='handbookgrouptype', property='title', label='Title')#
					
						#textField(objectName='handbookgrouptype', property='comments', label='Comments')#
					
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>
