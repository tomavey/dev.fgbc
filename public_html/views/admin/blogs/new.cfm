<cfoutput>
<div class="row-fluid well contentStart contentBg">

<div class="span12"><h1>Create new blog?</h1>


			#errorMessagesFor("blog")#
	
			#startFormTag(action="create")#
		
				
						#textField(objectName='blog', property='title', label='Title of Blog: ')#
					
						#textField(objectName='blog', property='blogAddress', label='Blog Address: ')#
					
						#textField(objectName='blog', property='feedburnerCode', label='Feedburner Code: ')#
					
						#textField(objectName='blog', property='email', label='Email')#
					
						#select(objectName='blog', property='active', label='Active', options="Yes,No")#
					
						#textField(objectName='blog', property='sortorder', label='Sortorder')#
					

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</div>
</div>
</cfoutput>
