<cfoutput>
						#textField(objectName='ministry', property='name', label='Name')#

						#textField(objectName='ministry', property='webaddress', label='Web')#

						#textField(objectName='ministry', property='image', label='Image')#

						#textField(objectName='ministry', property='email', label='Email')#

						#textArea(objectName='ministry', property='summary', label='Summary')#

						#select(objectName='ministry', property='status', label='Status', options="active,dropdown,inactive")#

						#select(objectName='ministry', property='category', label='Category', options=getministryCategories(), includeBlank="----select ministry category---")#

</cfoutput>
