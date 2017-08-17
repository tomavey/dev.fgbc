<h1>Items in your shoppingcart so far...</h1>

<div id="#params.controller#">
<cfoutput query="shoppingCart">
<div class="well">
					<p class="regpersoninfo">	#fname# #lname#<br/>
						#email#<br/>
						#phone#<br/>
						<cfif len(shoppingcart.roommate)>
							Roommate: #roommate#
						</cfif>
					</p>
				
				<ul>
				<cfloop list="#items#" index="i">
					<li>
						<span class="itemdescription">#getItem(i).description# -</span> #dollarformat(getItem(i).price)#
					</li>

				</cfloop>
				</ul>

			<cfif total(params.key) GTE 0>
				<p class="alert alert-success">
					Total: #dollarformat(total(id))#
				</p>								
			<cfelse>
				<p class="alert alert-error">
					Total: #dollarformat(total(id))#
				</p>								
			</cfif>		

<p>#linkTo(text="Edit this registration", action="edit", key=shoppingcart.id, class="btn")#</p>

<!---this is causing issues
<p>#linkTo(text="Delete", action="deleteShoppingCartItem", key=shoppingcart.id, method="delete", confirm="Are you sure?")#</p>
--->

</div>
</cfoutput>
<cfoutput>
<cfif total(params.key) GTE 0>
	<p>#linkTo(text="Checkout", action="agent", key=shoppingcart.id, class="btn btn-large btn-block btn-primary")#</p>
<cfelse>	
	<div class="alert alert-error"><h3>ALERT</h3>
		<p>The total in your shopping cart cannot be a negative amount.</p> Please correct this by #linkTo(text="editing this shoppingcart", action="edit", key=shoppingcart.id)#.
		</p>
		<p>Sometimes this happens if you selected a discount without selecting a registration option.
		</p>
	</div>	
</cfif>
	<p>#linkTo(text="Add another registration", action="new", params="retreatid=#shoppingcart.retreatid#&shoppingcartid=#params.key#", class="btn")#</p>
	<p>#linkTo(text="Empty this cart", action="new", params="retreatid=#shoppingcart.retreatid#")#</p>
</cfoutput>

</div>
