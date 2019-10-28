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
		#phoneTo(handbookorganization.phone)#<br/>
		<cfif gotRights("office")>
			#telCoQueryLink(handbookorganization.phone)#
			#linkto(text="?", href="https://charisfellowship.us/admin/settings/17", target="_new")#<br/>
		</cfif>
		#mailto(handbookorganization.email)#<br/>
		<cfif gotrights("office") and len(handbookorganization.email2)>
		GTD Email: #mailto(handbookorganization.email2)#<br/>
		</cfif>
		<cfif len(handbookorganization.website)>
			#linkTo(text=fixWebSite(handbookorganization.website), href="http://#fixWebSite(handbookorganization.website)#", target="new")#<br/>

			<cftry>
				<cfif !urlExists(fixWebSite(handbookorganization.website))>
					<span>...WEBSITE NOT WORKING!!!</span>  
				</cfif>
					<cfcatch>
						<span>...BAD WEB ADDRESS!!!</span>  
				</cfcatch>
			</cftry>

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
							<cfset thisname = "#alias('fname',fname,id)# #alias('lname',lname,id)#">
						<cfelse>
							<cfset thisname = "#alias('lname',lname,id)#, #alias('fname',fname,id)#">
						</cfif>
						<p id="stafflist">#linkTo(
								text="#thisname#; #position#",
								controller="handbook.People",
								action="show",
								class="tooltip2 ajaxclickable",
								title="Click to show #alias('fname',fname,id)# #alias('lname',lname,id)# in the center panel.",
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