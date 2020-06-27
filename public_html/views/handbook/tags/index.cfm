<cfparam name="previousTag" type="string" default="">
<h1 class="text-center">My Tags</h1>

<cfif handbooktags.recordcount>
	<p class="text-center">
		<cfif !isDefined("params.list")>
			<cfoutput>#linkTo(text="Show as list", params="list", class="btn")#</cfoutput>
		<cfelse>
			<cfoutput>#linkTo(text="Show as Cloud", params="", class="btn")#</cfoutput>
		</cfif>
	</p>
</cfif>

<div class="postbox offset1" id="tags">

<cfif handbooktags.recordcount>

<p>
   Tag people or organizations to create teams or lists of people.  You can create simple emails to this list in your email client or download a spreadsheet of their information.
</p>



<cfoutput query="handbookTags" group="tag" groupcasesensitive=false>
<cfset count = 0>

	<cfoutput>
		<cfset count=count+1>
	</cfoutput>
	<cfif len(tag)>
		<span style="white-space: nowrap" class="ajaxdelete">
		#linkTo(text="#tag#[#count#]", action="show", key=tag, class="btn btn-medium")#
		#linkTo(
			text="<span style='color:grey'><sup>x</sup></span>", 
			route="HandbookRemove", 
			params="tag=#tag#",
			class="tooltipside",
			title="Delete tag: #tag#",
			confirm="Are you sure?",
			class="ajaxdelete"
)#
		</span>
		<cfif isDefined("params.list")>
			<br/>
		<cfelse>
			&nbsp;
		</cfif>
	</cfif>	

</cfoutput>
<cfelse>
<div class="well">

  <p>You do not have any tags set up yet!</p></br>
  <p>Tags are a way to "tag" people or organizations to create your own groups or people, churches or ministries.</p></br>
  <p>Use the forms below to create a tag.  Or go to each person's page that you want to tag.  Using the yellow box, enter a tag using any combination of letters or numbers that are meaningful to you. Use this page to view and manage your tags.</p>  

</div>
</cfif>
<hr />
<cfoutput>

<div class="row">
	<div class="well span3">
		<p>
			#startFormTag(action="create")#
			#textFieldTag(name="tags", label="Tag a person:", placeholder="tag name")#
			#hiddenFieldTag(name="username", value=session.auth.username)#
			#hiddenFieldTag(name="type", value="person")#
			#selectTag(name="itemid", options=people, includeBlank="-Add one person-", valuefield="id", textfield="selectname")#
			#submitTag("Create a people tag")#
			#endFormTag()#
		</p>
	</div>	

	<div class="well span3">
		<p>
			#startFormTag(action="create")#
			#textFieldTag(name="tags", label="Tag an organization:", placeholder="tag name")#
			#hiddenFieldTag(name="username", value=session.auth.username)#
			#hiddenFieldTag(name="type", value="organization")#
			#selectTag(name="itemid", options=organizations, includeBlank="-Add one organization-", valuefield="id", textfield="selectname")#
			#submitTag("Create a ministry tag")#
			#endFormTag()#
		</p>
	</div>	
</div>
</cfoutput>
</div>

