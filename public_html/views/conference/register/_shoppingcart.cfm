<cfparam name="cartformaction" default="person">
<cfif params.action is "showFamilyRegs">
	<cfset cartformaction = "checkOutAddedOptions">
</cfif>
<cfset shoppingcarttotal = 0>

<table class="shoppingCart">
<!---Header--->
	<tr>
		<th colspan="3" class="shoppingcartheader">
			Your Shopping Cart so far...
		</th>
	</tr>
	<tr>
		<td colspan="3"><hr/>
		</td>
	</tr>
<!---Each person--->
<cfoutput query="cart" group="person">
	<cfset querystring = "">

	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<th colspan="3" class="person">
			Items selected for #person# ...
			<cfset querystring = "person="&person>
		</th>
	</tr>

	<cfset personSubTotal=0>

<!---Each Item for this person--->
<cfoutput>
	<cfif quantity NEQ 0 && description DOES NOT CONTAIN "Discount"><!---if no family discount they still need to be in the options list but with a price of 0 - should be fixed sometime--->
	<tr>
		<td class="description">
			#description#
		</td>
		<td class="quantity">
			(#quantity#)
		</td>
		<td class="price">
			#dollarformat(val(price)*quantity)#
		</td>
			<cfset querystring = querystring & "&" & item & "=" & quantity>
			<cfset personSubTotal = personSubTotal + (quantity * val(price))>
	</tr>
</cfif>
</cfoutput>

<!---Subtotal for this person--->
	<tr class="personSubTotal">
		<td colspan="2">
<!---
			[#linkto(text="edit", controller="register", action="selectOptions", params="#querystring#")#]
 --->
			[#linkto(text="delete", controller="conference.register", action="deletePersonThenRedirect", params="person=#person#", confirm="Are you sure you want to delete #person#?")#] Total for #person#:
		</td>
		<td>
			#dollarformat(personSubTotal)#
		</td>
	</tr>
	<tr>
		<td colspan="3"><hr/>
		</td>
	</tr>
																																			</td></tr>
	<cfset shoppingcarttotal = shoppingcarttotal + personSubTotal>
</cfoutput>

<!---Total for Cart--->
<cfoutput>
	<tr><td colspan="3">&nbsp;</td></tr>
	<tr class="shoppingcarttotal">
		<td colspan="2">
			Total in shopping cart:
		</td>
		<cfif shoppingcarttotal LT 0>
			<td>
				#dollarformat(0)#<br/>
				<span style="font-size:.7em">Total shopping cart cannot be less that $0</span>
			</td>

		<cfelse>
		<td>
			#dollarformat(shoppingcarttotal)#
		</td>
		</cfif>
	</tr>
	<cfif cart.recordcount>
	<tr>
		<td colspan="3" id="checkout">
			#linkTo(text='Checkout', action=cartformaction, id="checkOut", class="btn btn-large btn-block btn-info")#<br/>
			#linkTo(text='Empty Cart', action="emptyCart", id="emptyCart", title="Delete everything and start over!", confirm="Are you sure you want to delete everything in this cart	?")#
		</td>
	</tr>
	</cfif>
</cfoutput>

</table>

