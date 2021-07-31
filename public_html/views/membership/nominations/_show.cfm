<cfoutput>
					<p><span>Name of person placing the nomination: </span>
						#nominations.name#</p>

					<p><span>Email of person placing the nomination: </span>
						#nominations.email#</p>

					<p><span>Position of person placing the nomination: </span>
						#nominations.position#</p>

					<p><span>Phone of person placing the nomination: </span>
						#nominations.phone#</p>

					<p><span>District nominating: </span> #nominations.district.district#</p>

					<p><span>Region: </span> #nominations.region#</p>

					<p><span>The nomination process: </span> <br />
						#nominations.describeNomination#</p>

					<p><span>Nominees Name: </span>
						#nominations.nomineeName#</p>

					<p><span>Nominees Email: </span>
						#mailto(nominations.nomineeEmail)#</p>

					<p><span>Nominees Church: </span>
						#nominations.nomineeChurch#</p>

					<p><span>Nominees Bio: </span> <br />
						#nominations.bio#</p>

					<p><span>Nominees Bio (short): </span> <br />
						#nominations.bioShort#</p>

					<cfif len(nominations.piclink)>

					<p><span>Piclink: </span>
						#linkto(text=nominations.piclink, href="/images/fellowshipcouncil/nominated/#nominations.piclink#")#</p>

					</cfif>

					<cfif len(nominations.comments)>

					<p><span>Comments: </span> <br />
						#nominations.comments#</p>

					</cfif>

					<p><span>Created: </span> #dateformat(nominations.createdAt)#</p>
</cfoutput>