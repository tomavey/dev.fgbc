<!---cftry--->
<cfset isNotes=arraylen(handbookperson.handbooknotes)>

<cfoutput>
#forcecfcatch()#

<div class="#params.action#" id="showinfo">

	<div id="publicinfo">

	<cfif (isDefined("session.auth.handbook.people") AND gotHandbookPersonRights(handbookperson.id)) OR gotrights("superadmin,office,agbmadmin,handbookedit")>
		
			<ul class="nav nav-pills">
			<li>#linkTo(text="Edit #handbookperson.fname#", route="editHandbookPerson", key=params.key)#</li>
			<li>#linkTo(text="Add a picture of #handbookperson.fname#", route="newHandbookPicture", params="personid=#params.key#")#</li>
			<li>#linkTo(text="This information is correct", route="handbookSetReview", key=params.key)#</li>
			</ul>

		<p class="lastreviewed pull-right">
			<cfif isDefined("handbookperson.reviewedAt") && len(handbookperson.reviewedAt)>
				Last reviewed on #dateformat(handbookperson.reviewedAt)#; 
			</cfif>
			<cfif isDefined("handbookperson.updatedAt") && len(handbookperson.updatedAt)>
				Last updated on #dateformat(handbookperson.updatedAt)#
			</cfif>	
		</p>

	</cfif>
				#includePartial(partial="show")#



				<cfif len(handbookperson.web)>
					<p><span>Web: </span>#linkto(text=fixWebSite(handbookperson.web), href="http://#fixWebSite(handbookperson.web)#")#</p>
				</cfif>

				<cfif len(handbookperson.pic_thumb) and len(handbookperson.pic_big)>
					<p>
						#linkto(text=imageTag(handbookperson.pic_thumb),href="handbookperson.pic_big")#
					</p>
				<cfelseif len(handbookperson.pic_thumb)>
					<p>
						#imagetag(handbookperson.pic_thumb)#
					</p>
				</cfif>

            		 <p><span>Birthday:</span> <cftry>#dateformat(handbookperson.handbookprofile.birthdayasstring,"mmmm dd")#<cfcatch>?</cfcatch></cftry></p>

            		 <cfif len(handbookperson.spouse)>
	            		 <p><span>Anniversary:</span> <cftry>#dateformat(handbookperson.handbookprofile.anniversaryasstring,"mmmm dd")#<cfcatch>?</cfcatch></cftry></p>
            		 </cfif>

            		 <cfif len(handbookperson.spouse)>
					 	 <p><span>Spouses' Birthday:</span> <cftry>#dateformat(handbookperson.handbookprofile.wifesbirthdayasstring,"mmmm dd")#<cfcatch>?</cfcatch></cftry></p>
					 </cfif>

					 <p><span>Facebook:</span> <cftry>#handbookperson.handbookprofile.facebook#<cfcatch>?</cfcatch></cftry></p>

					 <p><span>Twitter:</span> <cftry>#handbookperson.handbookprofile.twitter#<cfcatch>?</cfcatch></cftry></p>

					 <p><span>LinkedIn:</span> <cftry>#handbookperson.handbookprofile.linkedin#<cfcatch>?</cfcatch></cftry></p>

					 <p><span>Other Social Media:</span> <cftry>#handbookperson.handbookprofile.othersocial#<cfcatch>?</cfcatch></cftry></p>

					 <p><span>Licensed or Ordained?</span> <cftry>#handbookperson.handbookprofile.licensedorordained#<cfcatch>?</cfcatch></cftry></p>

					 <p><span>When Licensed or Ordained:</span> <cftry>#handbookperson.handbookprofile.licensedorordainedat#<cfcatch>?</cfcatch></cftry></p>

				<div id="ajaxinfo">

					 <p><span>When did you begin ministry in a Grace Brethren Church or ministry?</span> <cftry>#handbookperson.handbookprofile.ministrystartat#<cfcatch>?</cfcatch></cftry></p>

					 <p><span>How did you get started? Where have you served and when?</span></p>
					 <p style="margin-left:20px">#handbookperson.handbookprofile.currentministry#
					</p>

					 <cfif isAgbmMember(params.key)>
					 	<p>Member of the Inspire, Charis Pastors Network</p>
					 </cfif>
					 <cfif isAGBM(params.key) and gotRights("office") and NOT isAgbmMember(params.key)>
					 	<p>Former member of the Inspire.</p>
					 </cfif>
	
				</div>

    				<p>
        				<cfif handbookperson.updatedAt NEQ handbookperson.reviewedat>
        					  Updated: #dateformat(handbookperson.updatedat,"medium")#<br/>
        				</cfif>
        				<cfif isDate(handbookperson.reviewedat)>
        					  Reviewed: #dateformat(handbookperson.reviewedAt,"medium")#
        					  <cfif len(handbookperson.reviewedby)>
        					  	by #handbookperson.reviewedby#
        					  </cfif>
        				</cfif>
    				</p>

    				<cfif (isDefined("session.auth.handbook.people") AND gotHandbookPersonRights(handbookperson.id)) OR gotrights("superadmin,office,agbmadmin,handbookedit")>
    					<p>#linkTo(text="This information is correct", route="handbookSetReview", key=params.key, class="btn tooltipside", title="Click this to let us know when the information is correct")#</p>
    					<p>#linkTo(text="Edit #handbookperson.fname# #handbookperson.lname#", route="editHandbookPerson", key=params.key, class="btn")#</p>
    					<p>#linkTo(text="Add a picture of #handbookperson.fname#", route="newHandbookPicture", params="personid=#params.key#", class="btn")#</p>
    				</cfif>

    				<cfif NOT flashIsEmpty()>
    					<p class="success-message alert alert-error">
    						#flash("notpresent")#
    					</p>
    				</cfif>

				<p>&nbsp;</p>

	</div>

	<div id="tagsinfo" class="well">

					<p><span>Tags:</span>
						<cfloop query="tags">
							<cftry>
							#linkTo(text=tag, controller="handbook.tags", action="show", key=tag)#
							#linkTo(
								text="<span style='color:grey'><sup>x</sup></span>",
								route="handbookRemoveFromTag",
								key=tag,
								params="tag=#tag#&itemid=#itemid#",
								class="tooltipside",
								title="Remove #handbookperson.fname# from #tag#"
								)#;
							<cfcatch>,</cfcatch>
							</cftry>	
						</cfloop>
					</p>

					<p class="form-inline">Tag this person (separate multiple tags with a comma):
					<fieldset>
						#startFormTag(route="handbookTags", class="form-search")#
						<div class="input-append">
						#hiddenFieldTag(name="itemid", value=params.key)#
						#hiddenFieldTag(name="type", value="person")#
						<cfif isdefined("session.auth.username")>
							#hiddenFieldTag(name="username", value=session.auth.username)#
						<cfelse>
							#hiddenFieldTag(name="username", value=session.auth.email)#
						</cfif>
						#textFieldTag(name="tags", prependToLabel="", append="", class="span2 search-query")#
						<button type="submit" class="btn">Tag</button>
						</div>
						#endformTag()#
					</fieldset>
					</p>

	</div>

