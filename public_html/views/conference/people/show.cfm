<cfparam name="useForCreditFields" default=0>
<div class="eachItemShown show">
<cfoutput>

					<p><span>ID: </span>
						#people.ID#</p>

					<p><span>Family Name: </span>
						#linkto(text=people.family.lname, controller="conference.families", action="show", key=people.family.id)#</p>

					<p><span>First Name: </span>
						#people.fname#</p>

					<p><span>Email: </span>
						#people.email#</p>

					<p><span>Phone: </span>
						#people.phone#</p>

					<p><span>Age Range: </span>
						#people.age_ranges.description#</p>

					<p><span>Gender: </span>
						#people.gender#</p>

					<p><span>Type: </span>
						#people.type#</p>

					<p><span>Church Name: </span>
						#people.churchname#</p>
				<cfif isDefined("people.handbookpersonid") and len(people.handbookpersonid)>
					<p><span>Linked To Handbook: </span>
						#linkTo(text=people.handbookpersonid, href="/index.cfm?controller=handbook-people&action=show&personid=#people.handbookpersonid#")#</p>
				</cfif>
				<!---
					<p><span>#linkTo(text="Link to handbook", controller="conference.registrations", action="connecttohandbook", key=params.key)#</span></p>
				--->

					<p><span>Created: </span>
						#dateformat(people.createdat, "medium")#</p>

					<p><span>Updated: </span>
						#dateformat(people.updatedat, "medium")#</p>

				<cfif otherPeopleInSameFamily.recordcount>
					<p>Other people in the #people.family.lname# family:
					<cfoutput query = "otherPeopleInSameFamily">
					#linkto(text=fname, controller="conference", action="people", key=id)#;
					</cfoutput>
					</p>
				</cfif>

				<cfif useForCreditFields>

					<p><span>Title</span> <br />
						#people.title#</p>

					<p><span>Type</span> <br />
						#people.type#</p>

					<p><span>Socsec</span> <br />
						#people.socsec#</p>

					<p><span>Birthdate</span> <br />
						#people.birthdate#</p>

					<p><span>Age</span> <br />
						#people.age#</p>

					<p><span>Maritalstatus</span> <br />
						#people.maritalstatus#</p>

					<p><span>Ethnic</span> <br />
						#people.ethnic#</p>

					<p><span>Gender</span> <br />
						#people.gender#</p>

					<p><span>Churchaddress</span> <br />
						#people.churchaddress#</p>

					<p><span>Churchcity</span> <br />
						#people.churchcity#</p>

					<p><span>Churchstate</span> <br />
						#people.churchstate#</p>

					<p><span>Churchzip</span> <br />
						#people.churchzip#</p>

					<p><span>Specialcode</span> <br />
						#people.specialcode#</p>

					<p><span>Hsname</span> <br />
						#people.hsname#</p>

					<p><span>Hsaddress</span> <br />
						#people.hsaddress#</p>

					<p><span>College1name</span> <br />
						#people.college1name#</p>

					<p><span>College1state</span> <br />
						#people.college1state#</p>

					<p><span>College1dates</span> <br />
						#people.college1dates#</p>

					<p><span>College1hours</span> <br />
						#people.college1hours#</p>

					<p><span>College1degree</span> <br />
						#people.college1degree#</p>

					<p><span>College2name</span> <br />
						#people.college2name#</p>

					<p><span>College2state</span> <br />
						#people.college2state#</p>

					<p><span>College2dates</span> <br />
						#people.college2dates#</p>

					<p><span>College2hours</span> <br />
						#people.college2hours#</p>

					<p><span>College2degree</span> <br />
						#people.college2degree#</p>

					<p><span>College3name</span> <br />
						#people.college3name#</p>

					<p><span>College3state</span> <br />
						#people.college3state#</p>

					<p><span>College3dates</span> <br />
						#people.college3dates#</p>

					<p><span>College3hours</span> <br />
						#people.college3hours#</p>

					<p><span>College3degree</span> <br />
						#people.college3degree#</p>

					<p><span>College4name</span> <br />
						#people.college4name#</p>

					<p><span>College4state</span> <br />
						#people.college4state#</p>

					<p><span>College4dates</span> <br />
						#people.college4dates#</p>

					<p><span>College4hours</span> <br />
						#people.college4hours#</p>

					<p><span>College4degree</span> <br />
						#people.college4degree#</p>

					<p><span>Churchcode</span> <br />
						#people.churchcode#</p>
			</cfif>

<cfif gotRights("office")>
#linkToList(text="Return to the listing", action="index")# | #linkTo(text="Edit this person", action="edit", key=people.ID)# | 	#deleteTag(id=people.ID, class="notajax")#
</cfif>

<div class="well">
<p>Registrations for this person:</p>
<div class="offset1">
<cfoutput query="regsforthisperson">
<cftry>
	Description: #buttondescription#: #quantity# @ #dollarformat(conferenceOptioncost)#<br/>
	Invoice: #linkto(text=ccorderid, controller="conference.invoices", action="show", key=equip_invoicesid, target="_blank")# - #dollarformat(ccamount)# - #getRegStatus(ccstatus)#<br/><br/>
<cfcatch>oops</cfcatch>
</cftry>
</cfoutput>
</div>
</div>


</cfoutput>
</div>