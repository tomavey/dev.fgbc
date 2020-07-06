<div id="profile">

<h1>Editing a profile:</h1>

<cfoutput>

			#errorMessagesFor("handbookprofile")#
	
			#startFormTag(action="update", key=params.key)#
		
			<cfif isDefined("params.admin")>
			#select(objectName="handbookprofile", property="personid", options=people, label="Connect to handbook person", textField="selectname", valueField="id", includeBlank="Select Person to Connect")#
			</cfif>
		
			#includePartial("form")#					

			#submitTag(name="submit", value="Update")#
				
			#endFormTag()#
			

</cfoutput>


</div>