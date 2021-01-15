<cfoutput>
						#textField(objectName='ministry', property='name', label='Name')#

						#textField(objectName='ministry', property='webaddress', label='Web (use full url)')#

						#textField(objectName='ministry', property='image', label='Image')#

						#textField(objectName='ministry', property='email', label='Email')#

						#textField(objectName='ministry', property='phone', label='Phone')#

						#textArea(objectName='ministry', property='summary', label='Summary')#

						#select(objectName='ministry', property='status', label='Status', options="active,dropdown,inactive")#

						#select(objectName='ministry', property='category', label='Category', options=getministryCategories())#

						#textField(objectName='ministry', property='sortorder', label='Sort Order (effects which ministries show at the top of the category list)
</cfoutput>
