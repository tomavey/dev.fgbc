<div class="span11">
<h1>Create a new staff member:</h1>

<cfoutput>


			#errorMessagesFor("handbookperson")#
	
			#startFormTag(action="create")#
		
			#includePartial("form")#				

			#submitTag()#
				
			#endFormTag()#

</cfoutput>
</div>