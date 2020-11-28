<div class="span11">

<cfif isDefined("params.simple")>
	<div class="well">This will give a person access to the online handbook without actually adding them to the handbook. 
		<ul>
			<li>Must provide at least Name and Email.</li>
			<li>Please add a comment in the office only section about why this person should have access.</li>
		</ul>
	</div>
</cfif>
<h1>Create a new staff member:</h1>

<cfoutput>


			#errorMessagesFor("handbookperson")#
	
			#startFormTag(action="create")#

			<cfif isDefined("params.addReadOnlyPerson")>

				#includePartial(partial="formReadOnly")#				

			<cfelse>
		
				#includePartial(partial="form")#				

			</cfif>

			#submitTag()#
				
			#endFormTag()#

</cfoutput>
</div>