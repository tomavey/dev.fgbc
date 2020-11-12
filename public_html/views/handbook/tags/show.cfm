<cfparam name="selectDefault" default="--Select One---">
<cfparam name="emailDelimiter" default="semi-colon">

<cfif isDefined("params.emailDelimiter")>
	<cfset emailDelimiter = params.emailDelimiter>
</cfif>

<cfif !isDefined("params.key") && isDefined("params.tag") >
	<cfset params.key = params.tag>
</cfif>

<!--- <cfdump var="#people#" abort> --->

<cfset peoplecount = 0>
<cfset churchcount = 0>


<div id="show">
	<!--- <cfdump var="#params#"> --->
	
	<cfset emailall = "">
	<cfset namesAll = "">
	<cfset namesThis = "">

	<cfoutput>
	<h2>Tag: "#params.key#"</h2>

	<cfif gotRights("superadmin")>
		<div style="font-size:.8em;color:gray">
			<p>
				Tag ids: #session.tags.tagids#
			</p>
		</div>
	</cfif>

	<cfif listLen(session.tags.usernames)>
		<p>This tag is shared by #session.tags.usernames#</p>
	</cfif>

	<div class="well">	
		<p>
			#startFormTag(action="changeTag")#
			#hiddenFieldTag(name="key", value=params.key)#
			#textFieldTag(name="newTag", placeholder="Rename this tag")#
			#submitTag()#
			#endFormTag()#
		</p>
	</div>	
	
	<div class="well">	

		<p>
			#linkto(text="Download #params.key#", action="download", key=params.key, class="btn")#<br/>

			#linkTo(text="Remove #params.key#", action="remove", params="tag=#params.key#", onclick="return confirm('Are you sure you want to remove this tag?')", class="btn btn-medium")#<br/>

			#linkTo(text="Copy #params.key#", action="duplicateTag", key=params.key, class="btn btn-medium")#
		</p>			
		
	</div>
	</cfoutput>
	
	<cfif handbookTaggedPeople.recordcount>
		<h3>People:</h3>
	</cfif>

	<!---PEOPLE--->
	<!--- <cfdump var="#handbookTaggedPeople#"> --->
		<cfoutput query="handbookTaggedPeople" group="itemid">
			<cfset email = trim(email)>
			<cfset namesThis = selectName>
				<p>#linkTo(
							text="#fname# #lname#",
							controller="handbook.people", 
							action="show", 
							class="ajaxclickable tooltip2", 
							title="Click to show #fname# #lname# in the center panel.", 
							key=itemid
							)# 
					-
					#linkTo(
							text="x",
							action="removeFromTag",
							params="tag=#params.key#&itemid=#itemid#&username=#username#",
							class="tooltipside",
							title="Remove #fname# from #params.key#"
							)#
					<cfset request.personupdatedat = personupdatedat(itemid)>
					<cfif len(request.personupdatedat)>
					#linkto(
							text=dateformat(request.personupdatedat), 
							controller="handbook.updates", 
							action="index", 
							params="showperson=#itemid#", 
							class="updatedat tooltipside", 
							title="View updates for #fname#"
							)#
					</cfif>
					<span class="updatedat tooltipside" title="Tagged by #username#">?</span>
				</p>
				<cfif isvalid("email",email)>
					<cfset emailall = emailall & "; " & email>
				</cfif>
			<cfset namesAll = namesAll & '; ' & namesThis> 
			<cfset peoplecount = peoplecount + 1>
		</cfoutput>	
		<cfif handbookTaggedPeople.recordcount>
			<cfoutput>Count = #peoplecount#</cfoutput>
		</cfif>
		<cfif handbookTaggedOrganizations.recordcount>
			<h3>Organizations:</h3>	
		</cfif>		
		
	<!---ORGANIZATIONS--->
		<cfoutput query="handbookTaggedOrganizations" group="itemid">
			<cfset namesThis = "#name#: #org_city#,#state_mail_abbrev#">
			<p>#linkTo(
					   text="#name#: #org_city#,#state_mail_abbrev#",
					   controller="handbook.organizations", 
					   action="show", 
					   class="ajaxclickable tooltip2", 
					   title="Click to show #name# in the center panel.", 
					   key=itemid
					   )#
				-
				#linkTo(
						text="x",
						action="removeFromTag",
						params="tag=#params.key#&itemid=#itemid#&username=#username#",
						class="tooltipside",
						title="Remove #name# from #params.key#"
						)#
				<span class="updatedat tooltipside" title="Tagged by #username#">?</span>
			</p>
			<cfif isvalid("email",email)>
				<cfset emailall = emailall & "; " & email>
			</cfif>
		<cfset churchcount = churchcount + 1>	
		<cfset namesAll = namesAll & ', ' & namesThis> 
		</cfoutput>
		<cfif handbookTaggedOrganizations.recordcount>
			<cfoutput>Count = #churchcount#</cfoutput>
		</cfif>

		<cfset emailall = replace(emailall,";","","one")>
		<cfset emailAllComma = replace(emailall,";",",","all")>
		
	<cfoutput>
			
		<!---Send Email to items in tag--->			
		<p>#linkTo(text='Email Everyone Tagged "#params.key#" (semicolon delimited)', href="mailto:#emailall#", class="btn tooltipside", title="This will create one email message in your email client (ie:outlook) to all these people/organizations" )#</p>
		<p>#linkTo(text='Email Everyone Tagged "#params.key#" (comma delimited)', href="mailto:#emailallComma#", class="btn tooltipside", title="This will create one email message in your email client (ie:outlook) to all these people/organizations" )#</p>
		<p>Some email clients prefer comma delimited.</p>
		<br/>
		<p>
			List of names-<br/> #replace(namesAll,'; ','','one')#
		</p>
		<p>&nbsp;</p>
		<p>
			<cfif emailDelimiter === "semi-colon">
				List of emails-<br/> #replace(emailAll,'','','one')#
			<cfelse>	
				List of emails-<br/> #replace(emailAll,';',',','all')#
			</cfif>
		</p>
		#emailDelimiter#
		<p class="pull-right">
			<cfif emailDelimiter === "comma">
				#linkTo(text="(Change delimiter > semi-colon)", controller="handbook.tags", action="show", key=params.key, params="emailDelimiter=semi-color")#
			<cfelseif emailDelimiter === "semi-colon">	
				#linkTo(text="(Change delimiter > comma)", controller="handbook.tags", action="show", key=params.key, params="emailDelimiter=comma")#
			</cfif>
		</p>

		<!---Add one person to this tag--->
		<p>&nbsp;</p>
			<div class="well">
				<p>
					#startFormTag(action="create")#
					#hiddenFieldTag(name="tags", value=params.key)#
					#hiddenFieldTag(name="username", value=session.tags.usernames)#
					#hiddenFieldTag(name="type", value="person")#
					#selectTag(name="itemid", options=people, includeBlank="-Add one person-", valuefield="id", textfield="selectname")#
					#submitTag("Add to tag")#
					#endFormTag()#
				</p>
			
			</div>	

		<!---Add one organization to this tag--->
		<div class="well">
				<p>
					#startFormTag(action="create")#
					#hiddenFieldTag(name="tags", value=params.key)#
					#hiddenFieldTag(name="username", value=session.auth.username)#
					#hiddenFieldTag(name="type", value="organization")#
					#selectTag(
						name="itemid", 
						options=organizations, 
						includeBlank="-Add one organization-", 
						valuefield="id", 
						textfield="selectnamecity", 
						selected=selectDefault
						)#
					#submitTag("Add to tag")#
					#endFormTag()#
				</p>
			
			</div>	
		<div class="well">
			<h3>Sharing</h3>
		<!---Copy this tag and send to another user--->
			<div class="well">
				<p>
					<cfset selectDefault = "--Select one person--">
					#startFormTag(action="copyTags")#
					#hiddenFieldTag(name="tag", value=params.key)#
					#hiddenFieldTag(name="type", value="person")#
					#hiddenFieldTag(name="shareOrCopy", value="copy")#
					#hiddenFieldTag(name="username", value=session.auth.username)#
					#selectTag(
						name="newuserName", 
						options=people, 
						includeBlank=selectDefault, 
						valuefield="email", 
						textfield="selectname", 
						selected=selectDefault
						)#
					<!--- <select name="newuserName">
						<cfscript>
							writeOutput("<option value=''>--Select one person--</option>")
							queryEach(people, function(el){
								writeOutput("<option value='#el.email#'>#el.selectName#</option>")
							})
						</cfscript>
					</select> --->
					#submitTag("Send this tag to another handbook user")#
					#endFormTag()#
				</p>
				<p>
					This tag list will not sync with the shared list when you make changes.  However, re-sharing this tag list will update the shared tag list.
				</p>
			</div>	

		<!---Share this tag with another user--->
			<div class="well">
				<p>
					#startFormTag(action="shareTag")#
					#hiddenFieldTag(name="tag", value=params.key)#
					#hiddenFieldTag(name="type", value="person")#
					#hiddenFieldTag(name="shareOrCopy", value="share")#
					#hiddenFieldTag(name="username", value=session.tags.usernames)#
					#selectTag(
						name="newuserName", 
						options=people, 
						includeBlank=selectDefault, 
						valuefield="email", 
						textfield="selectname",
						selected=selectDefault
						)#
					#submitTag("Share this tag with another handbook user")#
					#endFormTag()#
				</p>
				<p>
					This tag list will sync with the shared list when you make changes.
				</p>
			</div>	

		<!---Share this tag with another user group--->
			<cfif isDefined("session.auth.rightslist")>
				<div class="well">
					<p>
						<cfset selectDefault = "--Select one user group--">
						#startFormTag(action="shareTagWithGroup")#
						#hiddenFieldTag(name="tag", value=params.key)#
						#hiddenFieldTag(name="type", value="person")#
						#hiddenFieldTag(name="username", value=session.auth.username)#
						#selectTag(
							name="userGroup", 
							options=session.auth.rightslist, 
							includeBlank=selectDefault, 
							valuefield="id", 
							textfield="selectname",
							selected=selectDefault
							)#
						#submitTag("Share this tag with a user group")#
						#endFormTag()#
					</p>
					<p>
						This tag list will sync with others in the same user group.
					</p>
				</div>	
			</cfif>

		</div>

	</cfoutput>		

</div>