<h1>Showing equip_shoppingcart</h1>

<cfoutput>

					<p><span>Id</span> <br />
						#equip_shoppingcart.id#</p>
				
					<p><span>Cart ID</span> <br />
						#equip_shoppingcart.cartID#</p>
				
					<p><span>Owner</span> <br />
						#equip_shoppingcart.owner#</p>
				
					<p><span>Person</span> <br />
						#equip_shoppingcart.person#</p>
				
					<p><span>Item</span> <br />
						#equip_shoppingcart.item#</p>
				
					<p><span>Quantity</span> <br />
						#equip_shoppingcart.quantity#</p>
				
					<p><span>Type1</span> <br />
						#equip_shoppingcart.type1#</p>
				
					<p><span>Type2</span> <br />
						#equip_shoppingcart.type2#</p>
				
					<p><span>Createdat</span> <br />
						#equip_shoppingcart.createdat#</p>
				
					<p><span>Updatedat</span> <br />
						#equip_shoppingcart.updatedat#</p>
				
					<p><span>Deletedat</span> <br />
						#equip_shoppingcart.deletedat#</p>
				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this equip_shoppingcart", action="edit", key=equip_shoppingcart.id)#
</cfoutput>
