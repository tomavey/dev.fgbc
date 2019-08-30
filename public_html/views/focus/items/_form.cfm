<cfoutput>

						#textField(objectName='item', property='name', label='Name: ')#

						<cfif isDefined("params.retreatID")>
							#hiddenFieldTag(name="item.retreatID", value=params.retreatid)#
						<cfelse>	
							#select(objectName='item', property='retreatID', label='Retreat: ', options=activeRetreats)#
						</cfif>
						
						#textField(objectName='item', property='description', label='Description: ', class="input-xxlarge")#

						#textField(objectName='item', property='maxtosell', label='Maximum available to sell: ', class="input-mini")#

						#select(objectName='item', property='regCount', options="0,1,2", label='Reg Count (for summary report)', class="input-mini")#

						#textArea(objectName='item', property='popup', label='Popup: ', cols="40", class="input-xxlarge")#

						#select(objectName='item', property='alertwhenselected', label='Alert when selected? ', options="No,Yes", class="input-mini")#

						#textField(objectName='item', property='price', label='Price: ', class="input-small")#

						<!--- #textField(objectName='item', property='dependencies', label='Dependencies: ', class="input-large")# --->

						#select(objectName='item', property='dependencies', label='Dependencies (hold shift key to select muliple): ', options=items, valueField="name", includeBlank="------", multiple=true)#
						<cfif len(item.dependencies)>
							<p style="font-size: .7em; color: gray">&nbsp;&nbsp;&nbsp;(Current Dependencies: #item.dependencies#)</p>
						</cfif>

						#select(objectName='item', property='category', label='Category: ', options=application.wheels.optiontypes)#

						#textField(objectName='item', property='sortOrder', label='Sort Order (optional): ', class="input-mini")#

						#textArea(objectName='item', property='Comments', label='Comments: ', class="input-xxlarge")#

						<p>Expires:
							#dateSelect(objectName='item', property='expiresAt', dateOrder='year,month,day', monthDisplay='abbreviations', class="input-small")#
						</p>

</cfoutput>