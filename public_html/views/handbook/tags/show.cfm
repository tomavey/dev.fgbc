<cfset peoplecount = 0>
<cfset churchcount = 0>

<div id="show">
	
	<cfset emailall = "">
	<cfset namesAll = "">
	<cfset namesThis = "">

	<cfoutput>
	<h2>Tag: "#params.key#"</h2>

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

			#linkTo(text="Remove #params.key#", action="removeTag", key=params.key, onclick="return confirm('Are you sure you want to remove this tag?')", class="btn btn-medium")#<br/>

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
							params="tag=#params.key#&itemid=#itemid#",
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
						params="tag=#params.key#&itemid=#itemid#",
						class="tooltipside",
						title="Remove #name# from #params.key#"
						)#
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
		
<p>#linkTo(text='Email Everyone Tagged "#params.key#" (semicolon delimited)', href="mailto:#emailall#", class="btn tooltipside", title="This will create one email message in your email client (ie:outlook) to all these people/organizations" )#</p>
<p>#linkTo(text='Email Everyone Tagged "#params.key#" (comma delimited)', href="mailto:#emailallComma#", class="btn tooltipside", title="This will create one email message in your email client (ie:outlook) to all these people/organizations" )#</p>
<p>Some email clients prefer comma delimited.</p>
<br/>
<p>
	List: #replace(namesAll,'; ','','one')#
</p>

<p>&nbsp;</p>
	<div class="well">
		<p>
			#startFormTag(action="create")#
			#hiddenFieldTag(name="tags", value=params.key)#
			#hiddenFieldTag(name="username", value=session.auth.username)#
			#hiddenFieldTag(name="type", value="person")#
			#selectTag(name="itemid", options=people, includeBlank="-Add one person-", valuefield="id", textfield="selectname")#
			#submitTag("Add to tag")#
			#endFormTag()#
		</p>
		
	
	</div>	

	<div class="well">
		<p>
			#startFormTag(action="create")#
			#hiddenFieldTag(name="tags", value=params.key)#
			#hiddenFieldTag(name="username", value=session.auth.username)#
			#hiddenFieldTag(name="type", value="organization")#
			#selectTag(name="itemid", options=organizations, includeBlank="-Add one organization-", valuefield="id", textfield="selectname")#
			#submitTag("Add to tag")#
			#endFormTag()#
		</p>
		
	
	</div>	

	<div class="well">
		<p>
			#startFormTag(action="shareTag")#
			#hiddenFieldTag(name="tag", value=params.key)#
			#hiddenFieldTag(name="type", value="person")#
			#hiddenFieldTag(name="username", value=session.auth.username)#
			#selectTag(name="newuserId", options=people, includeBlank="-Select one person-", valuefield="id", textfield="selectname")#
			#submitTag("Share this tag")#
			#endFormTag()#
		</p>
		<p>This tag list will not sync with the shared list when you make changes.  However, re-sharing this tag list will update the shared tag list.</p>
	
	</div>	
		
	
		</cfoutput>		

</div>