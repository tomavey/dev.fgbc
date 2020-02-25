<h1>Showing exhibit</h1>

<cfoutput>
<div class="eachItemShown #params.action#">
					<p><span>Organization: </span>
						#exhibit.organization#</p>

					<p><span>Address: </span>
						#exhibit.address#</p>

					<p><span>Phone: </span>
						#exhibit.phone#</p>

					<p><span>Email: </span>
						#exhibit.email#</p>

					<p><span>Fax: </span>
						#exhibit.fax#</p>

					<p><span>Contact: </span>
						#exhibit.person#</p>

					<p><span>Number of tables: </span>
						#exhibit.numbertables#</p>

					<p><span>Number of spaces: </span>
						#exhibit.numberspaces#</p>

					<p><span>Section: </span>
						#exhibit.section#</p>

					<p><span>Electricity: </span>
						<cfif exhibit.elect>Yes<cfelse>No</cfif></p>

				<cfif len(exhibit.specialrequest)>
					<p><span>Special request: </span>
						#exhibit.specialrequest#</p>
				</cfif>

					<cfif len(exhibit.type)>
						<p><span>Exhibitor or Sponsor?</span> #exhibit.type#</p>
					</cfif>

					<p><span>Description (for mobile app): </span>
						#exhibit.description#</p>

					<cfif len(exhibit.sponsordescription)>
						<p><span>Additional Sponsor Description (for mobile app): </span>
							#exhibit.sponsordescription#</p>
					</cfif>	

					<p><span>Website: </span>
					<cfif len(exhibit.website)>
						#linkto(text=fixWebSite(exhibit.website), href="http://#fixWebSite(exhibit.website)#", target="_blank")#</p>

					<p><span>Files (for mobile app): </span>
						#exhibit.files#</p>

					</cfif>
				<cfif FileExists(ExpandPath("/images/conference/exhibitors/#exhibit.logo#"))>
					<p><span>Logo: </span>
						#imageTag(source="/conference/exhibitors/#exhibit.logo#")#</p>
				</cfif>

					<p><span>Check no: </span>
						#dollarformat(exhibit.checkno)#</p>

					<p><span>Check date: </span>
						#exhibit.checkdate#</p>

					<p><span>Amount: </span>
						#exhibit.amount#</p>

					<p><span>Approved: </span>
						#exhibit.approved#</p>

					<p><span>Comments: </span>
						#exhibit.comments#</p>

					<p><span>Sort Order: </span>
							#exhibit.sortOrder#</p>

					<p><span>Created: </span>
						#dateformat(exhibit.createdAt)#</p>


#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this exhibit", action="edit", key=exhibit.id)#
</div>
</cfoutput>
