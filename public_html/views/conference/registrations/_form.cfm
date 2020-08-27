<cfoutput>
 						#select(objectName='registration', property='equip_peopleid', label='Person', options=people, textField="fullnameLastFirstId", valueField="id", includeBlank="- Select One -")#
					
						#select(objectName='registration', property='equip_invoicesid', label='Invoice', options=invoices, textField="ccorderid", includeBlank="- Select One -")#
					
						#select(objectName='registration', property='equip_optionsid', label='Option', options=options, includeBlank="- Select One -")#
					
						#textField(objectName='registration', property='quantity', label='Quantity')#
					
						#textField(objectName='registration', property='cost', label='Cost')#
					
</cfoutput>