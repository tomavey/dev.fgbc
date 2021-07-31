<cfoutput>				

#ckeditor()#

	<cfif isDefined("params.key")>
		#hiddenTagForKeyy()#
	
		#hiddenFieldTag(name="id", value=params.key)#
	</cfif>	

	#textField(objectName='content', property='name', label='Name')#

	#textArea(objectName='content', property='content', label='Content', cols="75", rows="10", class="ckeditor")#

	#textField(objectName='content', property='author', label='Author', cols="75", rows="5")#

	#textArea(objectName='content', property='comment', label='Comment', cols="75", rows="5")#
					
</cfoutput>