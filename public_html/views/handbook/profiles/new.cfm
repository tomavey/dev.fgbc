<div id="profile">
<div class="alert alert-info">
Welcome to the AGBM/FGBC profile center. Please fill out as much of this form as possible.
</div>
<cfoutput>

			#errorMessagesFor("handbookprofile")#
	
			#startFormTag(action="create")#
			
			<cfif isDefined("params.admin")>
			#select(objectName="handbookprofile", property="personid", options=people, label="Connect to handbook person", textField="selectname", valueField="id", includeBlank="Select Person to Connect")#
			</cfif>
		
			#includePartial("form")#					

			#submitTag(name="submit", value="Submit")#
				
			#endFormTag()#
			

</cfoutput>
</div>