<cfoutput>
<h1>Register for #retreat.title#:</h1>
<div id="#params.controller#" ng-controller="registerController">
			#errorMessagesFor("shoppingcart")#

			#startFormTag(action="create")#

						#hiddenField(objectName='shoppingcart', property='retreat')#

						#textField(objectName='shoppingcart', property='fname', label='First Name: ')#

						#textField(objectName='shoppingcart', property='lname', label='Last Name: ')#

						#textField(objectName='shoppingcart', property='email', label='Email: ')#

						#textField(objectName='shoppingcart', property='phone', label='Phone: ')#

						#textField(objectName='shoppingcart', property='roommate', label='Roommate: ')#

					<cfif isDefined("shoppingcart.shoppingcartid")>	
						#hiddenField(objectName='shoppingcart', property='shoppingcartid')#
					</cfif>	
						#hiddenField(objectName='shoppingcart', property='retreatid')#

<!---
					<h3>We will use the following answers to form groups according to ministry areas on Tuesday morning:</h3>
				<div class="well">
						#textField(objectName='shoppingcart', property='ministrytitle', label='What is your ministry (or title if appropriate): ')#

						#select(objectName='shoppingcart', property='ministryareaprimary', label='Select one primary area of ministry: ', options=getMinistryAreas(), includeBlank="--Select One--")#

						#select(objectName='shoppingcart', property='ministryareasecondary', label='Select one secondary area of ministry: ', options=getMinistryAreas(), includeBlank="--Select One--")#
				</div>
--->
						#textFieldTag(Name='specialCode', label='Special Code: ')#

						<p>Select items:
						<table>
							<cfloop query="shoppingcartitems">
							<cfif showItem(id)>

								<cfif len(alertwhenselected) and alertwhenselected>
									<cfset thisclass = "alertwhenselected">
								<cfelse>
									<cfset thisclass = "dontalertwhenselected">
								</cfif>

								<cfif price LT 0>
									<cfset thisclass = thisclass & ' scholarship'>
								</cfif>

								<tr>
									<td>&nbsp;</td>
									<td>#checkboxTag(name='shoppingcart[items]', value=id, labelPlacement="around", class=thisclass, title=popup)#</td>
									<td class="description">
										#description#
										<p class="popup">#popup#</p>
									</td>
									<td class="price">#dollarformat(getItem(id).price)#
									</td>
									<td>
										<cfif len(popup)>
											<a href="" title="#popup#" class="tooltipside"><i class="icon-info-sign"></i></a>
										</cfif>
									</td>
								</tr>

							</cfif>
							</cfloop>
						</table>
						</p>

				#submitTag("Submit")#

			#endFormTag()#


</div>
</cfoutput>

