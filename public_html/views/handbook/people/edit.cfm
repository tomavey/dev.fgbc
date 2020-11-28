<div class="span11">
<h1>Edit <cfoutput>#handbookperson.fname# #handbookperson.lname#</cfoutput></h1>

<cfoutput>

			#errorMessagesFor("handbookperson")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#
			
			#includePartial(partial="form")#	
								
			#submitTag()#
				
			#endFormTag()#
			

</cfoutput>
</div>