<cfoutput>
<div class="row-fluid well contentStart contentBg">
    <div class="span3">
    	&nbsp;
    </div>

    <div class="span9">
		
		<h1>Create a new right</h1>

			#errorMessagesFor("right")#
	
			#startFormTag(action="create")#
		
			#textField(objectName='right', property='name', label='Name')#
					
			#textField(objectName='right', property='description', label='Description')#
					
			#submitTag()#
				
			#endFormTag()#
			
		#linkTo(text="Return to the listing", action="index")#

	</div>

</div>
</cfoutput>
