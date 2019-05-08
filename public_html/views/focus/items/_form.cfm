<cfoutput>

						#textField(objectName='item', property='name', label='Name: ')#

						<cfif isDefined("params.retreatID")>
							#hiddenFieldTag(name="item.retreatID", value=params.retreatid)#
						<cfelse>	
							#select(objectName='item', property='retreatID', label='Retreat: ', options=activeRetreats)#
						</cfif>
						
						#textField(objectName='item', property='description', label='Description: ')#

						#textField(objectName='item', property='maxtosell', label='Maximum available to sell: ')#

						#select(objectName='item', property='regCount', options="0,1,2", label='Reg Count (for summary report)')#

						#textArea(objectName='item', property='popup', label='Popup: ', cols="40")#

						#select(objectName='item', property='alertwhenselected', label='Alert when selected? ', options="No,Yes")#

						#textField(objectName='item', property='price', label='Price: ')#

						#select(objectName='item', property='category', label='Category: ', options=application.wheels.optiontypes)#

						#textField(objectName='item', property='sortOrder', label='Sort Order (optional): ')#

						#textArea(objectName='item', property='Comments', label='Comments: ')#

						<p>Expires:
							#dateSelect(objectName='item', property='expiresAt', dateOrder='year,month,day', monthDisplay='abbreviations')#
						</p>

</cfoutput>