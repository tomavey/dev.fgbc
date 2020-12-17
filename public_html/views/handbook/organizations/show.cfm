<cfoutput>
<div class="#params.action#" id="showinfo">
	 				#showHandbookListingLink(params.key)#

					#includePartial(partial="show")#
<br/>
					<div class="googlemap">
			          <cfif not handbookorganization.address1 contains "box">
			          <cfscript>
					  	mapaddress = handbookorganization.address1&",+"&handbookorganization.org_city&",+"&handbookorganization.handbookstate.state;
						mapaddress = replace(mapaddress," ","+","all");
					  </cfscript>
			          <a href="http://maps.google.com/maps?hl=en&amp;safe=off&amp;q=#mapaddress#">Google Map</a>
			          </cfif>
			       </div>

					<p><span>District: </span>#handbookorganization.handbookdistrict.district#</p>

					<p><span>Public Name: </span>#handbookorganization.alt_name#</p>

					<p><span>Fax: </span>#handbookorganization.fax#</p>

					<cfif len(handbookorganization.meetingplace)>

						<p><span>Meeting at: </span>#handbookorganization.meetingplace#</p>

					</cfif>

					<cfif gotrights("superadmin")>
						<p><span>Comments: </span> <br />
							#handbookorganization.comments#</p>

						<p><span>Updated: </span>#dateformat(handbookorganization.updatedAt)# by #handbookorganization.updatedBy#</p>

						<p>GTD Emails: #mailto(getOrgEmails(params.key))#</p>

					<cfif len(handbookorganization.reviewedAt)>
						<p><span>Reviewed: </span>#dateformat(handbookorganization.reviewedAt)# by #handbookorganization.reviewedBy#</p>
					</cfif>
					</cfif>

					<p><span>Status: </span>#handbookorganization.handbookstatus.status#</p>

					<cfif len(handbookorganization.joinedAt)>
						<p><span>Year Joined: </span>#handbookorganization.joinedAt#</p>
					</cfif>

				<cfif gotRights("office")>
					<cfif len(handbookorganization.fein)>
						<p><span>FEIN: </span>#handbookorganization.fein#</p>
					</cfif>
					<cfif len(handbookorganization.inGroupRoster)>
						<p><span>In Group Roster?: </span>#handbookorganization.inGroupRoster#</p>
					</cfif>
				</cfif>	

        		<cfif (isdefined("session.auth.handbook.people") AND gotHandbookOrganizationRights(handbookorganization.id)) OR gotRights("superadmin,office,agbmadmin")>
                  <div class="btn-group">
                    <button class="btn dropdown-toggle btn-large" data-toggle="dropdown">
                    Edit
        			<span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
        			   #linkTo(text="#handbookorganization.name#", action="edit", key=handbookorganization.id)#
        			   <br/>
        				#linkTo(text="Printed Handbook Listing", controller="handbook.organizations",action="handbookpages",key=params.key)#
                    </ul>
                  </div>
        		</cfif>

				<p>&nbsp;</p>

				<div class="well">

					<p><span>Tags:</span>

						<cfloop query="tags">
							#linkTo(text=tag, controller="handbook.tags", action="show", key=tag)#;
						</cfloop>
					</p>

					<p>Tag this church or ministry (separate multiple tags with a comma):
						#startFormTag(controller="handbook.tags", action="create")#
						#hiddenFieldTag(name="itemid", value=params.key)#
						#hiddenFieldTag(name="type", value="organization")#
						#hiddenFieldTag(name="username", value=session.auth.username)#
						#textFieldTag(name="tags")#
						#submitTag("Save Tag(s)")#
						#endformTag()#
					</p>

				</div>

					<p>#linkTo(text="View Statistics",controller="handbook.statistics",action="show",key=params.key)#</p>
					<cfif gotrights("office,handbookedit")>
						<cftry>
						<p>Reviewer Link:<br/><br/> #linkto(route="reviewhandbook", orgid=simpleEncode(params.key), onlyPath=false)#
						<cfif allowHandbookOrgUpdate()>
							<p style="font-size:.8em;padding-left:10px">Reviewer link functionality is turned off. #linkto(text="Change allowHandbookOrgUpdate setting to true to activate", controller="admin.settings", action="index", params="category=handbook")# </p>
						</cfif>
						</p>
						<cfcatch></cfcatch>
						</cftry>
					</cfif>
					<p>&nbsp;</p>

</div>
<cfif gotRights("superadmin,office,handbookedit")>
#linkTo(text="Delete this church or ministry", controller="handbook.organizations", action="delete", key=params.key, method="delete", onClick="return confirm('Are you sure? It might be better to mark this church as closed in case AGBM members are still connected to this church')", class="btn")#
<cfif len(handbookorganization.fein)>
<p>FEIN ##: #handbookorganization.fein#</p>
<p>501c3 group roster? 
		<cfif !len(handbookorganization.ingrouproster)>
			No
		<cfelse>
			#handbookorganization.ingrouproster#
		</cfif>
</p>
</cfif>
</cfif>

</cfoutput>