<!--- The notes sections needs more testing

	<div id="notesinfo" class="well">
					<p>Most recent note for #handbookperson.fname#:</p>
					<cfif isNotes>
					<p style="margin-left:20px">#handbookperson.handbooknotes[isNotes].note#</p>
						<p>#linkTo(text="View all my notes for #handbookperson.fname#", controller="handbook.notes", action="show", key=params.key, params="pid=#params.key#", class="btn")#</p>
					</cfif>
					<p>#linkto(text="Add a new note", controller="handbook.notes", action="new", params="pid=#params.key#", class="btn")#</p>
	</div>
--->

	</p>#linkTo(text="View updates to #handbookperson.fname#'s record.", controller="handbook.updates", action="index", params="showperson=#params.key#", class="btn")#</p>

	<cfif gotrights("ministryadmin,agbm,office,superadmin,agbmadmin,handbookedit")>

		<div id="officeonly">
		For Office Use Only:
			<cfif gotRights("superadmin,office,agbmadmin,handbookedit")>
					<p><span>Comment:</span> <br />
						#handbookperson.comment#</p>

					<p><span>Send Handbook: </span>#handbookperson.sendHandbook#</p>

					<p><span>Created: </span>#dateformat(handbookperson.createdAt)#</p>

					<p><span>Updated: </span>#dateformat(handbookperson.updatedAt)#</p>

					<p><span>Reviewed: </span>#dateformat(handbookperson.reviewedAt)#</p>

				<cfif len(handbookperson.handbookprofile.agbmlifememberAt)>
					<p><span>Lifetime member of Inspire since: </span>#handbookperson.handbookprofile.agbmlifememberAt#</p>
				</cfif>		

					<p>#editTag(handbookperson.id)# #deleteTag(id=handbookperson.id, class="noAjax")#</p>
					<i class='fa fa-trash'></i>
					<cfif handbookperson.hideFromPublic>
						<p> The record for #handbookperson.fname# is hidden from public.</br>
							#linkTo(text="Un-hide #handbookperson.fname# from public", controller="handbook.people", action="unHideFromPublic", params="personid=#handbookperson.id#", class="btn")#
						</p>
					<cfelse>
						<p>#linkTo(text="Hide #handbookperson.fname# from public", controller="handbook.people", action="hideFromPublic", params="personid=#handbookperson.id#", class="btn")#</p>
					</cfif>


					<p>#linkto(text="Add a new position for #handbookperson.fname#", route="handbookAddnewposition", key=params.key, class="btn")#</p>

					<p>#linkto(text="Add an AGBM-Only position for #handbookperson.fname#", route="handbookAddnewposition", key=params.key, class="btn", params="position=#urlEncodedFormat('AGBM Only')#&sortorder=500&positiontypeid=32")#</p>

					<p>#linkto(text="Add an AGBM payment for #handbookperson.fname#", route="handbookAddAGBMPayment", key=params.key, class="btn")#</p>

