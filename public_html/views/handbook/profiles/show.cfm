<div id="profile">
<h1>Profile for <cfoutput>#handbookprofile.name#</cfoutput></h1>

<cfoutput>

	<div class="well">
		<cfif handbookpictures.recordcount>

			<cfloop query="handbookpictures">
				<cftry>
				<cfset picHref = replace(cgi.script_name,"index.cfm","")>
				<cfset picHref = replace(cgi.script_name,"rewrite.cfm","")>
				#linkTo(text=imageTag(source="/handbookpictures/thumb_#file#"), href="#picHref#images/handbookpictures/web_#file#")#
				<cfcatch>X</cfcatch>
				</cftry>
			</cfloop>
		</cfif>		

		<cfif isMe>
			<h3>Upload profile picture(s) here:</h3>	
					#errorMessagesFor("handbookpicture")#
			
					#startFormTag(controller="handbook-pictures", action="create", multipart="true")#
				
						
								#hiddenField(objectName='handbookpicture', property='personid')#
								
								<cfif not isdefined("params.key") AND not isdefined("params.profile")>
									#textField(objectName='handbookpicture', property='name', label='Name: ')#
								</cfif>
							
								#fileField(objectName='handbookpicture', property='file', label='Maximum size is 300kb: ', class='maxfilesize')#
							
								#hiddenField(objectName='handbookpicture', property='createdBy')#
							
		
						#submitTag(value="Upload")#
						
					#endFormTag()#
		</cfif>		
	</div>

	<div class="well">
					<p><span>Phone: </span>
						#handbookprofile.phone#</p>
				
					<p><span>Email: </span>
						#handbookprofile.email#</p>
				
					<p><span>Birthday: </span>
						#dateformat(handbookprofile.birthday)#</p>
				
					<p><span>Spouses' Name: </span> 
						#handbookprofile.wife#</p>
				
					<p><span>Spouses' birthday: </span> 
						#dateformat(handbookprofile.wifesbirthday)#</p>
				
					<p><span>Anniversary: </span> 
						#dateformat(handbookprofile.anniversary)#</p>
				
					<p><span>Names/ages of children: </span> <br />
						#handbookprofile.children#</p>
				
					<p><span>Facebook: </span> 
						#handbookprofile.facebook#</p>
				
					<p><span>Twitter: </span> 
						#handbookprofile.twitter#</p>
				
					<p><span>Linkedin: </span> 
						#handbookprofile.linkedin#</p>
				
					<p><span>Other Social Media: </span> <br />
						#handbookprofile.othersocial#</p>
</div>

<div class="well">
				
					<p><span>How long have you been in ministry? How did you get started? </span> <br />
						#handbookprofile.ministrystart#</p>
						
					<p><span>Licensed or Ordained?:</span>#handbookprofile.licensedOrOrdained#</p>

					<p><span>When Licensed or Ordained?:</span>#handbookprofile.licensedOrOrdainedAt#</p>

<!---
				
					<p><span>Licensed? </span> 
						<cftry>
						<cfif handbookprofile.licensed>
							Yes
						<cfelse>
							No
						</cfif>
						<cfcatch>NA</cfcatch>
						</cftry>
						</p>
				
					<p><span>Ordained?</span> 
						<cftry>
						<cfif handbookprofile.ordained>
							Yes
						<cfelse>
							No
						</cfif>
						<cfcatch>NA</cfcatch>
						</cftry>
						</p>
						
					<p><span>What is the date of your ordination? Where? Who were there? </span> <br />
						#handbookprofile.ordination#</p>
				
					<p><span>When did your current ministry begin? </span> 
						#dateformat(handbookprofile.currentministrystartat)#</p>
				
					<p><span>What church are you at? How long have you been there? How did you get there? </span> <br />
						#handbookprofile.currentministry#</p>
				
					<p><span>Does your church have a website address?</span> 
						#handbookprofile.website#</p>
				
					<p><span>Do you write a blog? </span> <br />
						#handbookprofile.blog#</p>
				
					<p><span>Are you a member of AGBM (Association of Grace Brethren Ministers)?</span> 
						
						<cftry>
						<cfif handbookprofile.agbmmember>
							Yes
						<cfelse>
							No
						</cfif>
						<cfcatch>NA</cfcatch>
						</cftry>
							</p>	
</div>

<div class="well">
				
					<p><span>What kind of educational opportunities have you had? </span> <br />
						#paragraphformat(handbookprofile.education)#</p>
				
					<p><span>List degrees earned and yr of graduation: </span> <br />
						#handbookprofile.degrees#</p>
				
					<p><span>What are titles of theses or dissertations which you have written? </span> <br />
						#handbookprofile.paperswritten#</p>
				
					<p><span>What are the titles of any books, pamphlets you have written? </span> <br />
						#handbookprofile.bookswritten#</p>

</div>

<div class="well">							
				
					<p><span>Who have been mentors to you in life and ministry and why? </span> <br />
						#handbookprofile.mentors#</p>
				
					<p><span>What is your role at present? What roles have you had at other churches? </span> <br />
						#paragraphFormat(handbookprofile.roles)#</p>
				
					<p><span>Do you have a "life verse"? What is it and why? Do you have a favorite Bible character and why?</span> <br />
						#handbookprofile.lifeverse#</p>
				
					<p><span>What is your favorite book in the Bible and why? </span> <br />
						#handbookprofile.bookofbible#</p>
				
					<p><span>What is a ministry/life lesson you pass on to others when given the chance? </span> <br />
						#handbookprofile.lessonlearned#</p>
				
					<p><span>What is a ministry/life lesson that you wish someone would have passed on to you? </span> <br />
						#handbookprofile.lessonneeded#</p>
				
					<p><span>What does an ideal retirement or re-treading look like to you?</span> <br />
						#handbookprofile.retirement#</p>
				
					<p><span>What hobbies do you enjoy? What sports teams do you follow? </span> <br />
						#handbookprofile.hobbiessports#</p>
				
					<p><span>What sorts of transferable skills to you have to share with others? </span> <br />
						#handbookprofile.skills#</p>
				
					<p><span>What are you reading lately? Do you have a "Top Ten Books" list? What are they/why?</span> <br />
						#handbookprofile.books#</p>
--->				
</div>
	  					<cfif isDefined("params.admin")>
							#linkTo(text = "Edit this information", controller="handbook-profiles", action="edit", key=handbookprofile.id, params="admin", class="btn")#
						<cfelseif isme>
							#linkTo(text = "Edit this information", controller="handbook-profiles", action="edit", key=handbookprofile.id, class="btn")#
						</cfif>
<p>&nbsp;</p>
					<p><span>Profile #linkTo(text=handbookprofile.id, key=handbookprofile.id, params="type=profile")# was created By: </span>
						#mailto(handbookprofile.createdBy)# on #dateformat(handbookprofile.createdAt)#</p>
				
</cfoutput>
</div>