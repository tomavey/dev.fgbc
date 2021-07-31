<h1>Editing shoppingcart</h1>

<cfoutput>
<div id="#params.controller#">

			#errorMessagesFor("shoppingcart")#

			#startFormTag(action="update", key=params.key)#

			#putFormTag()#



						#textField(objectName='shoppingcart', property='fname', label='First Name: ')#

						#textField(objectName='shoppingcart', property='lname', label='Last Name: ')#

						#textField(objectName='shoppingcart', property='email', label='Email: ')#

						#textField(objectName='shoppingcart', property='phone', label='Phone: ')#

						#textField(objectName='shoppingcart', property='roommate', label='Roommate: ')#
<!---
						#textField(objectName='shoppingcart', property='ministrytitle', label='What is your ministry (or title if appropriate): ')#

						#select(objectName='shoppingcart', property='ministryareaprimary', label='Select a primary area of ministry: ', options=getMinistryAreas(), includeBlank="--Select One--")#

						#select(objectName='shoppingcart', property='ministryareasecondary', label='Select a secondary area of ministry: ', options=getMinistryAreas(), includeBlank="--Select One--")#
--->

						#textFieldTag(Name='specialCode', label='Special Code: ')#

						<table>
							<cfloop query="shoppingcartitems">
								<tr>
									<td>&nbsp;</td>
									<td>
										<cfif listfind(shoppingcart.items,id)>
											#checkboxTag(name='shoppingcart[items]', value=id, labelPlacement="around", checked=true)#
										<cfelse>
											#checkboxTag(name='shoppingcart[items]', value=id, labelPlacement="around", checked=false)#
										</cfif>

									</td>
									<td>#description#</td>
									<td>#getItem(id).price#</td>
								</tr>
							</cfloop>
						</table>

				#submitTag()#

			#endFormTag()#


#linkTo(text="Return to the listing", action="index")#

</div>
</cfoutput>
