<div class="container">

<h1>Create new resource</h1>

<cfoutput>
		#linkTo(text="upload a resource", route="adminResourcesUploadDialog", class="btn")#

		#errorMessagesFor("resource")#
	
		#startFormTag(action="create", multipart="true")#
	
		#includePartial(partial="form")#

		#submitTag("Submit Resource")#
				
		#endFormTag()#
			

#linkTo(text="Return to the listing", action="list")#
</cfoutput>
</div>