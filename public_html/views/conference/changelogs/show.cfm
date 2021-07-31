<h1>Showing changelog</h1>

<cfoutput>

					<p><span>Id</span> <br />
						#changelog.id#</p>
				
					<p><span>Table</span> <br />
						#changelog.table#</p>
				
					<p><span>Column</span> <br />
						#changelog.column#</p>
				
					<p><span>Olddata</span> <br />
						#changelog.olddata#</p>
				
					<p><span>User</span> <br />
						#changelog.user#</p>
				
					<p><span>Created At</span> <br />
						#changelog.createdAt#</p>
				
					<p><span>Updated At</span> <br />
						#changelog.updatedAt#</p>
				
					<p><span>Deleted At</span> <br />
						#changelog.deletedAt#</p>
				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this changelog", action="edit", key=changelog.id)#
</cfoutput>