<!---

					<p>#linkTo(text="Search Conference regs for #handbookperson.lname#", controller="conference.registrations", action="showsearch", params="search=#handbookperson.lname#", class="btn", target="_new")#</p>

				#includePartial(partial="groups")#
--->
					<cftry>
					<p>
					#linkto(text="Access handbook as #handbookperson.fname# #handbookperson.lname#", route="handbookUnlockLinkfor", key=encrypt(handbookperson.email,getSetting("passwordkey"),"CFMX_COMPAT","HEX"), onlyPath=false, params="logoutfirst=true", class="btn")#
					</p>
					<cfcatch></cfcatch></cftry>
					<cftry>
					<p>
					#mailTo(name="Email a handbook unlock link to #handbookperson.email#",emailaddress='#handbookperson.email#?subject=Your%20Link%20to%20the%20Charis%20Fellowship%20Handbook&body=http://#cgi.http_host#/index.cfm/handbook/unlock/#encrypt(handbookperson.email,getSetting("passwordkey"),"CFMX_COMPAT","HEX")#', class="btn")#
					</p>

					<cfcatch></cfcatch></cftry>
			</cfif>
		</div>

	</cfif>


</div>

</cfoutput>
<!---
	<cfcatch>
		<cfset session.cfcatch = structNew()>
		<cfif isDefined("cfcatch.message")>
			<cfset session.cfcatch = cfcatch>
		</cfif>
		<cfset #sendPersonPageErrorNotice()#>
	        	<cfset redirectTo(action="index", error="Oops! Something went wrong try to access this person.  We are working on a solution. You should be able to continue from this page.")>
	</cfcatch>
</cftry>
--->
