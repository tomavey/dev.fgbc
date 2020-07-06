<h1>Editing equip_shoppingcart</h1>

<cfoutput>

			#errorMessagesFor("equip_shoppingcart")#
	
			#startFormTag(action="update", key=params.key)#
		
			#putFormTag()#		

						#textField(objectName='equip_shoppingcart', property='cartID', label='Cart ID')#
					
						#textField(objectName='equip_shoppingcart', property='owner', label='Owner')#
					
						#textField(objectName='equip_shoppingcart', property='person', label='Person')#
					
						#textField(objectName='equip_shoppingcart', property='item', label='Item')#
					
						#textField(objectName='equip_shoppingcart', property='quantity', label='Quantity')#
					
						#textField(objectName='equip_shoppingcart', property='type1', label='Type1')#
					
						#textField(objectName='equip_shoppingcart', property='type2', label='Type2')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
