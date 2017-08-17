<cfoutput>
								<div class="well span5 eachdelegate">
									#textField(objectName="fgbcdelegate", property='name[#i#]', label='Delegate ## #i#')#
								
									#textField(objectName="fgbcdelegate", property='email[#i#]', label='Email')#
								</div>
</cfoutput>