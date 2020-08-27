<div id="#params.controller##params.action#">
<h1>Showing resource</h1>

<cfoutput>
	<div class="postbox">
					<p><span>Id</span> <br />
						#resource.id#</p>
				
					<p><span>File Author</span> <br />
						#resource.fileAuthor#</p>
				
					<p><span>File Description</span> <br />
						#resource.fileDescription#</p>
				
					<p><span>No File Content</span> <br />
						#resource.NoFileContent#</p>
				
					<p><span>File Deleted</span> <br />
						#resource.fileDeleted#</p>
				
					<p><span>File Status</span> <br />
						#resource.fileStatus#</p>
				
					<p><span>Rights Required</span> <br />
						#resource.rightsRequired#</p>
				
					<p><span>Attempted Server File</span> <br />
						#resource.attemptedServerFile#</p>
				
					<p><span>Client Directory</span> <br />
						#resource.clientDirectory#</p>
				
					<p><span>Client File</span> <br />
						#resource.clientFile#</p>
				
					<p><span>Client File Ext</span> <br />
						#resource.clientFileExt#</p>
				
					<p><span>Client File Name</span> <br />
						#resource.clientFileName#</p>
				
					<p><span>Content Sub Type</span> <br />
						#resource.contentSubType#</p>
				
					<p><span>Date Last Accessed</span> <br />
						#resource.dateLastAccessed#</p>
				
					<p><span>File Existed</span> <br />
						#resource.fileExisted#</p>
				
					<p><span>File Size</span> <br />
						#resource.fileSize#</p>
				
					<p><span>File Was Appended</span> <br />
						#resource.fileWasAppended#</p>
				
					<p><span>File Was Overwritten</span> <br />
						#resource.fileWasOverwritten#</p>
				
					<p><span>File Was Renamed</span> <br />
						#resource.fileWasRenamed#</p>
				
					<p><span>File Was Saved</span> <br />
						#resource.fileWasSaved#</p>
				
					<p><span>Old File Size</span> <br />
						#resource.oldFileSize#</p>
				
					<p><span>Server Directory</span> <br />
						#resource.serverDirectory#</p>
				
					<p><span>Server File</span> <br />
						#resource.serverFile#</p>
				
					<p><span>Server File Ext</span> <br />
						#resource.serverFileExt#</p>
				
					<p><span>Server File Name</span> <br />
						#resource.serverFileName#</p>
				
					<p><span>Time Created</span> <br />
						#resource.timeCreated#</p>
				
					<p><span>Time Last Modified</span> <br />
						#resource.timeLastModified#</p>
				
					<p><span>Created At</span> <br />
						#resource.createdAt#</p>
				
					<p><span>Updated At</span> <br />
						#resource.updatedAt#</p>
				
					<p><span>Deleted At</span> <br />
						#resource.deletedAt#</p>
				
	</div>
#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this resource", action="edit", key=resource.id)#
</cfoutput>
