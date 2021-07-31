<cfoutput>
	<div class="modal" id="myModal">
	    <div class="modal-header">
		    <a class="close" data-dismiss="modal">x</a>
	    	<h3>Upload a document...</h3>
	    </div>
	    <div class="modal-body">
	
				#startFormTag(controller="forumresources", action="create", multipart="true")#
				
				#includePartial(partial="../resources/form")#
	
		</div>
	    <div class="modal-footer">
				#submitTag("Upload")#
					
				#endFormTag()#
	    </div>
    </div>
	<a href="##myModal" data-toggle="modal">Upload a file</a>
</cfoutput>