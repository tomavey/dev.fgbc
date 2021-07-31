<h1>Showing handbookgroup</h1>

<cfoutput>

					<p><span>Id</span> <br />
						#handbookgroup.id#</p>
				
					<p><span>Person Id</span> <br />
						#handbookgroup.personId#</p>
				
					<p><span>Grouptype Id</span> <br />
						#handbookgroup.grouptypeId#</p>
				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this handbookgroup", action="edit", key=handbookgroup.id)#
</cfoutput>
