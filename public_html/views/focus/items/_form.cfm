<cfoutput>

						#textField(objectName='item', property='name', label='Name: ')#

						#select(objectName='item', property='retreatID', label='Retreat: ', options=activeRetreats)#

						#textField(objectName='item', property='description', label='Description: ')#

						#textField(objectName='item', property='maxtosell', label='Maximum available to sell: ')#

						#textArea(objectName='item', property='popup', label='Popup: ', cols="40")#

						#select(objectName='item', property='alertwhenselected', label='Alert when selected? ', options="No,Yes")#

						#textField(objectName='item', property='price', label='Price: ')#

						#select(objectName='item', property='category', label='Category: ', options=application.wheels.optiontypes)#

						<p>Expires:
							#dateSelect(objectName='item', property='expiresAt', dateOrder='year,month,day', monthDisplay='abbreviations')#
						</p>

</cfoutput>