<cfoutput>
	<h1>#getQuestion("uploadHeader")#</h1>
<div class="well">
#getQuestion("uploadInstructions")#
</div>
#includePartial(partial="showFlash")#

</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("membershipappresource")#
	
			#startFormTag(action="create", multipart="true")#


				
					<cfif isDefined("membershipappresource.applicationID")>		
						#hiddenField(objectName='membershipappresource', property='applicationID')#
					<cfelse>
						#select(objectName='membershipappresource', property='applicationID', valueField="id", textField="selectname", options=membershipapplications, label="Application")#
					</cfif>											
					
						#textField(objectName='membershipappresource', property='description', label=getQuestion('Description'))#
																
				
					
						#fileField(objectName='membershipappresource', property='file', label=getQuestion('File'))#
																
				
																
				#submitTag(trim(stripTags(getQuestion("submit"))))#
				
			#endFormTag()#
			
</cfoutput>
