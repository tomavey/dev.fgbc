<cfoutput>
<div class="row-fluid well contentStart contentBg">

<div class="span12">
<h1>Editing blog</h1>


			#errorMessagesFor("blog")#
	
			#startFormTag(action="update", key=params.key)#	

						#putFormTag()#		

						#textField(objectName='blog', property='title', label='Title')#
					
						#textField(objectName='blog', property='blogAddress', label='Blog Address')#
					
						#textField(objectName='blog', property='feedburnerCode', label='Feedburner Code')#
					
						#textField(objectName='blog', property='feedburnerName', label='Feedburner Name')#
					
						#textField(objectName='blog', property='feedburnerNumber', label='Feedburner Number')#
					
						#textField(objectName='blog', property='email', label='Email')#
					
						#textField(objectName='blog', property='active', label='Active')#
					
						#textField(objectName='blog', property='sortorder', label='Sortorder')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</div>
</div>

</cfoutput>
