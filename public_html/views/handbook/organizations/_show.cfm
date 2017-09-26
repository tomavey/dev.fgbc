<cfset params.reverse = 0>
<cfset allEmails = "">

<cfoutput>
	<h2>#handbookorganization.name#</h2>
	<cfif NOT isAjax() AND gotrights("superadmin,office,agbmadmin,handbookedit")>
			<p id="editicon">
			  #linkto(text='<i class="icon-edit"></i>', action="edit", key=params.key, class="tooltipleft", title="Edit #handbookorganization.name#")#
			</p>
	</cfif>

	<p>
		#handbookorganization.address1#<br/>
		<cfif len(handbookorganization.address2)>
			#handbookorganization.address2#<br/>
		</cfif>
		#handbookorganization.org_city#, #handbookorganization.handbookstate.state# #handbookorganization.zip#<br/>
		<cfif isDefined('handbookorganization.meetingplace') && len(handbookorganization.meetingplace)>
			Meeting at: #handbookorganization.meetingplace#<br/>
		</cfif>
		#handbookorganization.phone#<br/>
		#mailto(handbookorganization.email)#<br/>
		<cfif gotrights("office") and len(handbookorganization.email2)>
		GTD Email: #mailto(handbookorganization.email2)#<br/>
		</cfif>
		<cfif len(handbookorganization.website)>
		  #linkTo(text=fixWebSite(handbookorganization.website), href="http://#fixWebSite(handbookorganization.website)#", target="new")#<br/>
		</cfif>
		<cfif len(handbookorganization.facebook)>
		  #linkTo(text=fixFacebook(handbookorganization.facebook), href="http://#fixFacebook(handbookorganization.facebook)#", target="new")#<br/>
		</cfif>
		<cfif len(handbookorganization.twitter)>
		  #linkTo(text=fixTwitter(handbookorganization.twitter), href="http://#fixTwitter(handbookorganization.twitter)#", target="new")#<br/>
		</cfif>
		<cfif len(handbookorganization.instagram)>
		  #linkTo(text=fixInstagram(handbookorganization.instagram), href="http://#fixInstagram(handbookorganization.instagram)#", target="new")#
		</cfif>
	</p>

	<cfif isDefined("positions") AND showStaffList(handbookorganization.id)>
		<div>
			<span>Staff: </span>
				<cfloop query="positions">
					<cfif len(position)>
						<cfif params.reverse>
							<cfset thisname = "#fname# #lname#">
						<cfelse>
							<cfset thisname = "#lname#, #fname#">
						</cfif>
						<p id="stafflist">#linkTo(
								text="#thisname#; #position#",
								controller="handbook.People",
								action="show",
								class="tooltip2",
								title="Click to show #fname# #lname# in the center panel.",
								key=personid
								)#
						</p>
						<cfif isValid("email",email)>
							<cfset allemails = allemails & "; " & email>
						</cfif>
					</cfif>
				</cfloop>
				<cfif NOT isAjax() AND gotrights("superadmin,office,handbook,ministrystaff")>
				<p>
					<cfset allemails = replace(allemails,"; ","","one")>
					#mailto(emailaddress=allemails, name="Create an email to all staff", class="btn")#
				</p>
				</cfif>
		</div>
	</cfif>

<span style="font-size:.8em;color:gray;display:block;text-align:right">#dateformat(handbookorganization.reviewedAt)#/#dateformat(handbookorganization.updatedAt)#	</span>
</cfoutput>