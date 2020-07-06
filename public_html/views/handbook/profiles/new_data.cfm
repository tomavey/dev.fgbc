<div id="profile">
<div class="alert alert-info">
Welcome to the AGBM/FGBC profile center. Please fill out as much of these forms (4) as possible.  There will be a page for basic information, education, ministry, and personal experience.
</div>
<h1>Step #1: Basic Information... </h1>
    <div class="progress">
    <div class="bar"
    style="width: 0%;"></div>
    </div>
<cfoutput>

			#errorMessagesFor("handbookprofile")#
	
			#startFormTag(action="create")#
			
			<cfif isDefined("params.admin")>
			#select(objectName="handbookprofile", property="personid", options=people, label="Connect to handbook person", textField="selectname", valueField="id", includeBlank="Select Person to Connect")#
			</cfif>
		
			#includePartial("form1")#					

			#submitTag(name="submit", value="Save and go to ministry information")#
			#submitTag(name="submit", value="Save and exit")#
				
			#endFormTag()#
			

</cfoutput>
</div>