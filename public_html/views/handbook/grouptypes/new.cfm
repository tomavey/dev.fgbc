<cfoutput>

<div class="postbox" id=#params.controller##params.action#>

<h1>Create a new group:</h1>

			#errorMessagesFor("handbookgrouptype")#
	
			#startFormTag(action="create")#
		
						#textField(objectName='handbookgrouptype', property='title', label='Title')#
					
						#textField(objectName='handbookgrouptype', property='comments', label='Comments')#
					
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#

</div>
</cfoutput>
