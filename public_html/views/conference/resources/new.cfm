<cfparam name="title" default="Request a Vision2020 Media Resource">
<cfparam name="commenttext" default="Comment">
<cfparam name="showQuantity" default="true">
<div class="new">
<h1><cfoutput>#title#</cfoutput></h1>

<cfoutput>

			#errorMessagesFor("resource")#
	
			#startFormTag(action="create")#
		
				
						#textField(objectName='resource', property='email', label='Email:')#
					
						#textField(objectName='resource', property='name', label='Name:')#
					
						#textArea(objectName='resource', property='address', label='Address:')#
						
						<cfif not isdefined("params.key")>
							#textField(objectName='resource', property='item', label='Item Requested:')#
						</cfif>	
						
						<cfif showQuantity>
							#textField(objectName='resource', property='quantity', label='Quantity:')#
						</cfif>

						#textArea(objectName='resource', property='comment', label=commenttext)#
					

				#submitTag()#
				
			#endFormTag()#
			

</cfoutput>

</div>
