<div class="well" id="courseresourceslist">
<cfoutput>

<h1>
Resources
    <cfif isDefined("Resource.courseTitle") && len(Resource.courseTitle)>
        for #Resource.courseTitle#
    </cfif>
</h1>

#includePartial("showFlash")#</cfoutput>

<form class="form-search">
  <input type="text" class="input-xlarge search-query" name="search"  placeholder="Search All Resources for All Cohorts">
  <button type="submit" class="btn">Search</button>
</form>

<cfif !isDefined("params.courseid")>
	<cfoutput>
		<p>#linkTo(text="New resource", action="new")#</p>
	</cfoutput>
</cfif>

<cfif resources.recordcount>

<cfoutput query="Resources" group="courseid">
    <div class="eachcourseresourced">
		<h2>#linkto(text=title, action="list", params="courseid=#courseid#")#</h2>
		#linkto(text='Create a New Resource for #title#', action="new", params="courseid=#courseid#", class="courseresourcenewlink")#
		<cfoutput>
			<div class="eachcourseresource">

					<cfif isDefined("link") && len(link)>
					<p class="courseresourcelink">
						<span>Link: </span>
						#linkto(text=fixWebSite(link), href=$nameHref(link))#</p>
					</cfif>	
				
					<cfif isDefined("uploaded_file") && len(uploaded_file)>
					<p class="courseresourcefile"><span>Uploaded File: </span>
						#linkTo(text=uploaded_file, href="/files/courseresources/#uploaded_file#")#</p>
					</cfif>

					<cfif isDefined("comment") and len(comment)>
					<div class="courseresourcecomment">
						#comment#
					</div>
					</cfif>

					<p  class="courseresourceauthor"><span>Posted by </span>
						#author# (#mailto(author_email)#) on #dateformat(createdAt)# at #TimeFormat(createdAt)#
					</p>

			</div>
		</cfoutput>
					<p class="courseresourcenew">
						#linkto(text="Create a new resource for #title#", action="new", params="courseid=#courseid#", class="btn btn-block")#	
					</p>
	</div>
	</cfoutput>

<cfelse>
<h2>No Resource for this cohort yet!</h2>
<cfoutput>

	<cftry>
			<p class="courseresourcenew">
				#linkto(text="Create a new resource for this cohort", action="new", params="courseid=#courseid#", class="btn btn-block")#	
			</p>
	<cfcatch>
			<p class="courseresourcenew">
				#linkto(text="Create a new resource", action="new", class="btn btn-block")#	
			</p>
	</cfcatch>
	</cftry>					
<hr/>
</cfoutput>
</cfif>

</div>